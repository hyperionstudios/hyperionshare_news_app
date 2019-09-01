class Author{
  String author_id , first_name, last_name, author_email , avatar;

  Author(this.author_id, this.first_name, this.last_name, this.author_email,
      this.avatar);

  Author.fromJson( Map<String,dynamic> jsonObject ){
    this.author_id = jsonObject['author_id'].toString();
    this.first_name = jsonObject['first_name'];
    this.last_name = jsonObject['last_name'];
    this.author_email = jsonObject['author_email'];
    this.avatar = jsonObject['avatar'];
  }


}
