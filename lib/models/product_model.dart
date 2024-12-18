class ProductModel {
  int? id;
  String? title;
  String? desc;
  var price;
  String? category;
  String? image;
  RatingModel? ratingModel;

  ProductModel(
      {this.id, this.title, this.category, this.desc, this.image, this.price});

  ProductModel.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    desc = json['description'];
    price = json['price'];
    image = json['image'];
    category = json['category'];
    ratingModel = RatingModel.fromJson(json["rating"]);
  }
}

class RatingModel {
  var rate;
  int? count;

  RatingModel({this.count, this.rate});

  RatingModel.fromJson(dynamic json) {
    rate = json['rate'];
    count = json['count'];
  }
}
