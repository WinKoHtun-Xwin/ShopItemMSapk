part of 'product_search_bloc.dart';

// @immutable
// abstract class ProductSearchState {}
//
// class ProductSearchInitial extends ProductSearchState {}
//
//
//
// part of 'search_country_bloc.dart';

@immutable
abstract class SearchProductState {}

class SearchProductInitial extends SearchProductState {}

class SearchProductLoading extends SearchProductState {}

class SearchProductSuccess extends SearchProductState {
  final List<ProductModel> productList;

  SearchProductSuccess(this.productList);
}

class SearchProductFail extends SearchProductState {
  final String errorMessage;

  SearchProductFail(this.errorMessage);
}
