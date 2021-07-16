import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:testcidenet/services/services_app.dart';
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
        enableDrag: true,
        duration: Duration(milliseconds: 600),
        builder: (context) => Modaldisplay(valor)
    );

    return Future.value(true);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int _country = 1,_typeindenty =1, _area=1;
  String fecha = "DD/MM/YYYY";
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
                  Container(
                    width: MediaQuery.of(context).size.width /1.4,
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
                      child: Text(AppLocalizations.of(context).translate('13'),style: TextStyle(color:Theme.of(context).accentColor),)
                  ),
                  Container(
                      child: Text(AppLocalizations.of(context).translate('21'),style: TextStyle(color:Theme.of(context).accentColor,fontSize: 23),)
                  ),
                  Container(
                      child: Text(AppLocalizations.of(context).translate('14'),style: TextStyle(color:Theme.of(context).accentColor),)
                  ),
                  Container(//
                      child:Text(formattedDate, style: TextStyle(color:Theme.of(context).accentColor, fontSize: 25),)
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(top: 23),
                          child: ElevatedButton(onPressed: () async{
                            List<String> valor = await display();
                            _display(context,valor);
                          },child: Text(AppLocalizations.of(context).translate('33')),)
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 23),
                          child: ElevatedButton(onPressed: () async{
                            await saveEmployee(controlleronesurname.text,controllertwosurname.text,controllerfirstname.text, controllerothername.text,controllerindenty.text,_country,_typeindenty, _area,fecha,context);
                            controlleronesurname.text="";
                            controllertwosurname.text="";
                            controllerfirstname.text="";
                            controllerothername.text="";
                            controllerindenty.text="";
                            setState(() {
                              fecha = "DD/MM/YYYY";
                            });
                          },child: Text(AppLocalizations.of(context).translate('22')),)
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 23),
                          child: ElevatedButton(onPressed: () async {
                            await detele(context,controllerindenty.text);
                            controllerindenty.text="";
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
