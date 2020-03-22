


import 'package:collector/Reponsibilities/AddReponsibilities2.dart';
import 'package:collector/Reponsibilities/utils.dart';
import 'package:flutter/material.dart';

class AddReponsibilities extends StatefulWidget {
  @override
  _AddReponsibilitiesState createState() => _AddReponsibilitiesState();
}

class _AddReponsibilitiesState extends State<AddReponsibilities> {


  final _formKey = new GlobalKey<FormState>();
  RecieverClass reciever;

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }
  Future validateAndSubmit() async 
  {
      if(validateAndSave()){
         Navigator.of(context).push(MaterialPageRoute(builder: (context)=>AddReponsibilities2(reciever)));
      }
     
  }
  
  @override
  void initState() { 
    super.initState();
    
    reciever = new RecieverClass();
    reciever.accountNumber = "";
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(

        resizeToAvoidBottomPadding: true,
        body:  Form(
           key: _formKey,
                  child: ListView(
          children: <Widget>[

          Container(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (input) => input.isEmpty ? 'Name cannot be empty' : null,
                    keyboardType: TextInputType.text,
                      
                      onChanged: (value){
                           
                            reciever.fullName = value;
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
                
                  SizedBox(height: 10.0),
                  
                     TextFormField(
                       onFieldSubmitted: (value){
                          print(value);
                       },
                    keyboardType: TextInputType.number,
                      validator: (input) => input.isEmpty ? 'Phone Number cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.phoneNum = value;
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'PHONE NO.',
                        hintText: "03XX-XXXXXXX",
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),
                 TextFormField(
                    keyboardType: TextInputType.number,
                      validator: (input) => input.isEmpty ? 'DUE AMOUNT cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.amount =  int.parse(value);

                          },
                    decoration: InputDecoration(
                        
                        labelText: 'DUE AMOUNT (RS.)',
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
                      validator: (input) => input.isEmpty ? 'FATHER NAME cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.fatherName = value;
                         
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
                      validator: (input) => input.isEmpty ? 'Father Status cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.fatherStatus = value;
                          
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

                TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Family Group Number cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.familyGroup = value;
                            
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'FAMILY GROUP',
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
                      validator: (input) => input.isEmpty ? 'VILLAGE GROUP cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.villageGroup = value;
                            
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'VILLAGE GROUP',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),
                

                  SizedBox(height: 50.0),

              GestureDetector(
                  onTap: validateAndSubmit,
                  child:  Container(
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
              )
              ),
          ]
          ),
        )
        
        );

  }
  
}
