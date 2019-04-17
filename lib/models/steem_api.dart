import 'dart:convert';
import 'package:http/http.dart' show Client;
import 'package:utopian_rocks_demo/models/model.dart';

class SteemApi {
  final Client _client = Client();
  static const String _url = "https://steemit.com/@utopian-io.json";
  static double totalVp;
  static SteemResponse resp;
  static Duration dateTime;

  Future<void> getResponse() async {
    resp = await _client
        .get(Uri.parse(_url))
        .then((res) => res.body)
        .then(json.decode)
        .then((json) => SteemResponse.fromJson(json["user"]));
  }

  double calculateVotingPower(int x) {
    if (x % 120 == 0) {
      getResponse();
    }

    if (totalVp > 100.00 ) {
      return 100.00;
    } else {
      return totalVp;
    }
  }

  int getRechargeTime(int x) {
    if (dateTime == null || x % 120 == 0) {
      dateTime = DateTime.now().toUtc().difference(
            DateTime.parse(resp.lastVoteTime),
          );
    }

    int counter = x % 120;

    double regenVp = ((dateTime.inSeconds * 1000) / 86400) /5;
    totalVp = (resp.votingPower + regenVp) / 100;

    double missingVp = (100.0 - totalVp);
    if(missingVp < 0){
      return 0;
    }else{
      return (((missingVp * 432000) * 1000 ~/ 1000) -counter).toInt();
    }
  }
}
