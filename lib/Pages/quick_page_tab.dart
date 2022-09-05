import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeper/Controllers/person_controller.dart';
import 'package:keeper/Pages/add_new_person.dart';
import 'package:keeper/Pages/add_task_page.dart';
import 'package:keeper/Pages/view_notes.dart';

class QuickPageTabView extends StatelessWidget {
  QuickPageTabView({Key? key}) : super(key: key);
  final controller = Get.find<PersonController>();

  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) {
                      return ViewNotes();
                    });
                    Navigator.of(context).push(route);
                  },
                  child: const Text('View All Notes'),
                ),
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) {
                      return const AddTaskPage(
                        buttonName: "All",
                      );
                    });
                    Navigator.push(context, route);
                  },
                  child: const Text('Add Task'),
                ),
              ),
              SizedBox(
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    Route route = MaterialPageRoute(builder: (context) {
                      return const AddNewPerson();
                    });
                    Navigator.push(context, route);
                  },
                  child: const Text('Add New Person'),
                ),
              ),
            ]),
      ),
    );
  }

  // showAddingPage(BuildContext context) {

  //   return showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true, // to keyboard shows up text field to get up along with
  //       shape: const RoundedRectangleBorder(
  //         borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
  //       ),
  //       builder: (context) {
  //         return Container(
  //           decoration: const BoxDecoration(
  //             // color: Colors.yellow,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(20),
  //               topRight: Radius.circular(20),
  //             ),
  //           ),
  //           child: Form(
  //             key: formKey,
  //             child: SingleChildScrollView(
  //               physics: const BouncingScrollPhysics(),
  //               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
  //               child: Padding(
  //                 // this padding for bottom Insets
  //                 // to get  to keyboard shows up text field to get up along with
  //                 padding: EdgeInsets.only(
  //                   bottom: MediaQuery.of(context).viewInsets.bottom,
  //                 ),
  //                 child: Column(mainAxisSize: MainAxisSize.min, children: [

  //                   const SizedBox(height: 30),
  //                   TextFormField(
  //                     controller: _nameController,
  //                     validator: (currentText) {
  //                       if (currentText == null || currentText.isEmpty) {
  //                         return "Please Enter Name";
  //                       }
  //                       return null;
  //                     },
  //                     decoration: InputDecoration(
  //                       label: const Text("Name"),
  //                       border: OutlineInputBorder(
  //                         borderRadius: BorderRadius.circular(23),
  //                       ),
  //                     ),
  //                   ),
  //                   const SizedBox(height: 30),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       // final editedTime = DateTime.now();
  //                       // // bool isImageNull = imageController.imageFile == null;
  //                       // // // var assetImage = const AssetImage('assets/party.jpg');
  //                       // // var pickedImage = FileImage(imageController.imageFile!);
  //                       // String editedTime1 =
  //                       //     "${editedTime.day}/${editedTime.month}/${editedTime.year} Time : ${editedTime.hour}:${editedTime.minute}";
  //                       //      Person newPereon = Person(
  //                       //     personName: _nameController.text,
  //                       //     personAmount: 0,
  //                       //     listOfTask: [
  //                       //       Task(taskName: "Just Created", taskAmount: 0, editedTime: editedTime1),
  //                       //     ],
  //                       //     // personimage:  pickedImage ,
  //                       //   );
  //                       //   controller.personList.add(newPereon);

  //                       //   Navigator.pop(context);
  //                       // // if (formKey.currentState!.validate()) {

  //                       // }
  //                     },
  //                     child: const Text("Add New Person"),
  //                   ),
  //                 ]),
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }
}
