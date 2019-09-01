import 'package:flutter/material.dart';
import 'package:hyperionshare_news_app/api/posts_api.dart';
import 'package:hyperionshare_news_app/models/post.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Post> postsWithImages = [];

  PostsApi postsApi = PostsApi();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Text('Header'),
            ),
            ListTile(
              title: Text('Categories'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.pushNamed(context, '/categories');
              },
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: postsApi.fetchRecentPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapShot) {
          switch (snapShot.connectionState) {
            case ConnectionState.none:
              return _error('No Connection has been made');
              break;
            case ConnectionState.waiting:
            case ConnectionState.active:
              return _loading();
              break;
            case ConnectionState.done:
              if (snapShot.hasError) {
                return _error(snapShot.error);
              }
              if (!snapShot.hasData) {
                return _error('No data fetched yet!');
              }
              return _drawHomeScreen(snapShot.data);
              break;
          }
          return Container();
        },
      ),
    );
  }

  Widget _error(String error) {
    return Container(
      child: Center(
        child: Text(
          error,
          style: TextStyle(color: Colors.red),
        ),
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

  Widget _drawHomeScreen(List<Post> posts) {
    for (Post post in posts) {
      if (post.images.length > 0) {
        postsWithImages.add(post);
      }
    }
    return Column(
      children: <Widget>[
        _slider(postsWithImages),
        _postsList(posts),
      ],
    );
  }

  Widget _slider(List<Post> posts) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      child: PageView.builder(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int position) {
          return InkWell(
            onTap: () {
              // TODO: Go to the single post screen
            },
            child: Stack(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  child: Image(
                    fit: BoxFit.cover,
                    image: NetworkImage(posts[position].images[0].image_url),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(8),
                    margin: EdgeInsets.only(bottom: 8),
                    color: Colors.grey.withAlpha(100),
                    child: Text(
                      posts[position].post_title,
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  _postsList(List<Post> posts) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int position) {
            return Card(
              child: InkWell(
                onTap: () {
                  // TODO : Go to the single post screen
                },
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        posts[position].post_title,
                        style: TextStyle(color: Colors.teal , fontSize: 22),
                      ),
                      SizedBox(height: 18,),
                      Text(
                        ' ${posts[position].author.first_name} ${posts[position].author.last_name}',
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 18
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
