// import 'package:dio/dio.dart';
//
// import '../../constants/enums/ApiConstant.dart';
// import '../cache/tokenProvider.dart';
//
// class DioManager {
//   static DioManager? _instance;
//
//   static DioManager get instance {
//     if (_instance != null) return _instance!;
//     _instance = DioManager._init();
//     return _instance!;
//   }
//
//   final String _baseUrl = ApiConst.baseUrl;
//   late final Dio dio;
//   late final String? token;
//   DioManager._init() {
//     dio = Dio(
//       BaseOptions(
//         baseUrl: _baseUrl,
//         followRedirects: true,
//         headers: {
//           'Content-Type': 'application/json',
//           'Authorization' 'Bearer '+token
//         }
//       ),
//     );
//   }
//
// }


import 'package:dio/dio.dart';
import '../../constants/enums/ApiConstant.dart';
import '../cache/tokenProvider.dart';

class DioManager {
  static DioManager? _instance;

  static DioManager get instance {
    if (_instance != null) return _instance!;
    _instance = DioManager._init();
    return _instance!;
  }

  final String _baseUrl = ApiConst.baseUrl;
  late final Dio dio;
  late String? token;

  DioManager._init() {
    dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        followRedirects: true,
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
    _initializeToken();
  }

  Future<void> _initializeToken() async {
    TokenStorage tokenStorage = TokenStorage();
    token = await tokenStorage.readToken();
  }



}
