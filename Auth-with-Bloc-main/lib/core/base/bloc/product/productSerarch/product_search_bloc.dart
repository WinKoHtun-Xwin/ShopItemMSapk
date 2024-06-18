import 'dart:async';

import 'package:auth_with_bloc/core/base/model/product_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../constants/enums/network_enums.dart';
import '../../../../init/cache/cache_manager.dart';
import '../../../../init/cache/tokenProvider.dart';
import '../../../model/searchModel.dart';
import '../../../service/product/product_service.dart';

part 'product_search_event.dart';
part 'product_search_state.dart';

class SearchProductBloc extends Bloc<SearchProductEvent, SearchProductState> {
  final ProductService _productService =
  ProductService(Dio()..interceptors.add(PrettyDioLogger()));

  SearchProductBloc() : super(SearchProductInitial()) {
    //Myanmar
    on<SearchProductEvent>((event, emit) async {
      if (event is SearchProduct) {
        String searchstring = (event.searchString);
        if (searchstring.isEmpty) {
          emit(SearchProductInitial());
        } else {
          emit(SearchProductLoading());
          try {
            SearchModel searchModel =new SearchModel();
            searchModel.searchString=event.searchString;

            TokenStorage tokenStorage = TokenStorage();
            String? token = await tokenStorage.readToken();
            print('bloc serach');
            print(token);
              List<ProductModel> productList =
              await _productService.searchProducts('Bearer '+token!,searchModel);
             // await _productService.searchProducts('Bearer '+token!,searchModel);
          print('product list');
              emit(SearchProductSuccess(productList));

          } catch (e) {
            print('bloc search error');
            print(e);
            emit(SearchProductFail(e.toString()));
          }
        }
      }
    }, transformer: (event, mapper) {
      return event
          .debounceTime(const Duration(milliseconds: 500))
          .asyncExpand(mapper);
    });
  }
}
