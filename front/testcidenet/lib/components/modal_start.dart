import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:g_json/g_json.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testcidenet/services/services_app.dart';
import 'package:testcidenet/utils/read_store.dart';
import 'app_intro_lang.dart';
import 'modal_display.dart';

class Modalstart extends StatefulWidget {
  Modalstart();

  @override
  _ModalstartState createState() => _ModalstartState();
}

class _ModalstartState extends State<Modalstart> {

  TextEditingController controlleronesurname = TextEditingController();
  TextEditingController controllertwosurname = TextEditingController();
  TextEditingController controllerfirstname = TextEditingController();
  TextEditingController controllerothername = TextEditingController();
  TextEditingController controllerindenty = TextEditingController();

  Future<bool> _display(BuildContext context, List<String> valor) async {

    showCupertinoModalBottomSheet(
        context: context,
        isDismissible: true,
        enableDrag: true,
        duration: Duration(milliseconds: 600),
        builder: (context) => Modaldisplay(valor)
    );

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (Timer t) async {
      String infoEdit = await Store.gets("string", "edit");
      if(infoEdit!=""){
        final mode = JSON.parse(infoEdit);
        var date = DateTime.fromMillisecondsSinceEpoch(mode['date'].integerValue * 1000);
        var formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss').format(date);
        controlleronesurname.text=mode['firstSurname'].stringValue;
        controllertwosurname.text=mode['secondSurname'].stringValue;
        controllerfirstname.text=mode['firstName'].stringValue;
        controllerothername.text=mode['otherName'].stringValue;
        controllerindenty.text=mode['dni'].stringValue;
        setState((){
          fecha = formattedDate;
          _country =mode['country'].integerValue;
          _typeindenty = mode['typeDni'].integerValue;
          _area = mode['area'].integerValue;
        });
        Store.dels("edit");
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _country = 1,_typeindenty =1, _area=1;
  String fecha = "DD/MM/YYYY", email="";
  var now =  new DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss').format(new DateTime.now());
  var formatterAno =  new DateFormat("yyyy");

  _selectDate(BuildContext context) async {
    DateTime init = now;
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: init,
      firstDate: DateTime(int.parse(formatterAno.format(now))-99),
      lastDate: now,
    );
    if (picked != null){
      setState(() {
        init = picked;
        fecha = picked.toString().substring(0,10);
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){},
      child: Material(
        child: Container(
          height: MediaQuery.of(context).size.height / 1.1,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 24, left: 14, bottom: 14),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 13),
                        width: MediaQuery.of(context).size.width /2.3,
                        child: TextField(
                          maxLength: 20,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]+$')),
                          ],
                          onChanged: (v){

                          },
                          controller: controlleronesurname,
                          cursorColor: Theme.of(context).accentColor,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            hintText: AppLocalizations.of(context).translate('4'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width /2.3,
                        child: TextField(
                          maxLength: 20,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]+$')),
                          ],
                          onChanged: (v){

                          },
                          controller: controllertwosurname,
                          cursorColor: Theme.of(context).accentColor,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            hintText: AppLocalizations.of(context).translate('5'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width /2.3,
                        margin: EdgeInsets.only(right: 13),
                        child: TextField(
                          maxLength: 20,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]+$')),
                          ],
                          onChanged: (v){

                          },
                          controller: controllerfirstname,
                          cursorColor: Theme.of(context).accentColor,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            hintText: AppLocalizations.of(context).translate('6'),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width /2.3,
                        child: TextField(
                          maxLength: 50,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^[A-Z]+$')),
                          ],
                          onChanged: (v){

                          },
                          controller: controllerothername,
                          cursorColor: Theme.of(context).accentColor,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            hintText: AppLocalizations.of(context).translate('7'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(AppLocalizations.of(context).translate('10'),style: TextStyle(color:Theme.of(context).accentColor),)
                          ),
                          DropdownButton(
                              value: _typeindenty,
                              items: [
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('16'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('17'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('18'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('19'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 4,
                                ),
                              ],
                              onChanged: (value) async {
                                setState(() {
                                  _typeindenty = value;
                                });
                              })
                        ],
                      )
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width /1.7,
                        child: TextField(
                          maxLength: 20,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(RegExp(r'^[a-zA-Z0-9]+$')),
                          ],
                          onChanged: (v){

                          },
                          controller: controllerindenty,
                          cursorColor: Theme.of(context).accentColor,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Theme.of(context).accentColor),
                            ),
                            hintText: AppLocalizations.of(context).translate('20'),
                          ),
                        ),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Container(
                                child: Text(AppLocalizations.of(context).translate('13'),style: TextStyle(color:Theme.of(context).accentColor),)
                            ),
                            Container(
                                child: Text(AppLocalizations.of(context).translate('21'),style: TextStyle(color:Theme.of(context).accentColor,fontSize: 23),)
                            ),
                          ],
                        )
                      )
                    ],
                  ),
                  Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(AppLocalizations.of(context).translate('15'),style: TextStyle(color:Theme.of(context).accentColor),)
                          ),
                          DropdownButton(
                              value: _country,
                              items: [
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('8'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('9'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 2,
                                ),
                              ],
                              onChanged: (value) async {
                                setState(() {
                                  _country = value;
                                });
                              })
                        ],
                      )
                  ),
                  Container(
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text(AppLocalizations.of(context).translate('12'),style: TextStyle(color:Theme.of(context).accentColor),)
                          ),
                          DropdownButton(
                              value: _area,
                              items: [
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('23'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 1,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('24'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 2,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('25'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 3,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('26'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 4,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('27'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 5,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('28'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 6,
                                ),
                                DropdownMenuItem(
                                  child: Text(AppLocalizations.of(context).translate('29'),style: TextStyle(color:Theme.of(context).accentColor),),
                                  value: 7,
                                ),
                              ],
                              onChanged: (value) async {
                                setState(() {
                                  _area = value;
                                });
                              })
                        ],
                      )
                  ),
                  Container(
                      margin: EdgeInsets.only(top:9),
                      child: Text(AppLocalizations.of(context).translate('11'),style: TextStyle(color:Theme.of(context).accentColor),)
                  ),
                  Container(
                      child: InkWell(
                        onTap: (){
                          _selectDate(context);
                        },
                        child:Container(
                            child:Text(fecha, style: TextStyle(color:Theme.of(context).accentColor, fontSize: 25),)
                        ),
                      )
                  ),
                  Container(
                      child: Text(AppLocalizations.of(context).translate('14'),style: TextStyle(color:Theme.of(context).accentColor),)
                  ),
                  Container(//
                      child:Text(formattedDate, style: TextStyle(color:Theme.of(context).accentColor, fontSize: 25),)
                  ),
                  email !="" ? Container(
                    child: Text(email),
                  ) : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 23),
                          child: ElevatedButton(onPressed: () async{
                            List<String> valor = await display(context);
                            _display(context,valor);
                          },child: Text(AppLocalizations.of(context).translate('33')),)
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 23),
                          child: ElevatedButton(onPressed: () async{
                            bool result = await saveEmployee(controlleronesurname.text,controllertwosurname.text,controllerfirstname.text, controllerothername.text,controllerindenty.text,_country,_typeindenty, _area,fecha,context);
                            if (result==true){
                              controlleronesurname.text="";
                              controllertwosurname.text="";
                              controllerfirstname.text="";
                              controllerothername.text="";
                              controllerindenty.text="";
                              String temp = await Store.gets("string", "email");
                              setState((){
                                email = temp;
                                fecha = "DD/MM/YYYY";
                              });
                              Store.dels("email");
                            }
                          },child: Text(AppLocalizations.of(context).translate('22')),)
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 23),
                          child: ElevatedButton(onPressed: () async {
                            bool result = await detele(context,controllerindenty.text);
                            if(result==true){
                              controlleronesurname.text="";
                              controllertwosurname.text="";
                              controllerfirstname.text="";
                              controllerothername.text="";
                              controllerindenty.text="";
                              String temp = await Store.gets("string", "email");
                              setState(() {
                                fecha = "DD/MM/YYYY";
                                email = temp;
                              });
                              Store.dels("email");
                            }
                          },child: Text(AppLocalizations.of(context).translate('31')),)
                      )
                    ],
                  )
                ],
              ),
            )
          )
        ),
      ),
    );
  }
}
