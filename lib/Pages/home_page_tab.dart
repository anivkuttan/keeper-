import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:keeper/Controllers/person_controller.dart';
import 'package:keeper/Model/person.dart';
import 'package:keeper/Pages/person_view_page.dart';

class HomePageTabView extends StatelessWidget {
  HomePageTabView({Key? key}) : super(key: key);

  final PersonController controller = Get.put(PersonController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      // color: Colors.pink,
      alignment: Alignment.center,
      child: GetBuilder<PersonController>(
        builder: (controller) {
          return ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: ((context, index) {
              log("personBoxCount ${controller.personBoxCount}");

              return PersonCard(index: index);
            }),
            itemCount: controller.personBoxCount,
            separatorBuilder: (context, index) {
              return const Divider(height: 20);
            },
          );
        },
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final int index;
  final PersonController controller = Get.find<PersonController>();

  final SizedBox space5 = const SizedBox(height: 5);
  PersonCard({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Person? person = controller.personBox.getAt(index);
    // Person? person = controller.observableBox.getAt(index);
    return GestureDetector(
      onTap: (() {
        Route route = MaterialPageRoute(builder: (context) {
          return ViewPage(
            person: person!,
          );
        });

        Navigator.push(context, route);
      }),
      onLongPress: (() {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: SizedBox(
                    height: 100,
                    width: 400,
                    child: Column(
                      children: [
                        Text('Do You Want to delete ${person!.personName} ?'),
                        Row(
                          children: [
                            const Spacer(),
                            TextButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                if (controller.personBoxCount == 1) {
                                  controller.deleteAllPerson();
                                } else {
                                  controller.deletePerson(index: index);
                                }
                                log('person button deleted pressed');
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                              child: const Text(
                                'No',
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        )
                      ],
                    )),
              );
            });
      }),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person!.personName,
                    style: const TextStyle(fontSize: 25),
                  ),
                  space5,
                  Text(
                    'Amount :${person.personAmount}',
                    style: const TextStyle(fontSize: 20),
                  ),
                  space5,
                  Text("last Added Task : ${person.listOfTask.last.taskName}"),
                  space5,
                  Text("EditedTime : ${person.listOfTask.last.editedTime}"),
                  space5,
                 
                  space5,
                ],
              ),
              const Spacer(),
              Hero(
                tag: "Image",
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(40),
                    child: person.personImage != null
                        ? Image.memory(
                            person.personImage!,
                            fit: BoxFit.cover,
                          )
                        : CircleAvatar(
                            child: Text(
                              person.personName[0].toUpperCase(),
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
