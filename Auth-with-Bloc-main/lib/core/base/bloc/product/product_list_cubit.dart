import 'package:auth_with_bloc/core/base/model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import '../../../constants/enums/network_enums.dart';
import '../../../init/cache/cache_manager.dart';
import '../../../init/cache/tokenProvider.dart';
import '../../service/product/product_service.dart';
//
 part 'product_list_state.dart';
//
// class ProductListCubit extends Cubit<ProductListState> {
//   ProductListCubit() : super(ProductListInitial());
// }

class ProductListCubit extends Cubit<ProductListBlocState> {
  final ProductService _productService = ProductService(Dio());// Add a field to store the authentication token

  ProductListCubit() : super(ProductListBlocLoading());

  void getProductList() async{
    emit(ProductListBlocLoading());
    try {
      print('cubit');
      TokenStorage tokenStorage = TokenStorage();
      String? token = await tokenStorage.readToken();
      print(token);
      List<ProductModel> countryList = await _productService.getAllProducts('Bearer '+token!);
      print(countryList);
      emit(ProductListBlocSuccess(countryList));
    }
    catch(e){
      print('cubit error');
      print(e);
      emit(ProductListBlocFailed(e.toString()));
    }

  }
}