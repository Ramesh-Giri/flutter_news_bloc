import 'package:flutter/material.dart';
import 'package:utopian_rocks_demo/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_demo/models/model.dart';
import 'package:utopian_rocks_demo/utils.dart';

class ListPage extends StatelessWidget {
  final ContributionBloc bloc;
  final String pageName;

  ListPage(this.pageName, this.bloc);

  @override
  Widget build(BuildContext context) {
    bloc.pageName.add(pageName);
    return StreamBuilder(
      stream: bloc.filteredResult,
      builder:
          (BuildContext context, AsyncSnapshot<List<Contribution>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(itemCount: snapshot.data.length ,itemBuilder: (context, index) {
          int iconCode = getIcons(snapshot, index);
          Color catColor = getCategoryColor(snapshot, index);
          String repo= checkRepo(snapshot, index);
          String timeStamp= convertTimeStamp(snapshot, index, pageName);

          return GestureDetector(
            onTap: () => launchUrl(snapshot.data[index].url),
            child: ListTile(
              leading: CircleAvatar(
                child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            'https://steemitimages.com/u/${snapshot.data[index].author}/avatar',
                          ))),
                ),
                backgroundColor: Colors.white,
              ),
              title: Text(
                "${snapshot.data[index].title}",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
              subtitle: Text(
                "$repo - $timeStamp",
                style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w200),
              ),
              trailing: Icon(
                IconData(iconCode ?? 0x0000, fontFamily: 'Utopicons', ),
                color: catColor ?? Color(0xFFB10DC9),
              ),
            ),
          );
        });
      },
    );
  }
}
