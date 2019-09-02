import 'package:flutter/material.dart';
import 'package:hyperionshare_news_app/api/categories_api.dart';
import 'package:hyperionshare_news_app/models/post.dart';
import 'package:hyperionshare_news_app/shared_ui/list_posts.dart';

class CategoryPosts extends StatefulWidget {

  final String categoryID;

  CategoryPosts(this.categoryID);

  @override
  _CategoryPostsState createState() => _CategoryPostsState();
}

class _CategoryPostsState extends State<CategoryPosts> {

  CategoriesApi categoriesApi = CategoriesApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News'),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: FutureBuilder(
          future: categoriesApi.fetchPostsForCategory( widget.categoryID ),
          builder: ( BuildContext context , AsyncSnapshot<List<Post>> snapshot ){
            switch ( snapshot.connectionState ){
              case ConnectionState.none:
                return _error( 'No Connection made' );
                break;
              case ConnectionState.waiting:
              case ConnectionState.active :
                return _loading();
                break;
              case ConnectionState.done :
                if( snapshot.hasError ){
                  return _error( snapshot.error.toString() );
                }
                if( snapshot.hasData ){
                  return _drawPostsList( snapshot.data );
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text( error , style: TextStyle( color: Colors.red ), ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _drawPostsList(List<Post> posts) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: posts.length,
        itemBuilder: ( BuildContext context , int position ){
          return PostCard( posts[position] );
        },
      ),
    );
  }
}
