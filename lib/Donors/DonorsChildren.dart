

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Home/HomePage.dart';
import 'package:collector/Reciever/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class childrenList extends StatefulWidget {
   String parentID;
  childrenList(this.parentID);
 
  @override
  _childrenListState createState() => _childrenListState();
}

class _childrenListState extends State<childrenList> {
  String _amount = "",_paymentMode = "",_remarks = "";
  
  FirebaseMessaging fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("ADD PAYMENTS (CHILDRENS)",style: TextStyle(fontSize: 14),),
          ),
          body: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, backgroundcolor])
              ),
        child: FutureBuilder(
          future: Firestore.instance.collection("Users").document(widget.parentID).collection("children").getDocuments(),
          
          builder: buildDonors,
        ),
      ),
    );
  }

  Widget buildDonors(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    

    if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data.documents[index];

                
                return GestureDetector(
                    onTap: ()
                    {
                    showDialog(
      
        context: context,
        builder: (context) {
          return SimpleDialog(

            
            title: Text('Payment'),
            children: <Widget>[
              Container(
              padding: EdgeInsets.only(right: 10.0,left: 10.0),
         
              height: MediaQuery.of(context).size.height /2,
              width: MediaQuery.of(context).size.width-5,
              
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                   TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'Payment Mode' : null,
                      onChanged: (value){
                           _paymentMode = value;
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'PAYMENT MODE',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                      validator: (input) => input.isEmpty ? 'AMOUNT NOT NULL' : null,
                      onChanged: (value){
                           _amount = value;
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'AMOUNT PAID (Rs.)',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.text,
                      validator: (input) => input.isEmpty ? 'REMARKS NOT NULL' : null,
                      onChanged: (value){
                           _remarks = value;
                          },
                    decoration: InputDecoration(
                        
                        labelText: 'REMARKS',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green))),
                  ),
                ],
              )
              
              ),

              SizedBox(
                height: 20.0,
              ),
              new Row(children: <Widget>[
                new FlatButton(
                  child: new Text('CANCEL'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                new FlatButton(
                  child: new Text('SUBMIT'),
                  onPressed: () {
                    int _tempAmount = user["Amount"] +int.parse(_amount);
                 
                    Firestore.instance.collection("Users").document(user["Father Name"]).collection("children").document(user.documentID).updateData({
                      "Amount":_tempAmount,
                    });
                    
                    Firestore.instance.collection("Users2").document(user.documentID).updateData({
                      "Amount":_tempAmount,
                    });
                    

                    Firestore.instance.collection("DPayment").document(user.documentID).setData({
                      "1":"1",
                    });
                    Firestore.instance.collection("DPayment").document(user.documentID).collection("MyPayment").document().setData({
                        "Full Name":user["Full Name"],
                        "DateOfPayment":DateTime.now().toString().substring(0,10),
                        "Amount":_amount,
                        "PaymentMode":_paymentMode,
                        "Remarks":_remarks,
                        "Month":DateTime.now().month,
                    });
                    Firestore.instance.collection("DonorPayment").document(user.documentID).setData({
                        "Full Name":user["Full Name"],
                        "DateOfPayment":DateTime.now().toString().substring(0,10),
                        "Amount":_amount,
                        "PaymentMode":_paymentMode,
                        "Remarks":_remarks,
                        "Month":DateTime.now().month,
                        "timestamp":DateTime.now(),
                    });
                    Firestore.instance.collection("Payment").document(user.documentID).setData({
                        "document":user.documentID,
                        "fcm":user["token"],
                    });                 
                    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                    Home()), (Route<dynamic> route) => false);
          
                  },
                )
              ])
            ],
          );
        });
                    },
                                  child: Container(
                                    padding: EdgeInsets.all(4),
                                    child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: ListTile(

                title: Text(user["Full Name"],style: TextStyle(fontSize: 19.0),),
                subtitle: Text(user["Email"],style: TextStyle(fontSize: 13.0),),
                trailing: Text(
                  
                  "Phone: "+user["Phone"],
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
                                  ),
                );
            },
        );
    } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData ){
        
        return Center(
            child: Text("No Donors found."),
        );
    } else {
        
        return Center(child: CircularProgressIndicator());
    }
}

}