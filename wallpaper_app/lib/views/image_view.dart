import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class ImageView extends StatefulWidget {
    final String imageUrl;
    ImageView({this.imageUrl});
    ImageViewState createState()=> ImageViewState();
}

class ImageViewState extends State<ImageView> {
    bool loading;
    Widget build(BuildContext context) {
        return Scaffold(
            body: Stack(
                children: [
                    Hero(
                        tag: widget.imageUrl,
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: kIsWeb ? Image.network(
                                widget.imageUrl,
                                fit: BoxFit.cover,
                            ) : CachedNetworkImage(
                                imageUrl: widget.imageUrl,
                                placeholder: (context,url)=> Container(
                                    color: Color(0xfff5f8fd),
                                ),
                                fit: BoxFit.cover,
                            ),
                        ),
                    ),
                    Container(
                        height: MediaQuery.of(context).size.height,
                        width: MediaQuery.of(context).size.width,
                        alignment: Alignment.bottomCenter,
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                                InkWell(
                                    onTap: () {
                                        flushBar(context);

                                    },
                                    child: Stack(
                                        children: [
                                            Container(
                                                width: MediaQuery.of(context).size.width/2,
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                    color: Color(0xff1C1B1B).withOpacity(0.8),
                                                    borderRadius: BorderRadius.circular(30)
                                                ),
                                            ),
                                            Container(
                                                width: MediaQuery.of(context).size.width/2,
                                                height: 50,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.white24, width: 1),
                                                    borderRadius: BorderRadius.circular(30),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                            Color(0x36FFFFFF),
                                                            Color(0x0FFFFFFF)
                                                        ],
                                                        begin: FractionalOffset.topLeft,
                                                        end: FractionalOffset.bottomRight
                                                    )
                                                ),
                                                child: Column(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                        Text('Save Image', style: TextStyle(
                                                            color: Colors.white70,
                                                            fontSize: 15,
                                                            fontWeight: FontWeight.w500,
                                                        ),),
                                                        SizedBox(
                                                            height: 1,
                                                        ),
                                                        Text(kIsWeb ? 'Image will open a new tab to download' : 'Image will save to gallary',style: TextStyle(
                                                            fontSize: 8, color: Colors.white
                                                        ),),
                                                    ],
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                SizedBox(
                                    height: 16,
                                ),
                                InkWell(
                                    onTap: () {
                                        Navigator.pop(context);
                                    },
                                    child: Text('Cancel', style: TextStyle(
                                        color: Colors.white60,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16
                                    ),),
                                ),
                                SizedBox(height: 50,),
                            ],

                        ),
                    )
                ],
            ),
        );
    }

     _saved() async {
        print('hello _saved');
        await _askedPermission();
        var response = await Dio().get(widget.imageUrl,
            options: Options(responseType: ResponseType.bytes));
        final result =
        await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text("Image is saved"),));
        print('result haps : $result');
        Navigator.pop(context);
    }

    _askedPermission() async {
        if(Platform.isIOS) {
            await PermissionHandler().requestPermissions([PermissionGroup.photos]);
        } else {
            await PermissionHandler().requestPermissions([PermissionGroup.storage]);
        }
    }

    flushBar(BuildContext context) {
        _saved();
        Flushbar(
            message: "Image is saved",
            duration: Duration(seconds: 3),
            flushbarPosition: FlushbarPosition.BOTTOM,
        )..show(context);
    }
}
