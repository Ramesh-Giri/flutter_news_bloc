import 'package:flutter/material.dart';
import 'package:utopian_rocks_demo/blocs/information_bloc.dart';
import 'package:utopian_rocks_demo/providers/base_provider.dart';
import 'package:utopian_rocks_demo/utils.dart';
class InformationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      semanticLabel: 'Information Drawer',
      child: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          _buildInfoPanel(context),
        ],
      ),
    );
  }

  Widget _buildInfoPanel(BuildContext context) {
    final informationBloc = Provider.of<InformationBloc>(context);
    return Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 30.0),
            width: MediaQuery.of(context).size.width,
            color: Color(0xFF24292e),
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Information",
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          StreamBuilder(
            stream: informationBloc.infoStream,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  _buildInfoTile(
                    "${snapshot.data.appName}",
                    subTitle: "Pre-release version Number : ${snapshot.data.version}",
                  ),
                  _buildInfoTile(
                    "Instructions",
                    subTitle: "Double tap on a contribution to open it on a browser",
                  ),

                  _buildInfoTile(
                    "Author and application info.",
                    subTitle: "Developed by Ramesh Giri. Many thanks to tensor Programming for the suppory",
                  ),

                  RaisedButton(
                    child: Text("Check for Update"),
                    onPressed: ()=> _getNewRelease(context, snapshot),
                  )
                ],
              );
            },
          )
        ],

    );
  }

  Widget _buildInfoTile(String title, {String subTitle}) {
    return ListTile(
      title: Text(title, textAlign: TextAlign.start, style:  TextStyle( fontSize: 18.0, fontWeight: FontWeight.bold),),
      subtitle: Text(subTitle ?? "", textAlign: TextAlign.start, style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600)),
    );
  }

  void _getNewRelease(BuildContext context, AsyncSnapshot snapshot){
    final informationBloc = Provider.of<InformationBloc>(context);
    informationBloc.releases.listen((releases){
        if(snapshot.data.version.toString() != releases.tagName){
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("${snapshot.data.appName}"),
                content: Container(
                  child: Text('A new version of this application is available for download.'),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Download"),
                    onPressed: () => launchUrl(releases.htmlUrl),
                  )
                ,
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.of(context).pop(),
                  )],
              )
            );
        }else{
          showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("${snapshot.data.appName}"),
                content: Container(
                  child: Text('There is no new version at this time.'),
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Close"),
                    onPressed: () => Navigator.of(context).pop(),
                  )],
              )
          );
        }
    });
  }
}
