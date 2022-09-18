class SearchModel {
  bool? status;
  SearchDataModel? data;

  SearchModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = SearchDataModel.fromJson(json['data']);
  }
}

class SearchDataModel {
  List<SearchData> searchData = [];

  SearchDataModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) => searchData.add(SearchData.fromJson(e)));
  }
}

class SearchData {
  int? id;
  dynamic price;
  String? image;
  String? name;
  bool? inFavorites;

  SearchData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    inFavorites = json['in_favorites'];
  }
}
