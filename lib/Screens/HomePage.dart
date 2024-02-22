import 'package:flutter/material.dart';
import '../Models/listModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  ValueNotifier<List<listItems>> studentlistNotifier= ValueNotifier([]);
  final FocusNode nameFocusNode = FocusNode();
  
  void _addStudentDetails() {
    final String _name = nameController.text;
    final String _age = ageController.text;
    final listItems data = listItems(name: _name, age: _age);
      studentlistNotifier.value.add(data);
      studentlistNotifier.notifyListeners();      nameController.clear();
      ageController.clear();
      FocusScope.of(context).requestFocus(nameFocusNode);
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextFormField(
              focusNode: nameFocusNode,
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Enter Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
                hintText: 'Enter Age',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _addStudentDetails,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add),
                  SizedBox(width: 2),
                  Text('Add Student'),
                ],
              ),
            ),
            Expanded(
                child: ValueListenableBuilder(
                  valueListenable:studentlistNotifier ,
                  builder:(BuildContext ctx, List<listItems>studentlist, child) {
                    return ListView.separated(
                                itemBuilder: (ctx, index) {
                  return ListTile(
                    title: Text(studentlist[index].name,style:TextStyle(
                      fontSize: 20,
                    )),
                    subtitle: Text(studentlist[index].age,style:TextStyle(
                  fontSize:16,
                  ),
                  ),
                  );
                                },
                                separatorBuilder: (ctx, index) {
                  return Divider();
                                },
                                itemCount: studentlist.length,
                              );
                  }
                ),
                ),
          ],
        ),
      ),
    );
  }
}
