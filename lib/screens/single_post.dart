import 'package:flutter/material.dart';
import 'package:hyperionshare_news_app/models/post.dart';
import 'package:hyperionshare_news_app/models/post_comment.dart';

class SinglePostScreen extends StatefulWidget {
  final Post post;

  SinglePostScreen(this.post);

  @override
  _SinglePostScreenState createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 300,
            floating: true,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: widget.post.getPostImage(), fit: BoxFit.cover),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, position) {
              if (position == 0) {
                return Container(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    widget.post.post_content,
                    style: TextStyle(
                      fontSize: 24,
                      letterSpacing: 2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              } else {
                return _commentsWidget( widget.post.comments[position] );
              }
            }, childCount: widget.post.comments.length),
          ),
        ],
      ),
    );
  }

  Widget _commentsWidget( PostComment comment ) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text( comment.comment ),
            Text( comment.author.getAuthorFormattedName() )
          ],
        ),
      ),
    );
  }
}
