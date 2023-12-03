import 'package:dio/dio.dart';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageView extends StatelessWidget {
  final String? image;

  // void saveImage(path) async {
  //   await ImageDownloader.downloadImage(path);
  // }
  _saveNetworkImage(path) async {

    final result = await ImageGallerySaver.saveImage(
        path,
        quality: 60,
        name: "hello");
    print(result);
  }
  const ImageView({super.key, required this.image});

  @override
  Widget build(BuildContext context) {

    // void _saveImage(path) async{
    //   await GallerySaver.saveImage(path).then((bool success) {
    //     setState(() {
    //       print('Image is saved');
    //     });
    //   });
    // }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          PopupMenuButton(
            child: Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                // onTap: (){
                //
                // },
                child: Text('Save'),
                value: 'save',
              ),
            ],
            onSelected: (value) async {
              if (value == 'save')  {

                // FlutterDownloader.enqueue(url: image!, savedDir: savedDir)

                DateTime now = DateTime.now();
                var status = await Permission.storage.request();
                if(status.isGranted){
                  var response = await Dio().get(image!, options: Options(responseType: ResponseType.bytes));
                  final result = await ImageGallerySaver.saveImage(Uint8List.fromList(response.data), quality: 60, name: 'pulse_$now', isReturnImagePathOfIOS: true);
                }

              } else {
              }
            },
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: image != null
                ? DecorationImage(
                image: AssetImage(
                    '$image'))
                : null,
            backgroundBlendMode: BlendMode.darken,
            color: Colors.black38),
      ),
    );
  }
}