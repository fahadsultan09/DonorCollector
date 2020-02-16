
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MyRecieverPayments extends StatefulWidget {
  @override
  _MyRecieverPaymentsState createState() => _MyRecieverPaymentsState();
}

class _MyRecieverPaymentsState extends State<MyRecieverPayments> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,title: Text("RECIEVERS PAYMENTS"),
            ),

              body: Container(
         decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, Colors.blue[900]])
              
              ),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance.collection("DonorZakat").orderBy('PaymentDate').getDocuments(),
          // initialData: InitialData,
          builder: buildReciever,
        ),
      ),
      
    );
    
  }

  Widget buildReciever(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

    if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) {
                DocumentSnapshot user = snapshot.data.documents[index];

                return Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.white70, Colors.blue[900]]),
                
                
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  // height: 200,
                  // color: Colors.amber,
                  child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  title: Text(user["Name"],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                  subtitle: Text("Payment Date: "+user["PaymentDate"].toString(),style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  trailing: Text(
                  "Rs. "+user["Amount"].toString(),
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
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
            child: Text("No Pipeline found.",style: TextStyle(color: Colors.black),),
        );
    } else {
        // Still loading
        return Center(child: CircularProgressIndicator());
    }
}
  
}