class CategoryModel {
  String? CategoryName;
  String? Description;
  String? CategoryId;
  String? ParentCategoryId;

  CategoryModel({
    this.CategoryName,
    this.Description,
    this.CategoryId,
    this.ParentCategoryId
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      CategoryName: json['CategoryName'],
      Description: json['Description'] ?? "",
      CategoryId:json['CategoryId'],
      ParentCategoryId:json['ParentCategoryId']
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'CategoryName': CategoryName,
      'Description': Description,
      'CategoryId':CategoryId,
      'ParentCategoryId':ParentCategoryId
    };
  }
}
