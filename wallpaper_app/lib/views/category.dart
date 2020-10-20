import 'package:flutter/material.dart';
import 'package:wallpaper_app/data/api_data.dart';
import 'package:wallpaper_app/models/photoModel.dart';
import 'package:wallpaper_app/widgets/widgets.dart';

class CategoryScreen extends StatefulWidget {
    final String category;
    CategoryScreen({this.category});
    CategoryScreenState createState()=> CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
    List<PhotoModel> photos= new List();
    void initState() {
        super.initState();
        getCategoryWallpaper(widget.category);
    }

    getCategoryWallpaper(String category) async {
        Wallpaper wallpaper = new Wallpaper();
        await wallpaper.getCategoryWallpaper(category);
        photos = wallpaper.photos;
        setState(() {});
    }

    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: brandName(),
                elevation: 0.0,
                backgroundColor: Colors.transparent,
                brightness: Brightness.light,
                iconTheme: IconThemeData(
                    color: Colors.black,
                ),
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