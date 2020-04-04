import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Funds/CreateFunds2.dart';
import 'package:collector/Models/UserClass.dart';
import 'package:flutter/material.dart';

class CreateFunds extends StatefulWidget {
  @override
  _CreateFundsState createState() => _CreateFundsState();
}

class _CreateFundsState extends State<CreateFunds> {
  User user;
  bool disable = false;
  List<DocumentSnapshot> documents;
  bool obsureTextValue = true;
  List<String> _items = [];
  List<String> _genderitems = ["Male", "Female"];
  String fatherNameselected, genderSelected, villageSelected, familySelected;
  List<String> villageGroupitems = [
    "Bhawalnagar",
    "Mailsi",
    "Faisalabad",
    "Karachi",
    "Patoki"
  ];
  List<String> familygrp = ["01", "02", "03", "04", "05"];
  final _formKey = new GlobalKey<FormState>();

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }

  Future validateAndSubmit() async {
    if (validateAndSave()) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => CreateFunds2(user)));
    }
  }

  @override
  void initState() {
    user = new User();

    getReciever();
    super.initState();
  }

  Future<void> getReciever() async {
    final QuerySnapshot result =
        await Firestore.instance.collection("Users").getDocuments();
    documents = result.documents.toList();
    documents.forEach((data) {
      _items.add(data.documentID.toString());
    });
  }

  void _ChangeText() {
    setState(() {
      if (obsureTextValue) {
        obsureTextValue = false;
      } else {
        obsureTextValue = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: true,
        body: new Form(
          key: _formKey,
          child: ListView(children: <Widget>[
            Container(
                padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (input) =>
                          input.isEmpty ? 'Name cannot be empty' : null,
                      onChanged: (value) {
                        user.fullName = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'FULL NAME ',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      validator: (input) =>
                          input.isEmpty ? 'Email cannot be empty' : null,
                      onChanged: (value) {
                        user.email = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (input) =>
                          input.isEmpty ? 'Password cannot be empty' : null,
                      onChanged: (value) {
                        user.password = value;
                      },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: new Icon(Icons.remove_red_eye),
                            onPressed: _ChangeText,
                            color: Colors.grey,
                          ),
                          labelText: 'PASSWORD(Minimum 6 characters)',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: obsureTextValue,
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      validator: (input) =>
                          input.isEmpty ? 'Phone Number cannot be empty' : null,
                      onChanged: (value) {
                        user.phoneNum = value;
                      },
                      decoration: InputDecoration(
                          hintText: "03XX-XXXXXX",
                          labelText: 'PHONE NO.',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: new DropdownButton<String>(
                            value: genderSelected,
                            items: _genderitems.map((lable) {
                              return new DropdownMenuItem<String>(
                                value: lable,
                                child: new Text(lable),
                              );
                            }).toList(),
                            hint: Text('Gender'),
                            onChanged: (value) {
                              setState(() {
                                genderSelected = value;
                                user.gender = genderSelected;
                                print(user.gender);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: new DropdownButton<String>(
                            value: villageSelected,
                            items: villageGroupitems.map((lable) {
                              return new DropdownMenuItem<String>(
                                value: lable,
                                child: new Text(lable),
                              );
                            }).toList(),
                            hint: Text('Village Group'),
                            onChanged: (value) {
                              setState(() {
                                villageSelected = value;
                                user.villageGroup = villageSelected;
                                print(user.villageGroup);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      width: MediaQuery.of(context).size.width - 100,
                      height: 60.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(color: Colors.blueGrey),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: ButtonTheme(
                          alignedDropdown: true,
                          child: new DropdownButton<String>(
                            value: familySelected,
                            items: familygrp.map((lable) {
                              return new DropdownMenuItem<String>(
                                value: lable,
                                child: new Text(lable),
                              );
                            }).toList(),
                            hint: Text('Family Group'),
                            onChanged: (value) {
                              setState(() {
                                familySelected = value;
                                user.familyGroup = familySelected;
                                print(user.familyGroup);
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(color: Colors.blueGrey)),
                          child: DropdownButtonHideUnderline(
                            child: ButtonTheme(
                              alignedDropdown: true,
                              child: new DropdownButton<String>(
                                value: fatherNameselected,
                                items: _items.map((lable) {
                                  return new DropdownMenuItem<String>(
                                    value: lable,
                                    child: new Text(lable),
                                  );
                                }).toList(),
                                hint: Text('FATHER NAME'),
                                onChanged: (value) {
                                  setState(() {
                                    fatherNameselected = value;
                                    user.fatherName = fatherNameselected;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        FlatButton(
                            color: Colors.grey,
                            onPressed: () {
                              setState(() {
                                if (disable == false) {
                                  disable = true;
                                } else {
                                  disable = false;
                                }
                              });
                            },
                            child: Text("NEW"))
                      ],
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      enabled: disable,
                      keyboardType: TextInputType.text,
                      validator: (input) => user.fatherName.isEmpty
                          ? 'FATHER NAME cannot be empty'
                          : null,
                      onChanged: (value) {
                        user.fatherName = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'FATHER NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty
                          ? 'Father Status cannot be empty'
                          : null,
                      onChanged: (value) {
                        user.fatherStatus = value;
                      },
                      decoration: InputDecoration(
                          labelText: 'FAMILY STATUS',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                    ),
                    SizedBox(height: 10.0),
                    GestureDetector(
                      onTap: validateAndSubmit,
                      child: Container(
                          height: 60.0,
                          child: Material(
                            borderRadius: BorderRadius.circular(20.0),
                            shadowColor: Colors.greenAccent,
                            color: Colors.green,
                            elevation: 7.0,
                            child: Center(
                              child: Text(
                                'NEXT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat'),
                              ),
                            ),
                          )),
                    )
                  ],
                )),
          ]),
        ));
  }
}
