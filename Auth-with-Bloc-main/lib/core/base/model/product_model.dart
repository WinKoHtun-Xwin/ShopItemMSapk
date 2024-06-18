class ProductModel {
  String? productId;
  String? barcode;
  String? name;
  String? shortName;
  String? categoryId;
  String? categoryName;
  double? boughtPrice;
  double? sellPriceRetail;
  double? sellPriceWhole;
  String? imageUrl;

  ProductModel({
    this.productId,
    this.barcode,
    this.name,
    this.shortName,
    this.categoryId,
    this.categoryName,
    this.boughtPrice,
    this.sellPriceRetail,
    this.sellPriceWhole,
    this.imageUrl
  });

  // factory ProductModel.fromJson(Map<String, dynamic> json) {
  //   return ProductModel(
  //     productId: json['ProductId'],
  //     barcode: json['Barcode']==null ? "" : json['Barcode'],
  //     name: json['Name'],
  //     shortName: json['ShortName'],
  //     categoryId: json['CategoryId'],
  //     categoryName:json['CategoryName'],
  //     boughtPrice: json['BoughtPrice']?.toDouble(),
  //     sellPriceRetail: json['SellPriceRetail']?.toDouble(),
  //     sellPriceWhole: json['SellPricewhole']?.toDouble(),
  //     imageUrl: json['ImageUrl']==null ? "" : json['ImageUrl'],
  //   );
  // }
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productId: json['ProductId'],
      barcode: json['Barcode'] ?? "", // Use the null-aware operator
      name: json['Name'],
      shortName: json['ShortName'],
      categoryId: json['CategoryId'],
      categoryName: json['CategoryName'],
      boughtPrice: (json['BoughtPrice'] as num?)?.toDouble(), // Use the null-aware operator
      sellPriceRetail: (json['SellPriceRetail'] as num?)?.toDouble(), // Use the null-aware operator
      sellPriceWhole: (json['SellPricewhole'] as num?)?.toDouble(), // Use the null-aware operator
      imageUrl: json['ImageUrl'] ?? "", // Use the null-aware operator
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'ProductId': productId,
      'Barcode': barcode,
      'Name': name,
      'ShortName': shortName,
      'CategoryId': categoryId,
      'CategoryName':categoryName,
      'BoughtPrice': boughtPrice,
      'SellPriceRetail': sellPriceRetail,
      'SellPricewhole': sellPriceWhole,
      'ImageUrl': imageUrl
    };
  }
}
