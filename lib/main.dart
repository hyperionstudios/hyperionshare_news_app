import 'dart:io';

import 'package:flutter/material.dart';
import 'api/categories_api.dart';
import 'models/category.dart';
import 'screens/category_posts.dart';
import 'screens/home_screen.dart';
import 'screens/categories_list.dart';

void main() {
  runApp(HyperionShareApp());
}

class HyperionShareApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.teal,
      ),
      routes: {
        '/'   : ( BuildContext context ) => HomeScreen(),
        '/categories' : ( BuildContext context ) => CategoriesList(),
      },
    );
  }
}

/*
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CategoriesApi categoriesApi = CategoriesApi();

  @override
  void initState() {
    super.initState();
  }

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
        return InkWell(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(categories[position].title),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        CategoryPosts(categories[position].id)));
          },
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
*/