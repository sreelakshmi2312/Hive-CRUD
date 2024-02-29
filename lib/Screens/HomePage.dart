import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hivecrud/models/listModel.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  Box<listItems>? studentBox;

  @override
  void initState() {
    super.initState();
    studentBox = Hive.box<listItems>('student_db');
  }

  void _addStudentDetails() async {
    final String name = _nameController.text;
    final String age = _ageController.text;

    if (name.isNotEmpty && age.isNotEmpty) {
      final student = listItems(name: name, age: age);
      await studentBox!.add(student);

      _nameController.clear();
      _ageController.clear();

      
      setState(() {});
    }
  }

  void _deleteStudent(int index) async {
    await studentBox!.deleteAt(index);
    setState(() {});
  }

  void _editStudent(int index, String stname, String stage) {
  _nameController.text = stname;
  _ageController.text = stage;

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Edit Student'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), 
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _nameController.clear();
              _ageController.clear();

            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              final String name = _nameController.text;
              final String age = _ageController.text;

              if (name.isNotEmpty && age.isNotEmpty) {
                final student = listItems(name: name, age: age);
                studentBox!.putAt(index, student); 
                _nameController.clear();
                _ageController.clear();
                setState(() {});
              }
            },
            child: Text('Save'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(
        title: Text('Hive CRUD Demo'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _ageController,
              decoration: InputDecoration(labelText: 'Age'),
            ),
          ),
          ElevatedButton(

            onPressed: _addStudentDetails,
            child: Text('Add Student'),
                        
                        ),
              
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: studentBox!.listenable(),
              builder: (context, Box<listItems> box, _) {
                if (box.values.isEmpty) {
                  return Center(child: Text('No data'));
                }
                return ListView.builder(
                  itemCount: box.values.length,
                  itemBuilder: (context, index) {
                    listItems? currentStudent = box.getAt(index);
                    return ListTile(
                      title: Text(currentStudent!.name),
                      subtitle: Text('Age: ${currentStudent.age}'),
                      trailing: Container(
                        width:96,
                        child: Row(
                          children: [
                            IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () => {
                              _editStudent(index,currentStudent.name,currentStudent.age)
                            }
                          ),
                            IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _deleteStudent(index),
                          ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
