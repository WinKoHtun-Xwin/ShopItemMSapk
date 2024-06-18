import 'package:auth_with_bloc/core/base/model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:auth_with_bloc/core/constants/enums/ApiConstant.dart';
import 'package:retrofit/http.dart';

import '../../../constants/enums/network_enums.dart';
import '../../../init/cache/cache_manager.dart';
import '../../model/searchModel.dart';

part 'product_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class ProductService {
  factory ProductService(Dio dio) => _ProductService(dio);

  @GET(ApiConst.all)
  Future<List<ProductModel>> getAllProducts(@Header('Authorization') String bearerToken);

  @GET('${ApiConst.search}')
  Future<List<ProductModel>> searchProducts(@Header('Authorization') String bearerToken,
      @Body() SearchModel searchModel);
}
