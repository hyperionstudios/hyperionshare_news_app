import 'package:flutter/material.dart';
import 'package:hyperionshare_news_app/api/categories_api.dart';
import 'package:hyperionshare_news_app/models/category.dart';
import 'category_posts.dart';

class CategoriesList extends StatefulWidget {
  @override
  _CategoriesListState createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  CategoriesApi categoriesApi = CategoriesApi();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('HyperionShare App'),
      ),
      body: Container(
        padding: EdgeInsets.all(24),
        child: FutureBuilder(
          future: categoriesApi.fetchAllCategories(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Category>> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.active:
              // STILL WORKING
                return _loading();
                break;
              case ConnectionState.waiting:
              // STILL WORKING
                return _loading();
                break;
              case ConnectionState.none:
              // ERROR
                return _error('No Connection has been made');
                break;
              case ConnectionState.done:
              // COMPLETED
                if (snapshot.hasError) {
                  return _error(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  return _drawCategoriesList(snapshot.data, context);
                }
                break;
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _drawCategoriesList(List<Category> categories, BuildContext context) {
    return ListView.builder(
      itemCount: categories.length,
      itemBuilder: (BuildContext context, int position) {
        String hexColor = categories[position].color.replaceAll('#', '0xFF');
        return Card(
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: 2,
                  child: Container(
                    color: Color( int.parse(hexColor) ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CategoryPosts(categories[position].id)));
                },
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(categories[position].title , style: TextStyle(
                      fontSize: 22
                  ),),
                ),
              ),
            ],
          ),
        );
      },
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
}

