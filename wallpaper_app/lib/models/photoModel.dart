class PhotoModel {
    String url;
    String photographer;
    String photographerUrl;
    int photographerId;
    SrcModel src;

    PhotoModel({this.url,this.photographer,this.photographerId,this.photographerUrl,this.src});

    factory PhotoModel.fromMap(Map<String,dynamic> srcJson) {
        return PhotoModel(
            url: srcJson['url'],
            photographer: srcJson['photographer'],
            photographerId: srcJson['photographer_id'],
            photographerUrl: srcJson['photographer_url'],
            src: SrcModel.fromMap(srcJson["src"]));
    }

    /*@override
    String toString() {
        return url+photographerUrl;
    }*/
}

class SrcModel {
    String portrait;
    String large;
    String landScape;
    String medium;

    SrcModel({this.portrait,this.large,this.landScape,this.medium});

    factory SrcModel.fromMap(Map<String,dynamic> srcJson) {
        return SrcModel(
            portrait: srcJson['portrait'],
            landScape: srcJson["landscape"],
            large: srcJson["large"],
            medium: srcJson["medium"]
        );
    }

    /*@override
    String toString() {
    // TODO: implement toString
    return portrait;
  }*/
}