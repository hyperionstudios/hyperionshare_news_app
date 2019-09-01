import 'package:hyperionshare_news_app/models/author.dart';
import 'package:hyperionshare_news_app/models/category.dart';
import 'package:hyperionshare_news_app/models/post_comment.dart';
import 'package:hyperionshare_news_app/models/post_image.dart';
import 'package:hyperionshare_news_app/models/post_tag.dart';

class Post {

  String post_id , post_title , post_content , post_type ;
  String updated_at;
  List<PostImage> images;
  Category category;
  Author author;
  List<PostTag> tags;
  List<PostComment> comments;

  Post(this.post_id, this.post_title, this.post_content, this.post_type,
      this.updated_at, this.images, this.category, this.author, this.tags,
      this.comments);

  Post.fromJson( Map<String,dynamic> jsonObject ){
    this.post_id = jsonObject['post_id'].toString();
    this.post_title = jsonObject['post_title'];
    this.post_content = jsonObject['post_content'];
    this.post_type = jsonObject['post_type'];
    this.updated_at = jsonObject['updated_at'];
    this.images = [];
    for( var item in jsonObject['images'] ){
      images.add( PostImage.fromJson( item   ) );
    }
    this.category = Category.fromJson(jsonObject['category']);
    this.author = Author.fromJson(jsonObject['author']);
    this.tags = [];
    for(  var item in jsonObject['tags'] ){
      this.tags.add(  PostTag.fromJson(item ) );
    }
    this.comments = [];
    for( var item in jsonObject['comments'] ){
      this.comments.add( PostComment.fromJson( item) );
    }
  }


}
