import 'dart:developer';

import 'package:data_base/models/demo_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();
  final TextEditingController programIdController = TextEditingController();
  final TextEditingController gpaController = TextEditingController();
  // final CollectionReference _product =
  //     FirebaseFirestore.instance.collection('product');

  // late String StudentName, StudentID, StudyProgramID;
  // late double StudentGPA;

  createData() {
    // print("createData");

    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('MyStudents')
        .doc(idController.text);

    Map<String, dynamic> students = {
      "studentName": nameController.text,
      "studentID": idController.text,
      "studyprogramID": programIdController.text,
      "studentGPA": gpaController.text,
    };
    documentReference
        .set(students)
        .whenComplete(() => print("${nameController.text} created"));
  }

  Future getuserData({required String studentId}) async {
    DocumentReference documentReference =
        FirebaseFirestore.instance.collection('MyStudents').doc(studentId);

    documentReference.get().then(
      (datasnapshot) {
        nameController.text = datasnapshot['studentName'];
        idController.text = datasnapshot['studentID'];
        programIdController.text = datasnapshot['studyprogramID'];
        gpaController.text = datasnapshot['studentGPA'].toString();

        log(datasnapshot.data().toString());
      },
    );
    //  await FirebaseFirestore.instance.collection('MyStudents').get().then(
    //       (snapshot) => snapshot.docs.forEach(
    //         (document) {
    //           final studentName = document.data()['studyprogramID'];

    //           if (docIDs.contains(studentName)) {
    //           } else {
    //             docIDs.add(studentName);
    //             print(docIDs);
    //           }
    //           print(document.data());
    //         },
    //       ),
    //     );
  }

  List<String> docIDs = [];

  Future readData() async {
    await FirebaseFirestore.instance.collection('MyStudents').get().then(
          (snapshot) => snapshot.docs.forEach(
            (document) {
              final studentName = document.data()['studentName'];

              if (docIDs.contains(studentName)) {
              } else {
                docIDs.add(studentName);
                print(docIDs);
              }
              print(document.data());
            },
          ),
        );
  }

  @override
  void initState() {
    // readData();
    super.initState();
  }

  updateData() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('MyStudents')
        .doc(idController.text);

    Map<String, dynamic> students = {
      "studentName": nameController.text,
      "studentID": idController.text,
      "studyprogramID": programIdController.text,
      "studentGPA": gpaController.text,
    };
    documentReference
        .update(students)
        .whenComplete(() => print("${nameController.text}  updated"));
  }

  deleteData() {
    DocumentReference documentReference = FirebaseFirestore.instance
        .collection('MyStudents')
        .doc(idController.text);

    Map<String, dynamic> students = {
      "studentName": nameController.text,
      "studentID": idController.text,
      "studyprogramID": programIdController.text,
      "studentGPA": gpaController.text,
    };
    documentReference
        .delete()
        .whenComplete(() => print("${nameController.text} deleted"));
  }

  @override
  Widget build(BuildContext context) {
    // TextEditingController controllerName = TextEditingController();
    // TextEditingController controllerAge = TextEditingController();
    // TextEditingController controllerDate = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.arrow_back),
          title: const Text('Add User'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String name) {
                  // getStudentName(name);
                  // nameController.text = 'bsackjbajks';
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: idController,
                decoration: const InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String id) {
                  // getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: programIdController,
                decoration: const InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String programID) {
                  // getStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: gpaController,
                decoration: const InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                onChanged: (String gpa) {
                  // getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    setState(() {
                      createData();
                    });
                  },
                  textColor: Colors.white,
                  child: const Text("Create"),
                ),
                RaisedButton(
                  color: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    getuserData(
                      studentId: idController.text,
                    );
                  },
                  textColor: Colors.white,
                  child: Text("Read"),
                ),
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    updateData();
                  },
                  textColor: Colors.white,
                  child: Text("Update"),
                ),
                RaisedButton(
                  color: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  onPressed: () {
                    deleteData();
                  },
                  textColor: Colors.white,
                  child: Text("Delete"),
                ),
              ],
            ),
            Expanded(
              child: FutureBuilder(
                  future: readData(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      log(snapshot.data.toString());
                    }

                    return ListView.builder(
                        itemCount: docIDs.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              docIDs[index],
                            ),
                            leading: Text(docIDs[index]),
                          );
                        });
                  }),
            )
          ],
        ),

        // StreamBuilder(
        //   stream: _product.snapshots(),
        //   builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
        //     if (streamSnapshot.hasData) {
        //       return ListView.builder(
        //         itemCount: streamSnapshot.data!.docs.length,
        //         itemBuilder: (context, index) {
        //           final DocumentSnapshot documentSnapshot =
        //               streamSnapshot.data!.docs[index];
        //           return Card(
        //             margin: const EdgeInsets.all(10),
        //             child: ListTile(
        //               title: Text(documentSnapshot['name']),
        //               subtitle: Text(documentSnapshot['price'].toString()),
        //               trailing: SizedBox(
        //                 width: 100,
        //                 child: Row(
        //                   children: [
        //                     IconButton(
        //                         onPressed: () {
        //                           _update(documentSnapshot)
        //                         }, icon: const Icon(Icons.edit))
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           );
        //         },
        //       );
        //     }
        //     return const Text("No data has");
        //   },
        // ),
      ),
    );
  }
}
