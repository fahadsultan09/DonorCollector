
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collector/Home/HomePage.dart';
import 'package:collector/Reciever/utils.dart';
import 'package:flutter/material.dart';

 
class transferAmount extends StatefulWidget {
  
  transferAmount(this._recieveruser) : super();
  
  final String title = "transferAmounts";
  DocumentSnapshot _recieveruser;
  @override
  transferAmountState createState() => transferAmountState();
}
 
class transferAmountState extends State<transferAmount> {
  int amount = 0;
  @override
  void initState() {
    amount = widget._recieveruser["Amount"];
    
      super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        height: 50.0,
        decoration: BoxDecoration(
          // borderRadius: BorderRadius.circular(10.0),
  gradient: LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    colors: [Colors.orange, Colors.red])),
        child: Center(
          child: Text(
            'AMOUNT REQUIRED Rs. '+amount.toString(),
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
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
              colors: [Colors.black, color1])
              
              ),
        padding: EdgeInsets.all(5),
        child: FutureBuilder(
          future: Firestore.instance.collection("Users2").getDocuments(),
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
                DocumentSnapshot _donorUser = snapshot.data.documents[index];

                return GestureDetector(
                    onTap: (){},
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
                      _donorUser["Full Name"],
                      
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  subtitle: Text("Rs. "+_donorUser["Amount"].toString(),style: TextStyle(fontSize: 20),),
                  trailing: FlatButton(color: Colors.grey,onPressed: ()
                  {
                      int inputValue = 0;
                      

                      
                    showDialog(
                  // child: Container(),
                    context: context,
                    builder: (context) {
                        return SimpleDialog(

                        // backgroundColor: Colors.black12,
                        title: Text('Amount Payment'),
                        children: <Widget>[
                          Container(
                          padding: EdgeInsets.only(right: 10.0,left: 10.0),
                    
                          height: MediaQuery.of(context).size.height /2,
                          width: MediaQuery.of(context).size.width-5,
                          
                          child: TextFormField(
                                keyboardType: TextInputType.text,
                                  validator: (input) => input.isEmpty ? 'Amount Value cannot be null' : null,
                                  onChanged: (value){
                                      inputValue = int.parse(value);
                          },
                        decoration: InputDecoration(
                        
                        labelText: 'AMOUNT',
                        labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green
                            )
                            )
                        ),
                  ),
              
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

                    setState(() {

                    if(inputValue<=_donorUser["Amount"] && inputValue<=amount){


                    amount = amount - inputValue;
                    int temp_amount = _donorUser["Amount"] - inputValue;
                    Firestore.instance.collection("Users2").document(_donorUser.documentID).updateData({
                      "Amount":temp_amount,
                    }); 
                    Firestore.instance.collection("Pipeline").document(widget._recieveruser.documentID).updateData({
                      "Amount":amount,
                    });
                    Firestore.instance.collection("MyZakat").document(_donorUser.documentID).setData({"1":1});
                    Firestore.instance.collection("MyZakat").document(_donorUser.documentID).collection("MyPayments").document().setData({
                      "fcm":_donorUser["fcm"],
                      "Amount":amount,
                      "Name:":widget._recieveruser["FullName"],
                      "PaymentDate":DateTime.now().toString().substring(0,10),
                    });

                    Navigator.of(context).pop();

                    }
                    else{
                      Navigator.of(context).pop();
                    }  
                    if(amount<=0){
                      
                      Firestore.instance.collection("Pipeline").document(widget._recieveruser.documentID).delete();
                       Navigator.of(context).push(MaterialPageRoute(builder: (context) =>Home())); 
                    }

                    });

                                  
                    // Navigator.of(context).pop();
                    
                  },
                )
              ])
            ],
          );
        });
                    
                  }, child: Text("PAY",style: TextStyle(fontSize: 20),),),
         
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

