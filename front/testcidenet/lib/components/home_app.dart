import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'app_intro_lang.dart';
import 'modal_start.dart';


class Home extends StatefulWidget {
  Home();

  @override
  _HomeState createState() => _HomeState();
}

Future<bool> _operation(BuildContext context) async {

  showCupertinoModalBottomSheet(
      context: context,
      enableDrag: false,
      duration: Duration(milliseconds: 600),
      builder: (context) => Modalstart()
  );

  return Future.value(true);
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    new Future.delayed(new Duration(microseconds: 200), () async {
      _operation(this.context);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height / 1.2,
            color: Theme.of(context).accentColor,
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 13,left: MediaQuery.of(context).size.width / 3.7),
                        child: Text(AppLocalizations.of(context).translate('3'),style: TextStyle(color: Theme.of(context).backgroundColor, fontSize: 24))
                    )
                  ],
                ),
              ],
            ),
          ),
        )
    );
  }
}