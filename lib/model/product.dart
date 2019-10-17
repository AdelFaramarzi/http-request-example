class Products{
  int id;
  int userId;
  String title;
  String body;
  String image;
  String price;
  DateTime createAt;
  DateTime updateAt;

  Products.fromjson(Map<String , dynamic> paresJson){
    id = paresJson['id'];
    userId = paresJson['userId'];
    title = paresJson['title'];
    body = paresJson['body'];
    image = paresJson['image'];
    price = paresJson['price'];
    createAt = paresJson['createAt'];
    updateAt = paresJson['updateAt'];
  }
}