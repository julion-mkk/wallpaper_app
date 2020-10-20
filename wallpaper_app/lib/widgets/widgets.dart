import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photoModel.dart';
import 'package:wallpaper_app/views/image_view.dart';
Widget brandName() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
            Text('Wallpaper',style:TextStyle(
                color: Colors.black87, fontFamily: 'Overpass'
            ),),
            Text('Hub',style: TextStyle(
                color: Colors.blue, fontFamily: 'Overpass'
            ),)
        ],
    );
}

Widget wallPaperList({List<PhotoModel> wallpapers,context}) {


    return Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: 0.6,
            crossAxisCount: 2,
            crossAxisSpacing: 6,
            mainAxisSpacing: 6,
            physics: ClampingScrollPhysics(),
            children: wallpapers.map((wallpaper) {
                return GridTile(
                    child: GestureDetector(
                        onTap: () {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> ImageView(
                                    imageUrl : wallpaper.src.portrait
                                )
                            ));
                        },
                        child: Hero(
                            tag: wallpaper.src.portrait,
                            child: Container(
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: kIsWeb ? Image.network(
                                        wallpaper.src.portrait,
                                        width: 50,
                                        height: 100,
                                        fit: BoxFit.cover,
                                    ) : CachedNetworkImage(
                                        imageUrl: wallpaper.src.portrait,
                                        placeholder: (context,url)=> Container(
                                            color: Color(0xfff5f8fd),
                                        ),
                                        fit: BoxFit.cover,
                                    )
                                ),
                            ),
                        ),
                    ),
                );
            }).toList(),
        ),
    );
}