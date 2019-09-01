class Category{

  String id;
  String title;
  String color;

  Category(this.id, this.title, this.color);

  Category.fromJson( Map<String,dynamic> jsonObject ){
    this.id = jsonObject['category_id'].toString();
    this.title = jsonObject['category_title'].toString();
    this.color = jsonObject['category_color'].toString();
  }


}