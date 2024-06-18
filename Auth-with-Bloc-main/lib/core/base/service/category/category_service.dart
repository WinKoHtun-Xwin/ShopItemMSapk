import 'package:auth_with_bloc/core/base/model/category_model.dart';
import 'package:auth_with_bloc/core/base/model/product_model.dart';
import 'package:dio/dio.dart';
import 'package:auth_with_bloc/core/constants/enums/ApiConstant.dart';
import 'package:retrofit/http.dart';

import '../../../constants/enums/network_enums.dart';
import '../../../init/cache/cache_manager.dart';
import '../../model/searchModel.dart';

part 'category_service.g.dart';

@RestApi(baseUrl: ApiConst.baseUrl)
abstract class CategoryService {
  factory CategoryService(Dio dio) => _CategoryService(dio);

  @GET(ApiConst.categoryAll)
  Future<List<CategoryModel>> GetAllCategory(@Header('Authorization') String bearerToken);

  @POST(ApiConst.categoryAll)
  Future<CategoryModel> CreateCategory(@Header('Authorization') String bearerToken,
      @Body() CategoryModel categoryModel);

  @DELETE('${ApiConst.categoryAll}/{id}')
  Future<String?> deleteCategory(
      @Header('Authorization') String bearerToken,@Path('id') String id);

  @PUT(ApiConst.categoryAll)
  Future<CategoryModel> UpdateCategory(
      @Header('Authorization') String bearerToken,
      @Body() CategoryModel categoryModel
      );


}
