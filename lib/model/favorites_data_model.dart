class FavoritesModel {
  bool? status;
  FavoritesDataModel? dataModel;

  FavoritesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    dataModel = FavoritesDataModel.fromJson(json['data']);
  }
}

class FavoritesDataModel {
  List<FavoritesData>? data = [];

  FavoritesDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) => data?.add(FavoritesData.fromJson(e)));
  }
}

class FavoritesData {
  Product? product;

  FavoritesData.fromJson(Map<String, dynamic> json) {
    product = Product.fromJson(json['product']);
  }
}

class Product {
  int? id;
  dynamic price;
  dynamic oldPrice;
  int? discount;
  String? image;
  String? name;

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
  }
}

class PostFavoritesModel{
  bool? status;
  PostFavoritesModel.fromJson(Map<String, dynamic> json){
    status = json['status'];
  }
}