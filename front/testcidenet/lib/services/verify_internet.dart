
import 'package:dio/dio.dart';
import 'package:testcidenet/utils/config_services.dart';

Future<bool> getInternet() async {
  try {
    var response = await Dio().get(UrlDirect+"/v1/status");
    if(response.statusCode== 200){
      return true;
    }else{
      return false;
    }
  } catch (e) {
    return false;
  }
}