import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Reponsibilities/utils.dart';
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
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text("Responsibility History"),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, backgroundcolor])),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance
              .collection("DonorZakat")
              .orderBy('timestamp', descending: true)
              .getDocuments(),
          builder: buildReciever,
        ),
      ),
    );
  }

  Widget buildReciever(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data.documents[index];

          return GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Center(
                      child: SimpleDialog(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text("RECIEVER"),
                          ],
                        ),
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(right: 2.0, left: 2.0),
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Donor Name:   ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user["DonorName"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.bold),
                                    ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Responsibitility Name:  ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user["Name"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Amount Paid:  ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    Expanded(
                                        child: Text(
                                      "Rs. " + user["Amount"].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Purpose: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user["ResponsibiltyType"].toString(),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ))
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      "Payment Date: ",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ),
                                    Expanded(
                                        child: Text(
                                      user["PaymentDate"],
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat'),
                                    ))
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  });
            },
            child: Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.black, backgroundcolor]),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: ListTile(
                  title: Text("Responsibility Name :" + user["Name"],
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  subtitle: Text(
                    "Payment Date: " + user["PaymentDate"].toString(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  trailing: Text(
                    "Rs. " + user["Amount"].toString(),
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
    } else if (snapshot.connectionState == ConnectionState.done &&
        !snapshot.hasData) {
      return Center(
        child: Text(
          "No Pipeline found.",
          style: TextStyle(color: Colors.black),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
