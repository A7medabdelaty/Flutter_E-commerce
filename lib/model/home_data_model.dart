class HomeModel {
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = HomeDataModel.fromJson(json['data']);
  }
}

class HomeDataModel {
  List<HomeBannersModel> banners = [];
  List<HomeProductsModel> products = [];

  HomeDataModel.fromJson(Map<String, dynamic> json){
    json['banners'].forEach((element) {
      banners.add(HomeBannersModel.fromJson(element));
    });

    json['products'].forEach((element){
      products.add(HomeProductsModel.fromJson(element));
    });
  }
}

class HomeBannersModel {
  int? id;
  String? image;

  HomeBannersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class HomeProductsModel {
  int? id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;
  String? image;
  String? name;
  bool? inFavorites;
  bool? inCart;

  HomeProductsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    oldPrice = json['old_price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
    inCart = json['in_cart'];
  }
}
