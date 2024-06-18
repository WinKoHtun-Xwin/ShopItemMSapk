class SearchModel {
  String? searchString;

  SearchModel({
    this.searchString
  });

  Map<String, dynamic> toJson() {
    return {
      'SearchString': searchString
    };
  }

  factory SearchModel.fromJson(Map<String, dynamic> json) {
    return SearchModel(
      searchString : json['SearchString'] as String?,
    );
  }
}
