import 'dart:convert';
import 'package:http/http.dart' show Client, Response;
import 'model.dart';

class GitHubApi{
  final Client _client = Client();
  static const  String _url = "http://api.github.com/repos/tensor-programming/utopian-rocks-mobile/releases";

  Future<GitHubModel> getReleases() async{
    String resBody = await _client.get(Uri.parse(_url)).then((Response res) => res.body);
    List ghJson = json.decode(resBody);
    var x = ghJson.map((gh)=> GitHubModel.fromJson(gh)).toList();
    return x.first;
  }
}