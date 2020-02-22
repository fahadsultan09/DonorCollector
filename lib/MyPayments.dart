
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MyDonorPayments extends StatefulWidget {
  @override
  _MyDonorPaymentsState createState() => _MyDonorPaymentsState();
}

class _MyDonorPaymentsState extends State<MyDonorPayments> {

List<String> month = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,title: Text("PAYMENTS BY DONOR"),
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
          future: Firestore.instance.collection("DonorPayment").getDocuments(),
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
                  title: Text(user["Full Name"],style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold)),
                  subtitle: Text("Payment Date: "+user["DateOfPayment"],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                  "Rs. "+user["Amount"],
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
 
                  Text(
                  "Payment Mode: "+user["PaymentMode"],
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    ],
                  )
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