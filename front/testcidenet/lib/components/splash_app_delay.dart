
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:testcidenet/services/verify_internet.dart';
import 'app_intro_lang.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';


class Splash extends StatefulWidget {
  Splash();

  @override
  _SplashState createState() => _SplashState();
}

_initAll(BuildContext context) async{
  //verifico si tengo internet al mismo server
  bool internet = await getInternet();
  if(internet==true){
    Toast.show(AppLocalizations.of(context).translate('2'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
    Navigator.pushNamed(context, 'homeapp');
  }else{
    Toast.show(AppLocalizations.of(context).translate('1'), context, duration: Toast.LENGTH_LONG, gravity:  Toast.BOTTOM);
  }
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(seconds: 3), () async {
      _initAll(this.context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        color: Theme.of(context).accentColor,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              children: <Widget>[
                FadeInDown(
                  duration: Duration(milliseconds: 2000),
                  child: SvgPicture.asset(
                    "assets/svg/init.svg",
                    width: MediaQuery.of(context).size.width /2,
                    matchTextDirection: true,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}