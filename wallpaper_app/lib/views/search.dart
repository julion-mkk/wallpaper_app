import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/photoModel.dart';
import 'package:wallpaper_app/widgets/widgets.dart';
import 'package:wallpaper_app/data/api_data.dart';

class Search extends StatefulWidget {
    final String search;
    Search({this.search});
    SearchState createState()=> SearchState();
}

class SearchState extends State<Search> {
    List<PhotoModel> photos= new List();
    void initState() {
        super.initState();
        searchController.text= widget.search;
        searchWallpapers(searchController.text);
    }

    searchWallpapers(String stringQuery) async {
        Wallpaper wallpaper=new Wallpaper();
        await wallpaper.getSearchedWallpaper(stringQuery);
        photos = wallpaper.photos;
        setState(() {});
    }

    TextEditingController searchController= new TextEditingController();
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                iconTheme: IconThemeData(
                    color: Colors.black,
                ),
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                brightness: Brightness.light,
                title: brandName(),
                actions: [
                    Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Icon(Icons.add,
                        color: Colors.white10,),
                    )
                ],
            ),
            body: SingleChildScrollView(
                child: Column(
                    children: <Widget>[
                        Container(
                            decoration: BoxDecoration(
                                color: Color(0xfff5f8fd),
                                borderRadius: BorderRadius.circular(30),
                            ),
                            margin: EdgeInsets.symmetric(horizontal: 24),
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            child: Row(
                                children: <Widget>[
                                    Expanded(
                                        child: TextField(
                                            controller: searchController,
                                            decoration: InputDecoration(
                                                hintText: 'Search Wallpapers',
                                                border: InputBorder.none,
                                            ),
                                        ),
                                    ),
                                    InkWell(
                                        onTap: () {
                                            if(searchController.text != '') {
                                                Navigator.push(context,MaterialPageRoute(
                                                    builder: (context)=> Search(
                                                        search: searchController.text,
                                                    )
                                                ));
                                            }
                                        },
                                        child: Container(child: Icon(Icons.search),),
                                    )
                                ],
                            ),
                        ),
                        wallPaperList(
                            wallpapers: photos,
                            context: context
                        )
                    ],
                )
            )
        );
    }
}