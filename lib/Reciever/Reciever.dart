
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Reciever/AddReciever.dart';
import 'package:flutter/material.dart';

 
class Reciever extends StatefulWidget {
  Reciever() : super();
 
  final String title = "Recievers";
 
  @override
  RecieverState createState() => RecieverState();
}
 
class RecieverState extends State<Reciever> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        
        onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddReciever()));
        },
        tooltip: 'Add',
        child: new Icon(Icons.add),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.title),
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
          future: Firestore.instance.collection("Reciever").getDocuments(),
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

                return GestureDetector(
                    onTap: (){
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>ChildrenList(user.documentID)));
                    },
              child: Container(
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
            semanticContainer: true,
          
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: ListTile(
                  
                  dense: true,
                  // leading: CircleAvatar(
                  //   child: Icon(Icons.person),
                  //   radius: 25,
                  // ),
                  // title: Text(transaction['name']),
                  title: Text(
                      user["FullName"],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  subtitle: Text(user["Phone"]),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        
                    "Rs ."+user["Amount"].toString(),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Due Date "+user["DueDate"],
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                    ],
                  )
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