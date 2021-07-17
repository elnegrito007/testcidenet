import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:g_json/g_json.dart';
import 'package:intl/intl.dart';
import 'package:testcidenet/utils/read_store.dart';

import 'app_intro_lang.dart';


class Modaldisplay extends StatefulWidget {
  List<String> valor;
  Modaldisplay(this.valor);

  @override
  _ModaldisplayState createState() => _ModaldisplayState(this.valor);
}

class _ModaldisplayState extends State<Modaldisplay> {
  List<String> valor;
  _ModaldisplayState(this.valor);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var listEmployee = List<Widget>();

  @override
  Widget build(BuildContext context) {

    for (var iten in valor) {
      final mode = JSON.parse(iten);
      var date = DateTime.fromMillisecondsSinceEpoch(mode['date'].integerValue * 1000);
      var formattedDate = DateFormat('dd/MM/yyyy, hh:mm:ss').format(date);

      listEmployee.add(
        Container(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(8),
                child:Text(mode['firstSurname'].stringValue+" "+mode['secondSurname'].stringValue+" "+mode['firstName'].stringValue+" "+mode['otherName'].stringValue)
              ),
              Container(
                margin: EdgeInsets.all(8),
                child:Text(mode['typeDni'].stringValue == "1" ? AppLocalizations.of(context).translate('16') : mode['typeDni'].stringValue == "2" ? AppLocalizations.of(context).translate('17') : mode['typeDni'].stringValue == "3" ? AppLocalizations.of(context).translate('18') : AppLocalizations.of(context).translate('19'))
              ),
              Container(
                margin: EdgeInsets.all(8),
                child:Text(mode['dni'].stringValue)
              ),
              Container(
                margin: EdgeInsets.all(8),
                child:Text(mode['country'].stringValue == "1" ? AppLocalizations.of(context).translate('8') : AppLocalizations.of(context).translate('9'))
              ),
              Container(
                margin: EdgeInsets.all(8),
                child:Text(mode['area'].stringValue == "1" ? AppLocalizations.of(context).translate('23') : mode['area'].stringValue == "2"  ? AppLocalizations.of(context).translate('24') : mode['area'].stringValue == "3" ? AppLocalizations.of(context).translate('25') : mode['area'].stringValue == "4" ? AppLocalizations.of(context).translate('26') : mode['area'].stringValue == "5" ? AppLocalizations.of(context).translate('27') : mode['area'].stringValue == "6" ? AppLocalizations.of(context).translate('28') : AppLocalizations.of(context).translate('29'))
              ),
              Container(
                  margin: EdgeInsets.all(8),
                child: Text(formattedDate)
              ),
              Container(
                margin: EdgeInsets.all(8),
                child:ElevatedButton(onPressed: (){
                  Store.sets("string","edit",iten);
                  Store.sets("string","edit_id",mode['date'].stringValue);
                  Navigator.pop(context);
                }, child: Text(AppLocalizations.of(context).translate('30'))),
              ),
              Divider()
            ],
          )
        )
      );
    }

    return WillPopScope(
      onWillPop: (){},
      child: Material(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.1,
          child: SingleChildScrollView(
            child: Column(
              children:listEmployee
            )
          )
        ),
      ),
    );
  }
}
