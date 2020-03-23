
import 'package:flutter/material.dart';

import 'package:collector/Home/HomePage.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ADMIN',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: Home(), 
    );
  }
}


//Due date  Funds
// purpose of Fund
// Member Needed --> Purpose
// Due Date dalni pare gi

// Monthly or 1 time

// Cap All
// pyament by donor =====> Fund history
// Payment To Responsibilty =======> Responsibility 
// Rename
