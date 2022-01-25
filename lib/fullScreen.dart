import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:wallpaper_manager_flutter/wallpaper_manager_flutter.dart';
// import 'package:fluttertoast/fluttertoast.dart';


class FullPage extends StatefulWidget {
  const FullPage({Key? key, required this.imagUrl}) : super(key: key);
  final String imagUrl;

  @override
  _FullPageState createState() => _FullPageState();
}

class _FullPageState extends State<FullPage> {
  //
  // FToast fToast;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   fToast = FToast();
  //   fToast.init(context);
  // }
  //
  // _showToast() {
  //   Widget toast = Container(
  //     padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(25.0),
  //       color: Colors.greenAccent,
  //     ),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: const [
  //         Icon(Icons.check),
  //         SizedBox(
  //           width: 12.0,
  //         ),
  //         Text("This is a Custom Toast"),
  //       ],
  //     ),
  //   );
  //
  //
  //   fToast.showToast(
  //     child: toast,
  //     gravity: ToastGravity.BOTTOM,
  //     toastDuration: Duration(seconds: 2),
  //   );
  //
  //   // Custom Toast Position
  //   fToast.showToast(
  //       child: toast,
  //       toastDuration: Duration(seconds: 2),
  //       positionedToastBuilder: (context, child) {
  //         return Positioned(
  //           child: child,
  //           top: 16.0,
  //           left: 16.0,
  //         );
  //       });
  // }
  //

  Future<void>setWallPaper() async {
    try{
      int location = WallpaperManagerFlutter.HOME_SCREEN;
      var file = await DefaultCacheManager().getSingleFile(widget.imagUrl);

      await WallpaperManagerFlutter()
          .setwallpaperfromFile(file, location)
          .then((value) => print('set'));
    }on Exception catch(e){

    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              height: MediaQuery.of(context).size.height - 60,
              color: Colors.orange,
              child: Image.network(
                widget.imagUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          InkWell(
            onTap: () =>setWallPaper(),
            child: Container(
              height: 50,
              width: double.infinity,
              color: Colors.pink,
              child: const Center(
                child: Text(
                  'Set WallPaper',
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
