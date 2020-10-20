import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/data.dart';
import 'package:wallpaper_app/models/categoryModel.dart';
import 'package:wallpaper_app/models/photoModel.dart';
import 'package:wallpaper_app/views/category.dart';
import 'package:wallpaper_app/widgets/widgets.dart';
import 'package:wallpaper_app/data/api_data.dart';
import 'package:wallpaper_app/views/search.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class Home extends StatefulWidget {
    _HomeState createState()=> _HomeState();
}

class _HomeState extends State<Home> {
    TextEditingController _searchController= new TextEditingController();
    List<CategoryModel> categories = new List();
    List<PhotoModel> photos = new List();
    String apiKEY='563492ad6f917000010000014ac3da85f7cc4cb6b0cc4467d12b65d3';
    int noOfImageToLoad=30;

    void initState() {
        super.initState();
        categories = getCategories();
        getWallpapers();
    }

    getWallpapers() async {
        Wallpaper wallpapers = new Wallpaper();
        await wallpapers.getTrendingWallpaper();
        photos = wallpapers.photos;

        setState(() { });
    }
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
                title: brandName(),
            ),
            body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff5f8fd),
                                borderRadius: BorderRadius.circular(30.0),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 24.0),
                            padding: EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                                children: <Widget>[
                                    Expanded(
                                        child: TextField(
                                            controller: _searchController,
                                            decoration: InputDecoration(
                                                hintText: 'Search Wallpapers',
                                                border: InputBorder.none
                                            ),
                                        ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                            if(_searchController.text != "") {
                                                Navigator.push(context,MaterialPageRoute(
                                                    builder: (context) {
                                                        return Search(
                                                            search : _searchController.text
                                                        );
                                                    }
                                                ));
                                            }
                                        },
                                        child: Container(child: Icon(Icons.search),),
                                    ),
                                ],
                            ),
                        ),
                        SizedBox(
                            height: 16,
                        ),
                        Container(
                            height: 80,
                            child: ListView.builder(
                                padding: EdgeInsets.symmetric(horizontal: 24),
                                itemCount: categories.length,
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context,index) {
                                    return CategoryTile(title: categories[index].title, imgUrl: categories[index].imageUrl);
                                },
                            ),
                        ),
                        wallPaperList(
                            wallpapers: photos,
                            context: context
                        )
                    ],
                ),
            ),
        );
    }
}

class CategoryTile extends StatelessWidget {
    final String title;
    final String imgUrl;
    CategoryTile({@required this.title, @required this.imgUrl});


    Widget build(BuildContext context) {
        return GestureDetector(
            onTap: () {
                print('onClick $imgUrl');
                print('kIsWeb $kIsWeb');
                Navigator.push( context,MaterialPageRoute(
                    builder:(context) => CategoryScreen(
                        category: title,
                    )
                ));
            },
            child: Container(
                margin: EdgeInsets.only(right: 8),
                child: kIsWeb ? Column(
                    children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: kIsWeb ? Image.network(
                                imgUrl,
                                width: 100,
                                height: 50,
                                fit: BoxFit.cover,
                            ) : CachedNetworkImage(
                                imageUrl: imgUrl,
                                width: 100,
                                height: 50,
                                fit: BoxFit.cover,
                            ),
                        ),
                        SizedBox(
                            height: 4,
                        ),
                        Container(
                            width: 100,
                            alignment: Alignment.center,
                            child: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontFamily: 'Overpass'
                                ),
                            ),
                        )
                    ],
                ) : Stack(
                    children: <Widget>[
                        ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: kIsWeb ? Image.network(
                                imgUrl,
                                width: 100,
                                height: 50,
                                fit: BoxFit.cover,
                            ) : CachedNetworkImage(
                                imageUrl: imgUrl,
                                width: 100,
                                height: 50,
                                fit: BoxFit.cover,
                            ),
                        ),
                        Container(
                            height: 50,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.black26,
                            ),
                        ),
                        Container(
                            height: 50,
                            width: 100,
                            alignment: Alignment.center,
                            child: Text(
                                title ?? 'Yo Yo',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontFamily: 'Overpass',
                                    fontWeight: FontWeight.w500
                                ),
                            ),
                        )
                    ],
                )
            ),
        );
    }
}