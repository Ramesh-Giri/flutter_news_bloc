import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:utopian_rocks_demo/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_demo/blocs/information_bloc.dart';
import 'package:utopian_rocks_demo/blocs/steem_bloc.dart';
import 'package:utopian_rocks_demo/components/information_drawer.dart';
import 'package:utopian_rocks_demo/components/list_page.dart';
import 'package:utopian_rocks_demo/models/githug_api.dart';
import 'package:utopian_rocks_demo/models/rocks_api.dart';
import 'providers/base_provider.dart';
import 'components/bottom_bar.dart';
import 'models/steem_api.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ContributionBloc>(
      builder: (_, bloc) =>
          bloc ??
          ContributionBloc(
            RocksApi(),
          ),
      onDispose: (_, bloc) => bloc.dispose(),
      child: RootApp(),
    );
  }
}

class RootApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final contributionBloc = Provider.of<ContributionBloc>(context);

    return MaterialApp(
      title: "Utopic Rocks Mobile",
      theme: ThemeData(
        primaryColor: Color(0xFF24292e),
        accentColor: Color(0xFF26A69A),
      ),
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          bottomSheet: BlocProvider<SteemBloc>(
            builder: (_, bloc) => bloc ?? SteemBloc(SteemApi()),
              onDispose: (_, bloc) => bloc.dispose(),
              child: BottomBar(contributionBloc)
          ),
          appBar: AppBar(
            title: Flex(
              direction: Axis.horizontal,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  flex: 2,
                  child: Image.asset('assets/images/utopy.png'),
                ),
                Text("Utopic Rocks app")
              ],
            ),
            bottom: TabBar(tabs: <Widget>[
              Tab(
                icon: Icon(Icons.rate_review),
                text: "Waiting for review",
              ),
              Tab(
                icon: Icon(Icons.hourglass_empty),
                text: "Waiting on Upvote",
              ),
            ]),
          ),
          body: TabBarView(
            children: <Widget>[
              ListPage("unreviewed", contributionBloc),
              ListPage("pending", contributionBloc),
            ],
          ),
          endDrawer: BlocProvider<InformationBloc>(
            child: InformationDrawer(),
            builder: (_, bloc) =>
                bloc ??
                InformationBloc(PackageInfo.fromPlatform(), GitHubApi()),
            onDispose: (_, bloc) => bloc.dispose(),
          ),
        ),
      ),
    );
  }
}
