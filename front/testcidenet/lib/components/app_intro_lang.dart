import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:testcidenet/components/splash_app_delay.dart';
import 'package:wakelock/wakelock.dart';

import 'home_app.dart';

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['es', 'en'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();
  Map<String, String> _localizedStrings;

  Future<bool> load() async {
    String jsonString = "";
    if (locale.languageCode == "es") {
      jsonString ='{"1":"No tienes conexión a internet","2":"Espere por favor","3":"App test cidenet","4":"Primer apellido","5":"Segundo apellido","6":"Primer nombre","7":"Otros nombres","8":"Colombia","9":"Estados unidos","10":"Tipo de identificación","11":"Fecha de ingreso","12":"Area","13":"Estado","14":"Fecha y hora de registro","15":"Pais de empledo","16":"Cédula de Ciudadanía","17":"Cédula de Extranjería","18":"Pasaporte","19":"Permiso Especial","20":"Número de Identificación","21":"Activo","22":"Guardar","23":"Administración","24":"Financiera","25":"Compras","26":"Infraestructura","27":"Operación","28":"Talento Humano","29":"Servicios Varios","30":"Editar","31":"Eliminar","32":"Esta seguro que desea eliminar","33":"Visualizar"}';
    } else {
      jsonString ='{"1": "You have no internet connection", "2": "Please wait", "3": "App test cidenet", "4": "First last name", "5": "Middle last name", "6": "First name", "7": "Other names", "8": "Colombia", "9": "United States", "10": "Type of identification", "11": "Date of entry", "12": "Area", "13": "State", "14": "Date and time of registration", "15": "Country of employment", "16": "Cédula de Ciudadanía", "17": "Cédula de Extranjería", "18": "Pasaporte", "19": "Permiso Especial", "20": "Número de Identificación", "21": "Activo", "22": "Guardar", "23": "Administración", "24": "Financial", "25": "Purchasing", "26": "Infrastructure", "27": "Operation", "28": "Human Resources", "29": "Miscellaneous Services", "30": "Edit", "31": "Delete", "32": "Are you sure you want to delete","33":"Display"}';
    }
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
    return true;
  }

  String translate(String key) {
    return _localizedStrings[key];
  }
}

class App extends StatefulWidget {
  App();

  @override
  _AppState createState() => _AppState();

}

class _AppState extends State<App> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    Wakelock.enable();
    return MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          Locale('en', 'US'),
          Locale('es', 'ES'),
        ],
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.blue,
          primaryColor: Colors.purple,
          accentColor: Colors.black45,
          backgroundColor: Colors.grey[50],
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primarySwatch: Colors.purple,
          primaryColor: Colors.blue,
          accentColor: Colors.grey[50],
          backgroundColor: Colors.black45,
        ),
        debugShowCheckedModeBanner: false,
        title: 'Test cidenet App',
        initialRoute: 'splash',
        routes: {
          'splash': (BuildContext context) =>  Splash(),
          'homeapp': (BuildContext context) =>  Home(),
        }
    );
  }
}