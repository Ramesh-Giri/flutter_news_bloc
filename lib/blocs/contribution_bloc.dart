import 'package:utopian_rocks_demo/models/model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:utopian_rocks_demo/models/rocks_api.dart';
import 'package:utopian_rocks_demo/utils.dart';

class ContributionBloc{
  final RocksApi rocksApi;

  Stream<List<Contribution>> _results = Stream.empty();
  //for filter only
  Observable<List<Contribution>> _filteredResults = Observable.empty();


  BehaviorSubject<String> _pageName = BehaviorSubject<String>.seeded('unreviewed');
  //for filter only
  BehaviorSubject<String> _filter = BehaviorSubject<String>.seeded('all');


  Stream<List<Contribution>> get results => _results;
  //for filter only
  Stream<List<Contribution>> get filteredResult => _filteredResults;

  Sink<String> get pageName => _pageName;
  //for filter only
  Sink<String> get filter => _filter;

  ContributionBloc(this.rocksApi){
    _results = _pageName
        .asyncMap((page)=> rocksApi.getContributions(pageName: page))
    .asBroadcastStream();

    _filteredResults = Observable.combineLatest2(_filter, _results, applyFilter).asBroadcastStream();
  }

  void dispose(){
    _pageName.close();
    _filter.close();
  }

}
