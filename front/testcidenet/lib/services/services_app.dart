

import 'package:g_json/g_json.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:testcidenet/components/app_intro_lang.dart';
import 'package:testcidenet/utils/config_services.dart';
import 'package:toast/toast.dart';
import 'package:testcidenet/utils/read_store.dart';



Future<bool> saveEmployee(String controlleronesurname, String controllertwosurname, String controllerfirstname, String controllerothername, String controllerindenty, int country, int typeindenty, int area, String fecha, BuildContext context ) async{
  if(controlleronesurname!="" && controllertwosurname !="" && controllerfirstname!="" && fecha !="DD/MM/YYYY"){

    String path ="createEmployee";
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

    String edit = await Store.gets("string","edit_id");
    if(edit !=""){
      path ="editEmployee";
      body = {
        'firstSurname': controlleronesurname,
        'secondSurname': controllertwosurname,
        'firstName': controllerfirstname,
        'otherName': controllerothername,
        'country': country.toString(),
        'typeDni': typeindenty.toString(),
        'dni': controllerindenty,
        'dateInit': fecha,
        'area': area.toString(),
        'date': edit
      };
    }

    var options = Options(
        contentType: "application/x-www-form-urlencoded; charset=UTF-8",
        followRedirects: false,
    );

    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.post(UrlDirect+"/v1/"+path, data:body, options: options);
      final mode = JSON.parse(response.data);
      final valor = mode['e'].integerValue;
      final correo = mode[['d',1]].integerValue;
      String email = controllerfirstname+"."+controlleronesurname+"@cidenet.com.co";
      if(correo!=0){
        email = controllerfirstname+"."+controlleronesurname+"."+correo.toString()+"@cidenet.com.co";
      }
      Store.sets("string","email",email);
      if(valor==0){
        Toast.show(AppLocalizations.of(context).translate('34'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        return true;
      }else{
        Toast.show(AppLocalizations.of(context).translate('35'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        return false;
      }
    }catch(e){
      Toast.show(AppLocalizations.of(context).translate('35'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      return false;
    }
  }else{
    Toast.show(AppLocalizations.of(context).translate('35'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    return false;
  }
}

Future<bool> detele(BuildContext context, String dni) async{
  if(dni!=""){
    Map<String, String> body = {
      'dni': dni,
    };

    var options = Options(
      contentType: "application/x-www-form-urlencoded; charset=UTF-8",
      followRedirects: false,
    );
    try{
      Response response;
      Dio dio = new Dio();
      response = await dio.post(UrlDirect+"/v1/deleteEmployee", data:body, options: options);
      final mode = JSON.parse(response.data);
      final valor = mode['e'].integerValue;
      if(valor==0){
        Toast.show(AppLocalizations.of(context).translate('34'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        return true;
      }else{
        Toast.show(AppLocalizations.of(context).translate('35'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
        return false;
      }
    }catch(e){
      Toast.show(AppLocalizations.of(context).translate('35'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
      return false;
    }
  }else{
    Toast.show(AppLocalizations.of(context).translate('36'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    return false;
  }
}

Future<List<String>> display(BuildContext context) async{
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
  Toast.show(AppLocalizations.of(context).translate('34'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  return listDocumen;
}