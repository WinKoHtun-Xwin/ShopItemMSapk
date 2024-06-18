

part of 'product_list_cubit.dart';

abstract class ProductListBlocState {}

class ProductListBlocLoading extends ProductListBlocState {}

class ProductListBlocSuccess extends ProductListBlocState{
  final List<ProductModel> productList;
  ProductListBlocSuccess(this.productList);
}
class ProductListBlocFailed extends ProductListBlocState{
  final String error;
  ProductListBlocFailed(this.error);
}