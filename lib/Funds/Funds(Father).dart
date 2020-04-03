import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Funds/CreateFunds.dart';
import 'package:collector/Funds/Funds(Children).dart';
import 'package:collector/Reponsibilities/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyFunds extends StatefulWidget {
  @override
  _MyFundsState createState() => _MyFundsState();
}

class _MyFundsState extends State<MyFunds> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueGrey,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => CreateFunds()));
        },
        tooltip: 'Add Donors',
        child: new Icon(
          Icons.add,
          size: 25,
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: Text(
          "FUNDS (FATHER)",
          style: TextStyle(fontSize: 16.0),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, backgroundcolor])),
        child: FutureBuilder(
          future: Firestore.instance.collection("Users").getDocuments(),
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
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => AddChildrenFunds(user.documentID)));
            },
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Container(
                color: Colors.white,
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      user.documentID.toString().substring(0, 1),
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    radius: 25,
                  ),
                  title: Text(user.documentID),
                  trailing: Icon(
                    Icons.person,
                    size: 30.0,
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
        child: Text("No Donors found."),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
