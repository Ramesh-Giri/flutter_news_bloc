import 'package:flutter/material.dart';
import 'package:utopian_rocks_demo/blocs/information_bloc.dart';
import 'package:utopian_rocks_demo/models/githug_api.dart';
import 'package:package_info/package_info.dart';

class InformationProvider extends InheritedWidget {

  final InformationBloc informationBloc;

  static InformationBloc of(BuildContext context) =>
      (context.inheritFromWidgetOfExactType(
          InformationProvider) as InformationProvider).informationBloc;

  InformationProvider({
    Key key,
    InformationBloc informationBloc,
    Widget child,
  })
      : this.informationBloc= informationBloc ??
      InformationBloc(PackageInfo.fromPlatform(), GitHubApi(),),
        super(child: child, key: key);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }
}
