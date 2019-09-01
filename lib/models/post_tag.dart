class PostTag {

  String tag_id , tag;

  PostTag(this.tag_id, this.tag);

  PostTag.fromJson( Map<String,dynamic> jsonObject ){
    this.tag_id = jsonObject['tag_id'].toString();
    this.tag = jsonObject['tag'].toString();
  }


}