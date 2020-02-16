

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Home/HomePage.dart';

import 'package:collector/Reciever/utils.dart';
import 'package:flutter/material.dart';

class AddReciever2 extends StatefulWidget {

  RecieverClass reciever;

  AddReciever2(this.reciever);
  @override
  _AddReciever2State createState() => _AddReciever2State(reciever);
}

class _AddReciever2State extends State<AddReciever2> {
  String gender = "Male";
  RecieverClass reciever = new RecieverClass();
  _AddReciever2State(this.reciever);
  final _formKey = new GlobalKey<FormState>();
  List<String> _items = ["Male","Female"];

  
  Future validateAndSubmit () async {

  Firestore.instance.collection("Reciever").document().setData({
    "FullName":reciever.fullName,
    "Phone":reciever.phoneNum,
    "Amount":reciever.amount,
    "FatherName":reciever.fatherName,
    "FatherStatus":reciever.fatherStatus,
     "VillageGroup":reciever.villageGroup,
     "Gender":reciever.gender,
     "Reference":reciever.reference,
     "StatusOfReference":reciever.statusOfReference,
     "DueDate":reciever.dueDate,
     "AccountNumber":reciever.accountNumber,
     "MemberNeeded":reciever.memberNeeded,
     "Days":reciever.days
  });  

  // Firestore.instance.collection("Pipeline").document().setData({
  //   "FullName":reciever.fullName,
  //   "Phone":reciever.phoneNum,
  //   "Amount":reciever.amount,
  //    "DueDate":reciever.dueDate,
  //    "AccountNumber":reciever.accountNumber,
  // });
   
   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
    Home()), (Route<dynamic> route) => false); 

  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body:  new Form(
          key: _formKey,
          child: ListView(
          children: <Widget>[

          Container(
              padding: EdgeInsets.only(top: 25.0, left: 20.0, right: 20.0),
              child: Column(
                children: <Widget>[
                  

 SizedBox(height: 10.0),
                 TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Reference cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.reference = value;
                          
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'REFERENCE',
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
                      validator: (input) => input.isEmpty ? 'Status Of Reference cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.statusOfReference = value;
                 
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'STATUS OF REFERENCE',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                 SizedBox(height: 10.0),
                  
                  TextFormField(
                    // enabled: false,
                    onTap: (){

                        
                         Future<DateTime> selectedDate = showDatePicker(
   context: context,
   initialDate: DateTime(2020),
   firstDate: DateTime(2019),
   lastDate: DateTime(2030),
   builder: (BuildContext context, Widget child) {
     return Theme(
       data: ThemeData.dark(),
       child: child,
     );
   },
 );

 if(selectedDate!=null){
    selectedDate.then((onValue){
      setState(() {
      reciever.dueDate =   onValue.toString().substring(0,10);

      });
    });
 }
      
                    },
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Due Date cannot be empty' : null,
                    // initialValue: _dob,
                    onChanged: (value){
                        setState(() {
                          
                          value = reciever.dueDate;

                        });
                    },
                    decoration: InputDecoration(
                        suffixIcon: IconButton(icon: Icon(Icons.calendar_today),onPressed: (){
                             
                        },),
                        labelText: 'DUE DATE',
                        // hintText: "02-02-2000",
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
                      validator: (input) => input.isEmpty ? 'This cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.days = int.parse(value);
                             
                          },
                    decoration: InputDecoration(
                        hintText: "INFORM BEFORE HOW MANY DAYS OF THE DUE DATE",
                        labelText: 'INFORM DAY',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),

SizedBox(height: 10.0),

                 
                   Container(
                width: 150.0,
                height: 60.0,
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(20.0),
                    border: Border.all(color: Colors.blueGrey),
                ),
                child : DropdownButtonHideUnderline(

                  child: ButtonTheme(
                    
                    alignedDropdown: true,
                    child: new DropdownButton<String>(
                      value: gender,
                      items: _items.map((lable) {
                        return new DropdownMenuItem<String>(
                          value: lable,

                          child: new Text(lable),
                        );
                      }).toList(),
                      hint: Text('Gender'),
                      onChanged: (value) {
                        setState((){
                          if(reciever.gender==""){
                              reciever.gender = gender;
                          }
                          else{

                          }
                          reciever.gender = value;
    
                        });
                        
                      },
                    ),
                  ),
              ),
              ),
              
 SizedBox(height: 10.0),
                  
                    
                
              TextFormField(
                    keyboardType: TextInputType.number,
                      validator: (input) => input.isEmpty ? 'ACCOUNT NUMBER cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.accountNumber = value;
                             
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'ACCOUNT NUMBER',
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
                      validator: (input) => input.isEmpty ? 'MEMBER  cannot be empty' : null,
                      onChanged: (value){
                           
                            reciever.memberNeeded = value;
                             
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'MEMBER NEEDED',
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
                              'ADD RECIEVER',
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
        ) 
          ,)
        
        );

  }
}