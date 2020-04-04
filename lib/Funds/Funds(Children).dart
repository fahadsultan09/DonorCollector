import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Home/HomePage.dart';
import 'package:collector/Reponsibilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddChildrenFunds extends StatefulWidget {
  String parentID;
  AddChildrenFunds(this.parentID);

  @override
  _AddChildrenFundsState createState() => _AddChildrenFundsState();
}

class _AddChildrenFundsState extends State<AddChildrenFunds> {
  String _amount = "", _paymentMode = "", _remarks = "", _fcm = "";
  int totalAmount = 0;
  final _formKey = new GlobalKey<FormState>();
  @override
  void initState() {
    getTotal();
    super.initState();
  }

  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      print("Form is valid");
      return true;
    }
    return false;
  }

  void getTotal() {
    Firestore.instance
        .collection("Total")
        .document("Total")
        .get()
        .then((document) {
      if (document['Total'] != null) {
        setState(() {
          totalAmount = document['Total'];
        });
      }
    });
  }

  Future<void> _getUserFCM(uid) async => Firestore.instance
          .collection('Users2')
          .document(uid)
          .get()
          .then((DocumentSnapshot document) {
        if (document["token"] != null) {
          setState(() {
            _fcm = document["token"].toString();
          });
        }
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text(
          "FUNDS (CHILDRENS)",
          style: TextStyle(fontSize: 14),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, backgroundcolor])),
        child: FutureBuilder(
          future: Firestore.instance
              .collection("Users")
              .document(widget.parentID)
              .collection("children")
              .getDocuments(),
          builder: buildDonors,
        ),
      ),
    );
  }

  Widget buildDonors(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot user = snapshot.data.documents[index];

          return GestureDetector(
            onTap: () {
              _getUserFCM(user.documentID);
              print(_fcm);
              showDialog(
                  context: context,
                  builder: (context) {
                    return SimpleDialog(
                      title: Text('Payment'),
                      children: <Widget>[
                        Form(
                          key: _formKey,
                          child: Container(
                              padding: EdgeInsets.only(right: 10.0, left: 10.0),
                              height: MediaQuery.of(context).size.height / 2,
                              width: MediaQuery.of(context).size.width - 5,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (input) => input.isEmpty
                                        ? 'Payment Mode can not be null'
                                        : null,
                                    onChanged: (value) {
                                      _paymentMode = value;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'PAYMENT MODE',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.number,
                                    validator: (input) {
                                      if (input.isEmpty) {
                                        return 'Amount cannot be null';
                                      } else if (int.parse(input) == 0) {
                                        return 'Amount Value cannot be 0';
                                      } else {
                                        return null;
                                      }
                                    },
                                    onChanged: (value) {
                                      _amount = value;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'AMOUNT PAID (Rs.)',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                  ),
                                  TextFormField(
                                    keyboardType: TextInputType.text,
                                    validator: (input) => input.isEmpty
                                        ? 'REMARKS NOT NULL'
                                        : null,
                                    onChanged: (value) {
                                      _remarks = value;
                                    },
                                    decoration: InputDecoration(
                                        labelText: 'REMARKS',
                                        labelStyle: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            color: Colors.grey),
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                  ),
                                ],
                              )),
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
                              if (validateAndSave()) {
                                Firestore.instance
                                    .collection("Total")
                                    .document("Total")
                                    .setData({
                                  'Total': totalAmount + int.parse(_amount),
                                });
                                int _tempAmount =
                                    user["Amount"] + int.parse(_amount);

                                Firestore.instance
                                    .collection("Users")
                                    .document(user["Father Name"])
                                    .collection("children")
                                    .document(user.documentID)
                                    .updateData({
                                  "Amount": _tempAmount,
                                });

                                Firestore.instance
                                    .collection("Users2")
                                    .document(user.documentID)
                                    .updateData({
                                  "Amount": _tempAmount,
                                });

                                Firestore.instance
                                    .collection("DPayment")
                                    .document(user.documentID)
                                    .setData({
                                  "1": "1",
                                });
                                Firestore.instance
                                    .collection("DPayment")
                                    .document(user.documentID)
                                    .collection("MyPayment")
                                    .document()
                                    .setData({
                                  "Full Name": user["Full Name"],
                                  "DateOfPayment": DateTime.now()
                                      .toString()
                                      .substring(0, 10),
                                  "Amount": _amount,
                                  "PaymentMode": _paymentMode,
                                  "Remarks": _remarks,
                                  "Month": DateTime.now().month,
                                });
                                Firestore.instance
                                    .collection("DonorPayment")
                                    .document()
                                    .setData({
                                  "Full Name": user["Full Name"],
                                  "DateOfPayment": DateTime.now()
                                      .toString()
                                      .substring(0, 10),
                                  "Amount": _amount,
                                  "PaymentMode": _paymentMode,
                                  "Remarks": _remarks,
                                  "Month": DateTime.now().month,
                                  "timestamp": DateTime.now(),
                                });
                                Firestore.instance
                                    .collection("Payment")
                                    .document(user.documentID)
                                    .setData({
                                  "Name": user["Full Name"],
                                  "document": user.documentID,
                                  "fcm": _fcm.toString(),
                                });
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => Home()),
                                    (Route<dynamic> route) => false);
                              }
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
                  title: Text(
                    user["Full Name"],
                    style: TextStyle(fontSize: 19.0),
                  ),
                  subtitle: Text(
                    user["Email"],
                    style: TextStyle(fontSize: 13.0),
                  ),
                  trailing: Text(
                    "Phone: " + user["Phone"],
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
        child: Text("No Childrens found."),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
