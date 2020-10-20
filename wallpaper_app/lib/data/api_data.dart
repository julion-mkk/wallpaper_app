import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wallpaper_app/models/photoModel.dart';
import 'package:flutter/material.dart';

class Wallpaper {
    String apiKEY='563492ad6f917000010000014ac3da85f7cc4cb6b0cc4467d12b65d3';
    int noOfImageToLoad=30;
    List<PhotoModel> photos= new List();

    getTrendingWallpaper() async {
        await http.get('https://api.pexels.com/v1/curated?per_page=$noOfImageToLoad&page=1',
        headers: {"Authorization": apiKEY}).then((value) {
            Map<String,dynamic> rawJson= jsonDecode(value.body);
            rawJson["photos"].forEach((element) {
                PhotoModel photoModel= new PhotoModel();
                photoModel = PhotoModel.fromMap(element);
                photos.add(photoModel);
            });
        });
    }

    getSearchedWallpaper(String searchQuery) async {
        await http.get("https://api.pexels.com/v1/search?query=$searchQuery&per_page=30&page=1",
        headers: {"Authorization": apiKEY}).then((value) {
            Map<String,dynamic> jsonData = jsonDecode(value.body);
            jsonData['photos'].forEach((element) {
                PhotoModel photoModel = new PhotoModel();
                photoModel = PhotoModel.fromMap(element);
                photos.add(photoModel);
            });
        });
    }

    getCategoryWallpaper(String category) async {
        await http.get("https://api.pexels.com/v1/search?query=$category&per_page=30&page=1",
        headers: {'Authorization': apiKEY}).then((value) {
            print(value.body);
            Map<String,dynamic> jsonData= jsonDecode(value.body);
            jsonData['photos'].forEach((element) {
                PhotoModel photoModel = new PhotoModel();
                photoModel = PhotoModel.fromMap(element);
                photos.add(photoModel);
            });
        });
        print('PHOTOS::: ${photos[0].src.portrait}');
    }
}