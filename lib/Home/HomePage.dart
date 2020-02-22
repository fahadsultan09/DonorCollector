
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Donors/Donors.dart';
import 'package:collector/Home/TransferAmount.dart';
import 'package:collector/MyPayments.dart';
import 'package:collector/Reciever/Reciever.dart';
import 'package:collector/Reciever/utils.dart';
import 'package:collector/ZakatPayments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  // int pipelineSize = 0;
  List<DocumentSnapshot> documents;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Drawer(
        
        elevation: 1.0,
        child: Container(
          child: Stack(fit:StackFit.expand,children: <Widget>[

            Image.asset("assets/images/islamabad.jpg",fit: BoxFit.cover,color: Colors.black54,colorBlendMode: BlendMode.darken,),
            ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            
            DrawerHeader(

                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(image:AssetImage("assets/images/Logo.jpg"),fit: BoxFit.cover)
                  ),
                )

            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.home,color: Colors.white70,),
              title: Text('HOME',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.swap_horiz,color: Colors.white70,),
              title: Text('MY DONORS',style: TextStyle(color: Colors.white70,)),
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyDonors()));
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.notification_important,color: Colors.white70,),
              title: Text('MY RECIEVERS',style: TextStyle(color: Colors.white70,)),
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Reciever()));
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.monetization_on,color: Colors.white70,),
              title: Text('PAYMENTS BY DONOR',style: TextStyle(color: Colors.white70,)),
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyDonorPayments()));
              },
            ),
            ListTile(
              // trailing: Text(),
              leading: Icon(Icons.monetization_on,color: Colors.white70,),
              title: Text('PAYMENTS TO RECIEVER',style: TextStyle(color: Colors.white70,)),
              onTap: () {

                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>MyRecieverPayments()));
              },
            ),
            Divider(color: Colors.black87,height: 50,),
            // Expanded(child: SizedBox(height: 30.0,),),
            ListTile(

              onTap: (){
                // FirebaseAuth.instance.signOut();
                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LoginPage()));
              },
              // trailing: Text(),
              leading: Icon(Icons.exit_to_app,color: Colors.white70,),
              title: Text("Sign Out",style: TextStyle(color: Colors.white70,fontSize: 15.0)),
              // subtitle: Text(_islamicDate.toString(),style: TextStyle(color: Colors.white70,)),

              // isThreeLine: true,
            ),
          ],
        ),
        ],)
        ),

      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Admin"),
        actions: <Widget>[
          new Stack(
            children: <Widget>[
              new IconButton(icon: Icon(Icons.refresh),iconSize: 30.0, onPressed: () {

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
                              colors: [Colors.black, color1])
                              
                              ),
                        padding: EdgeInsets.all(5),
                        child: FutureBuilder(
                          future: Firestore.instance.collection("Pipeline").getDocuments(),
                          // initialData: InitialData,
                          builder: buildPipeline,
                        ),
                      ),
                    );
                  }
                  Widget buildPipeline(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                
                    if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                                DocumentSnapshot user = snapshot.data.documents[index];
                
                                return GestureDetector(
                                    onTap: (){
                
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>transferAmount(user)));
                                    },
                              child: Container(
                                height: 100.0,
                                // padding: EdgeInsets.all(19),
                                decoration: BoxDecoration(
                            // gradient: LinearGradient(
                            //   begin: Alignment.topRight,
                            //   end: Alignment.bottomLeft,
                            //   colors: [Colors.white70, Colors.blue[900]]),
                              
                              
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                // height: 200,
                                // color: Colors.amber,
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
                                    subtitle: user["AccountNumber"]!=null?Text("A/C no. : "+user["AccountNumber"],style: TextStyle(fontSize: 10.0),):Text("A/C no. : "+"NONE",style: TextStyle(fontSize: 10.0),),
                                    trailing: Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          
                                      "Rs. "+user["Amount"].toString(),
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.green,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "Due Date "+user["DueDate"],
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                      ],
                                    )
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
                            child: Text("No Pipeline found.",style: TextStyle(color: Colors.white),),
                        );
                    } else {
                        // Still loading
                        return Center(child: CircularProgressIndicator());
                    }
                }
                
                  void getPipeline()async {

                  final QuerySnapshot result = await Firestore.instance.collection("Reciever").getDocuments();
                    documents = result.documents.toList();
                    documents.forEach((row){
                      // data.documentID.toString();
                      Firestore.instance.collection("Pipeline").document(row.documentID).setData(row.data);
                      // myBatch.add(data.documentID.toString());
                    });


                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                      Home()), (Route<dynamic> route) => false);
                  }
                  showAlertDialog(BuildContext context) {

  // set up the buttons

  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget launchButton = FlatButton(
    child: Text("Continue"),
    onPressed:  () {

      getPipeline();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Pressing this Continue button will create Recievers of this month. This button must be pressed once in month\nThank You"),
    actions: [
      cancelButton,
      launchButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


}


