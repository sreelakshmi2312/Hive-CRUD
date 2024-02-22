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
  final _nameController = TextEditingController();
  final _ageController = TextEditingController();
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
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => _deleteStudent(index),
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
