import 'dart:convert';
import 'dart:io';

import 'package:core_ball_flutter_workshop/models/newsApi.dart';
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';

class FeedModel extends Model {
  bool _isLoading;
  bool get isLoading => _isLoading;

  List<Articles> _data = <Articles>[];
  List<Articles> get getData => _data;

  File _image = null;
  File get getImage => _image;

  Future<void> fetchNews() async {
    _isLoading = true;
    final response = await http.get(
        'https://newsapi.org/v2/top-headlines?sources=football-italia&apiKey=0399eeb6129b428b96a4720355a0ffa2');
    var responseJson = json.decode(response.body);
    NewsApi newsResponse = NewsApi.fromJson(responseJson);
    _data = newsResponse.articles;
    _isLoading = false;
    notifyListeners();
  }
}
