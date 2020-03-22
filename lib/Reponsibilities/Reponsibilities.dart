
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Home/HomePage.dart';
import 'package:collector/Reponsibilities/AddReponsibilities.dart';
import 'package:flutter/material.dart';

 
class Reponsibilities extends StatefulWidget {
  Reponsibilities() : super();
 
  final String title = "My Reponsibilitiess";
 
  @override
  ReponsibilitiesState createState() => ReponsibilitiesState();
}
 
class ReponsibilitiesState extends State<Reponsibilities> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red,
        onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=>AddReponsibilities()));
        },
        tooltip: 'Add Reponsibilities',
        child: new Icon(Icons.add,size: 40,),
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
                     
                        showDialog(context: context,builder: (context){

                      return Center(
                        child: SimpleDialog(

                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            Text("RECIEVER"),
                            
                            
                            
                            
                            
                            
                            
                            

                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            
                            SizedBox.fromSize(
                              size: Size(56, 56), 
                              child: ClipOval(
                                child: Material(
                                  color: Colors.red, 
                                  child: InkWell(
                                    splashColor: Colors.blueGrey, 
                                    onTap: () {
                                      Navigator.of(context).pop();

                                      Firestore.instance.collection("Reciever").document(user.documentID).delete();
                                      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>Home()), (Route<dynamic> route) => false);

                                    
                                    }, 
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(Icons.delete,size: 20.0,), 
                                        Text("Delete"), 
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],),
                          children: <Widget>[

                              Container(
                                padding: EdgeInsets.only(right: 10.0,left: 10.0),
         
                                height: MediaQuery.of(context).size.height /2,
                                width: MediaQuery.of(context).size.width-5,

                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[

                                    Row(
                                      children: <Widget>[
                                        Text("Name: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text(user["FullName"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                     Row(
                                      children: <Widget>[
                                        Text("Father Name: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text(user["FatherName"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                     Row(
                                      children: <Widget>[
                                        Text("Due Amount/Month: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text("Rs. "+user["Amount"].toString(),style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                    //  Row(
                                    //   children: <Widget>[
                                    //     Text("Due Date: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    // Text(user["DueDate"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
                                    //   ],
                                    // ),
                                     Row(
                                      children: <Widget>[
                                        Text("Phone: ",style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                    Text(user["Phone"],style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)
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
                height: 90,
                decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.white70, Colors.blue[900]]),
              
              
                  borderRadius: BorderRadius.circular(12.0),
                ),
                
                
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
                      user["FullName"],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        
                    "Rs ."+user["Amount"].toString(),
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // Text(
                  //   "Due Day:   "+user["DueDate"].toString(),
                  //   style: TextStyle(
                  //     fontSize: 13,
                  //     color: Colors.red,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                    ],
                  )
                ),
            ),
              ),
                );
            },
        );
    } else if (snapshot.connectionState == ConnectionState.done && !snapshot.hasData ){
        
        return Center(
            child: Text("No Pipeline found.",style: TextStyle(color: Colors.black),),
        );
    } else {
        
        return Center(child: CircularProgressIndicator());
    }
}

}


showAlertDialog(BuildContext context,String id) {

  

  Widget cancelButton = FlatButton(
    child: Text("Cancel",style: TextStyle(color: Colors.green),),
    onPressed:  () {
      Navigator.of(context).pop();
    },
  );
  Widget launchButton = FlatButton(
    child: Text("Continue",style: TextStyle(color: Colors.red),),
    onPressed:  () {
      
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Reponsibilities()));
      
      
    },
  );

  
  AlertDialog alert = AlertDialog(
    title: Text("Notice"),
    content: Text("Pressing this Continue button will Delete the Reciever Forever\nThank You",style: TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold),),
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


