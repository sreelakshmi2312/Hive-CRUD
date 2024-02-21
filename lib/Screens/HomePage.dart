import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body:Padding(padding: EdgeInsets.all(10),
        child:Column(children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter Name',
            border:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),)
         ),
        ),
        SizedBox(height:10),
        TextFormField(
          decoration: InputDecoration(
            hintText: 'Enter Age',
            border:OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),)
         ),
        ),
      ],),
      ),
    );
  }
}