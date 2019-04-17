import 'package:flutter/material.dart';
import 'package:utopian_rocks_demo/blocs/contribution_bloc.dart';
import 'package:utopian_rocks_demo/models/rocks_api.dart';

class ContributionProvider extends InheritedWidget {

  final ContributionBloc contributionBloc;

  static ContributionBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(
          ContributionProvider) as ContributionProvider).contributionBloc;

  ContributionProvider({
    Key key,
    ContributionBloc contributionBloc,
    Widget child,
  }) : this.contributionBloc = contributionBloc ?? ContributionBloc(RocksApi(),
  ), super(child: child, key: key);


  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

}