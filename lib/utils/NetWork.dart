import 'package:dio/dio.dart';
import '../common/Global.dart';

//网络处理

class Network{
  static String apiUrl = ApiUrl.getApiUrl();
  static get(String url, [dynamic parameter]) async {
    try {
      url = Network.apiUrl + url;
      print("<GET> Connecting to " + url);
      Dio dio = Dio();
      dio.options.headers = {"Content-Type": "application/json"};
      dio.options.queryParameters = parameter;
      Response response = await dio.get(url);
      int statusCode = response.statusCode;
      if(statusCode < 0){
        return {"status": "error", "code": statusCode, "msg": "Network error"};
      }else{
        return {"status": "ok", "code": statusCode, "data": response.data};
      }
    }on DioError catch(e){
      print(e.message);
      return {"status": "error", "code": 0,"msg": e.response};
    }
  }
}