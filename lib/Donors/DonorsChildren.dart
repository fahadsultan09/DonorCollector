

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Home/HomePage.dart';
import 'package:collector/Reciever/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChildrenList extends StatefulWidget {
   String parentID;
  ChildrenList(this.parentID);
 
  @override
  _ChildrenListState createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  String _amount = "",_paymentMode = "",_remarks = "";
  FirebaseMessaging fcm = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text("ADD PAYMENTS"),
          ),
          body: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, color1])
              ),
        child: FutureBuilder(
          future: Firestore.instance.collection("Users").document(widget.parentID).collection("children").getDocuments(),
          // initialData: InitialData,
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
      // child: Container(),
        context: context,
        builder: (context) {
          return SimpleDialog(

            // backgroundColor: Colors.black12,
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
                    int _tempAmount = user["Amount"]+int.parse(_amount);
                    print(user.documentID);
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
                leading: CircleAvatar(
                  child: Text(user["Full Name"].toString().substring(0,1),style: TextStyle(fontWeight: FontWeight.bold),),
                  // backgroundImage: AssetImage("assets/images/islamabad.jpg"),
                  radius: 25,
                ),
                // title: Text(transaction['name']),
                title: Text(user["Full Name"]),
                subtitle: Text(user["Phone"]),
                trailing: Text(
                  user["Amount"].toString(),
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
        // Handle no data
        return Center(
            child: Text("No Donors found."),
        );
    } else {
        // Still loading
        return Center(child: CircularProgressIndicator());
    }
}

// _displayDialog(BuildContext context) async {
//     return 
//   }
}