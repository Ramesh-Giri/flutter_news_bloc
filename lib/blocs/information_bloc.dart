import 'package:rxdart/rxdart.dart';
import 'package:utopian_rocks_demo/models/model.dart';
import 'package:package_info/package_info.dart';
import 'package:utopian_rocks_demo/models/githug_api.dart';

class InformationBloc {

  final GitHubApi api;
  final Future<PackageInfo> packageInfo;

  Stream<GitHubModel> _releases = Stream.empty();
  Stream<PackageInfo> _infoStream = Stream.empty();

  Stream<GitHubModel> get releases => _releases;
  Stream<PackageInfo> get infoStream => _infoStream;

  InformationBloc(this.packageInfo, this.api){
    _releases = Observable.defer(
        () => Observable.fromFuture(api.getReleases()).asBroadcastStream(),
      reusable: true,
    );

    _infoStream = Observable.defer(
        () => Observable.fromFuture(packageInfo).asBroadcastStream().asBroadcastStream(),
      reusable: true,
    );

  }

  void dispose(){
    print("Dispose of Information Bloc");
  }
}