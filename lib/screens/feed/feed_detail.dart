import 'package:core_ball_flutter_workshop/models/news.dart';
import 'package:core_ball_flutter_workshop/models/newsApi.dart';
import 'package:flutter/material.dart';

class FeedDetail extends StatelessWidget {
  // News data;
  Articles data;
  FeedDetail(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image(
                  image: NetworkImage(data.urlToImage),
                ),
                Text(
                  data.title,
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  data.content,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
