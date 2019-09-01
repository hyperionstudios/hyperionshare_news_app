import 'package:hyperionshare_news_app/models/author.dart';

class PostComment {
  String comment_id , comment;
  Author author;

  PostComment(this.comment_id, this.comment, this.author);

  PostComment.fromJson( Map<String,dynamic> jsonObject ){
    this.comment_id = jsonObject['comment_id'].toString();
    this.comment = jsonObject['comment'];
    this.author = Author.fromJson( jsonObject['author'] );
  }


}