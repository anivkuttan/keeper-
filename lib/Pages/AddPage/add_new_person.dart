import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keeper/Controllers/person_controller.dart';
import 'package:keeper/Model/person.dart';
import 'package:keeper/Model/task.dart';
import 'package:keeper/Widgets/alert_dialog.dart';
import 'package:keeper/Widgets/circle_avatar.dart';

class AddNewPerson extends StatefulWidget {
  const AddNewPerson({Key? key}) : super(key: key);

  @override
  State<AddNewPerson> createState() => _AddNewPersonState();
}

class _AddNewPersonState extends State<AddNewPerson> {
  late final Box<Person> dbPerson;

  final personController = Get.find<PersonController>();
  final TextEditingController _nameController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    dbPerson = Hive.box("Person");
    personController.selectedImage = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add New Person'),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GetBuilder<PersonController>(builder: (controller) {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return DialogBox(
                                title: "Choose Image From",
                                firstButtonName: 'Camera',
                                firstButtonColor:
                                    Theme.of(context).primaryColor,
                                firstButtonTaped: () {
                                  controller.pickImage(ImageSource.camera);
                                  Navigator.pop(context);
                                },
                                secondButtonName: 'Gallery',
                                secondButtonColor:
                                    Theme.of(context).primaryColor,
                                secondButtonTaped: () {
                                  controller.pickImage(ImageSource.gallery);
                                  Navigator.pop(context);
                                },
                              );
                            });
                      },
                      child: CircleImage(
                        circleRadius: 82,
                        child: controller.selectedImage == null
                            ? const CircleAvatar(
                                backgroundImage: AssetImage('assets/1.png'),
                              )
                            : Image.file(
                                controller.selectedImage!,
                                fit: BoxFit.cover,
                              ),
                      ),
                    );
                  }),
                  const SizedBox(height: 30),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(23),
                      ),
                    ),
                    validator: (currentText) {
                      if (currentText == null || currentText.isEmpty) {
                        return "Please Enter Name";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      bool isValidated = formKey.currentState!.validate();
                      if (isValidated) {
                        final editedTime = DateTime.now();
                        // var file = File('assets/defauitImage.png');
                        String editedTime1 =
                            "${editedTime.day}/${editedTime.month}/${editedTime.year} Time : ${editedTime.hour}:${editedTime.minute}";

                        Person newPerson = Person(
                            personName: _nameController.text,
                            personAmount: 0,
                            listOfTask: [
                              Task(
                                  taskName: "Just Created",
                                  taskAmount: 0,
                                  editedTime: editedTime1),
                            ],
                            personImage: personController.selectedImage == null
                                ? personController.localImage
                                : personController.imageAsByts);

                        personController.createPerson(person: newPerson);

                        Navigator.pop(context);
                      }
                    },
                    child: const Text('Add Person '),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
