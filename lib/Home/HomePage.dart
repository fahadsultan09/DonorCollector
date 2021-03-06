import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Funds/Funds(Father).dart';
import 'package:collector/Home/TransferAmount.dart';
import 'package:collector/Funds/FundsHistory.dart';
import 'package:collector/Reponsibilities/ResponsibilityHistory.dart';
import 'package:collector/Reponsibilities/Reponsibilities.dart';
import 'package:collector/Reponsibilities/utils.dart';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int amount = 0;
  List<DocumentSnapshot> balancedocuments;

  Future<void> getBalance() async {
    final QuerySnapshot result =
        await Firestore.instance.collection("Users2").getDocuments();
    balancedocuments = result.documents.toList();
    balancedocuments.forEach((data) {
      if (data["Amount"] is int) {
        setState(() {
          amount = amount + data["Amount"];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getBalance();
  }

  List<DocumentSnapshot> documents;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        elevation: 1.0,
        child: Container(
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.asset(
              "assets/images/islamabad.jpg",
              fit: BoxFit.cover,
              color: Colors.black54,
              colorBlendMode: BlendMode.darken,
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                    child: Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/images/Logo.jpg"),
                          fit: BoxFit.cover)),
                )),
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.white70,
                  ),
                  title: Text('Home',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.swap_horiz,
                    color: Colors.white70,
                  ),
                  title: Text('Funds',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => MyFunds()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.notification_important,
                    color: Colors.white70,
                  ),
                  title: Text('Responsibilities',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => Reponsibilities()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.monetization_on,
                    color: Colors.white70,
                  ),
                  title: Text('Funds History',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => FundsHistory()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.history,
                    color: Colors.white70,
                  ),
                  title: Text('Responsibility History',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyRecieverPayments()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.attach_money,
                    color: Colors.white70,
                  ),
                  title: Text('Total Balance',
                      style: TextStyle(
                        color: Colors.white70,
                      )),
                  trailing:
                      Text(amount == 0 ? "Rs. 0" : "Rs.   " + amount.toString(),
                          style: TextStyle(
                            color: Colors.white70,
                          )),
                ),
                Divider(
                  color: Colors.black87,
                  height: 50,
                ),
                ListTile(
                  leading: Icon(
                    Icons.exit_to_app,
                    color: Colors.white70,
                  ),
                  title: Text("Exit",
                      style: TextStyle(color: Colors.white70, fontSize: 15.0)),
                ),
              ],
            ),
          ],
        )),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Admin"),
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.refresh),
                  iconSize: 30.0,
                  onPressed: () {
                    showAlertDialog(context);
                  }),
            ],
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.black, backgroundcolor])),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance.collection("Pipeline").getDocuments(),
          builder: buildPipeline,
        ),
      ),
    );
  }

  Widget buildPipeline(
      BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
    if (snapshot.hasData) {
      return ListView.builder(
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          DocumentSnapshot responsibilityUser = snapshot.data.documents[index];

          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => transferAmount(responsibilityUser)));
            },
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  semanticContainer: true,
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: ListTile(
                      dense: true,
                      title: Text(
                        responsibilityUser["FullName"] != null
                            ? responsibilityUser["FullName"]
                            : "",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      subtitle: responsibilityUser["AccountNumber"] != null
                          ? Text(
                              "A/C no. : " +
                                  responsibilityUser["AccountNumber"],
                              style: TextStyle(fontSize: 10.0),
                            )
                          : Text(
                              "A/C no. : " + "NONE",
                              style: TextStyle(fontSize: 10.0),
                            ),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            responsibilityUser["Amount"].toString() != null
                                ? "Rs.  " +
                                    responsibilityUser["Amount"].toString()
                                : "",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
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
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }

  void getPipeline() async {
    final QuerySnapshot result =
        await Firestore.instance.collection("Reciever").getDocuments();
    documents = result.documents.toList();
    documents.forEach((row) {
      Firestore.instance
          .collection("Pipeline")
          .document(row.documentID)
          .setData(row.data);
    });

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => Home()),
        (Route<dynamic> route) => false);
  }

  showAlertDialog(BuildContext context) {
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget launchButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        getPipeline();
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Notice"),
      content: Text(
          "Pressing this Continue button will create Responsilities of this month. This button must be pressed once in month\nThank You"),
      actions: [
        cancelButton,
        launchButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
