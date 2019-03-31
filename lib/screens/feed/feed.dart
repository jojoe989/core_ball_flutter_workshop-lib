import 'dart:convert';
import 'dart:io';

import 'package:core_ball_flutter_workshop/models/feedModel.dart';
import 'package:core_ball_flutter_workshop/models/newsApi.dart';
import 'package:core_ball_flutter_workshop/screens/feed/feed_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

class Feed extends StatefulWidget {
  @override
  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  // List<News> _data;
  FeedModel feedModel;
  // bool _isLoading;

  // List<Articles> _data;
  File _image;

  @override
  void initState() {
    super.initState();
    // _data = [
    //   News('https://static.siamsport.co.th/news/2019/03/31/news201903310908483.jpg', 'เปิดออปชั่นพิเศษแมนยูมีสิทธิ์คว้า"ซาฮา"ได้ถูกกว่าทีมอื่น', DateTime.now(),
    //       'เป็นที่คาดกันว่าโซลชา วางเป้าหมายเสริมทัพหลายคนในช่วงซัมเมอร์นี้ ซึ่งหนึ่งในนั้นมีชื่อของวิลฟรีด ซาฮา ปีกทีมชาติไอวอรี่ โคสต์ โดยทั้งคู่เคยร่วมงานกันสมัยที่กุนซือนอร์วีเจี้ยนคุมคาร์ดิฟฟ์ ซิตี้ เมื่อปี 2014 และหากแมนฯยูไนเต็ด ต้องการจะคว้าตัวเด็กเก่ารายนี้กลับคืนจริงก็จะซื้อได้ในราคาที่ถูกกว่าทีมอื่น สื่อดังกล่าว ระบุว่า ภายใต้ข้อตกลงที่คริสตัล พาเลซ ทำไว้กับแมนฯยูไนเต็ด บอกไว้ว่า หากดิ อีเกิ้ลส์ ขายวิลฟรีด ซาฮา ออกไป เงินที่ได้จากค่าตัวของปีกรายนี้นั้น จะต้องแบ่งให้กับทัพปีศาจแดง 25 % นั่นหมายความว่า หากแมนยูต้องการที่จะได้ตัวซาฮา ก็จะจ่ายค่าตัวในราคาที่ถูกกว่าทีมอื่นยื่นซื้อ 25% ซึ่งคาดว่าขณะนี้มูลค่าของซาฮา สูงถึง 70 ล้านปอนด์ หรือราว 2,870 ล้านบาท โดยหากอ้างอิงจากราคานี้ แมนฯยูไนเต็ด จะสามารถซื้อกลับได้เพียง 52.5 ล้านปอนด์ หรือราว 2,152 บาท ซึ่งถูกลงจากเดิมถึง 17.5 ล้านปอนด์เลยทีเดียว  ทั้งนี้ ซาฮา ย้ายมาเล่นกับแมนฯยูไนเต็ด เมื่อเดือนมกราคม ปี 2013 ด้วยค่าตัวแต่ 15 ล้านปอนด์ แต่ไม่สามารถแจ้งเกิดได้เลย ภายใต้การคุมทีมของเดวิด มอยส์ ก่อนที่จะถูกขายคืยกลับไปให้คริสตัล พาเลซ ในราคาขาดทุนกว่า 9 ล้านปอนด์ ซึ่งจนถึงปัจจุบัน ซาฮา พัฒนาฝีเท้าขึ้นมาจนได้รับการยกย่องว่าเป็นหนึ่งในผู้เล่นที่มีทักษะการเลี้ยงบอลดีที่สุดในพรีเมียร์ลีกอังกฤษเลยทีเดียว'),
    //   News('https://static.siamsport.co.th/news/2019/03/31/news20190331055082.jpg', '3 แต้มเท่านั้น! ลิเวอร์พูลล่าแชมป์จัด"มาเน่"ต้อนรับสเปอร์ส', DateTime.now(),
    //       'เจอร์เก้น คล็อปป์ กุนซือ ''หงส์แดง'' ไม่มีทางเลือกนอกจากคว้า 3 คะแนนเพื่อแซง แมนฯซิตี้ ขึ้นจ่าฝูงแม้จะแข่งมากกว่า 1 นัด ความพร้อมต้อง เช็กความฟิต เทรนท์ อเล็กซานเดอร์-อาร์โนลด์ ส่วนแนวรุกจัดเต็ม นำโดย ซาดิโอ มาเน่ ทางด้าน "ไก่เดือยทอง" สเปอร์ส ต้องเร่งฟอร์ม แถม ผลงานนนอกบ้านไม่ดี มี แฮร์รี่ เคน เป็นแข้งทีเด็ด ในศึกฟุตบอล พรีเมียร์ลีก อังกฤษ คืนวันอาทิตย์ที่ 31 มี.ค. นี้'),
    // ];
    // _isLoading = true;
    // isLoading();
    // _fetchNews();
    feedModel = ScopedModel.of<FeedModel>(context);
    feedModel.fetchNews();
  }

  // Future<void> _fetchNews() async {
  //   setState(() {
  //     _isLoading = true;
  //   });
  //   final response = await http.get(
  //       'https://newsapi.org/v2/top-headlines?sources=football-italia&apiKey=0399eeb6129b428b96a4720355a0ffa2');
  //   var responseJson = json.decode(response.body);
  //   NewsApi newsResponse = NewsApi.fromJson(responseJson);
  //   setState(() {
  //     _data = newsResponse.articles;
  //     _isLoading = false;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FeedModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text(
                'Core Ball',
              ),
            ),
            actions: <Widget>[
              IconButton(
                icon: CircleAvatar(
                  child: _image == null
                      ? IconButton(
                          icon: Icon(Icons.camera),
                          onPressed: getImage,
                        )
                      : Image.file(_image),
                ),
                tooltip: 'icon',
                onPressed: () => getImage(),
              ),
            ],
          ),
          body: feedModel.isLoading
              ? buildLoading()
              : Container(
                  child: RefreshIndicator(
                    onRefresh: feedModel.fetchNews,
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                      itemCount: model.getData?.length,
                      itemBuilder: (context, index) {
                        final Articles newsData = model.getData[index];
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              onPressed(newsData);
                            },
                            child: Card(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Image(
                                    // image: AssetImage(newsData.imageUrl),
                                    // image: NetworkImage(newsData.imageUrl),
                                    image: NetworkImage(newsData.urlToImage),
                                    fit: BoxFit.contain,
                                  ),
                                  Text(
                                    newsData.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        newsData.publishedAt,
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Icon(Icons.more_vert),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
          bottomNavigationBar:
              BottomNavigationBar(items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.assistant),
              title: Text('New Feeds'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.work),
              title: Text('Headline'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star),
              title: Text('Favorite'),
            )
          ]),
        );
      },
    );
  }

  onPressed(Articles data) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => FeedDetail(data)));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  // Future isLoading() async {
  //   bool isLoading = await Future.delayed(Duration(seconds: 2), () => false);
  //   setState(() {
  //     _isLoading = isLoading;
  //   });
  //   // return isLoading;
  // }

  Future getImage() async {
    var image = await ImagePicker.pickImage(
      source: ImageSource.camera,
    );

    setState(() {
      _image = image;
    });
  }
}
