part of 'product_search_bloc.dart';

// @immutable
// abstract class ProductSearchEvent {}
//
//
// part of 'search_country_bloc.dart';

@immutable
abstract class SearchProductEvent {}

class SearchProduct extends SearchProductEvent{
  final String searchString;

  SearchProduct(this.searchString);
}
