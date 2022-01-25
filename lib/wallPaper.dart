import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/fullScreen.dart';

class WallPaper extends StatefulWidget {
  WallPaper({Key? key}) : super(key: key);

  @override
  _WallPaperState createState() => _WallPaperState();
}

class _WallPaperState extends State<WallPaper> {
  @override
  void initState() {
    super.initState();
    fetchAPI();
  }

  List imageList = [];
  int pages = 1;
  fetchAPI() async {
    await http.get(Uri.parse('https://api.pexels.com/v1/curated?per_page=80'),
        headers: {
          'Authorization':
              '563492ad6f91700001000001826f477eb0e64486844d43e84d08591b'
        }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        imageList = result['photos'];
      });
      // print(result);
      // print(imageList);
      // print(imageList[0]['src']['tiny']);
    });
  }

  loadMore() async {
    setState(() {
      pages++;
    });
    String url =
        'https://api.pexels.com/v1/curated?per_page=80&' + 'page=$pages';
    await http.get(Uri.parse(url), headers: {
      'Authorization':
          '563492ad6f91700001000001826f477eb0e64486844d43e84d08591b'
    }).then((value) {
      Map result = jsonDecode(value.body);
      setState(() {
        imageList.addAll(result['photos']);
      });
      // print(result);
      print(imageList.length);
      // print(imageList[0]['src']['tiny']);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: GridView.builder(
                  itemCount: imageList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 3,
                      childAspectRatio: 2 / 3,
                      mainAxisSpacing: 3),
                  itemBuilder: (context, i) {
                    return Container(
                      // color: Colors.yellow,
                      child: InkWell(
                        onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>FullPage(imagUrl: '${imageList[i]['src']['large2x']}',))),
                        child: Image.network(
                          '${imageList[i]['src']['tiny']}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  }),
            ),
          ),
          InkWell(
            onTap: () => loadMore(),
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.pink,
              child: Center(
                child: const Text(
                  'Load More',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
