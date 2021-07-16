

import 'package:g_json/g_json.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testcidenet/utils/config_services.dart';


void saveEmployee(String controlleronesurname, String controllertwosurname, String controllerfirstname, String controllerothername, String controllerindenty, int country, int typeindenty, int area, String fecha, BuildContext context ) async{
  if(controlleronesurname!="" && controllertwosurname !="" && controllerfirstname!="" && fecha !="DD/MM/YYYY"){

    Map<String, String> body = {
      'firstSurname': controlleronesurname,
      'secondSurname': controllertwosurname,
      'firstName': controllerfirstname,
      'otherName': controllerothername,
      'country': country.toString(),
      'typeDni': typeindenty.toString(),
      'dni': controllerindenty,
      'dateInit': fecha,
      'area': area.toString(),
    };

    var options = Options(
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        followRedirects: false,
    );

    Response response;
    Dio dio = new Dio();
    response = await dio.post(UrlDirect+"/v1/createEmployee", data:body, options: options);
    print(response.data);
  }
}

void detele(BuildContext context, String dni) async{
  Map<String, String> body = {
    'dni': dni,
  };

  var options = Options(
    contentType: "application/x-www-form-urlencoded; charset=UTF-8",
    followRedirects: false,
  );

  Response response;
  Dio dio = new Dio();
  response = await dio.post(UrlDirect+"/v1/deleteEmployee", data:body, options: options);
  print(response.data);
}

Future<List<String>> display() async{
  Response response;
  Dio dio = new Dio();
  response = await dio.get(UrlDirect+"/v1/listEmployee");
  var nuevo = response.data.toString().replaceAll("} {", "},{");
  final mode = JSON.parse(nuevo);
  final list = mode.listValue;
  List<String> listDocumen =[];
  for (var i = 0; i < list.length; i++) {
    listDocumen.add(list[i].toString());
  }
  return listDocumen;
}