

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Donors/DonorsChildren.dart';
import 'package:collector/Reciever/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDonors extends StatefulWidget {
  @override
  _MyDonorsState createState() => _MyDonorsState();
}

class _MyDonorsState extends State<MyDonors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(backgroundColor: Colors.black,
            title: Text("Donors"),
          ),
          body: Container(
            decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.black, color1])
              
              ),
        child: FutureBuilder(
          future: Firestore.instance.collection("Users").getDocuments(),
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
                    onTap: (){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ChildrenList(user.documentID)));
                    },
                                  child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text(user.documentID.toString().substring(0,1),style: TextStyle(fontWeight: FontWeight.bold),),

                  radius: 25,
                ),

                title: Text(user.documentID),
 
                trailing: Text(
                  "231",
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
            child: Text("No Donors found."),
        );
    } else {
        // Still loading
        return Center(child: CircularProgressIndicator());
    }
}
}