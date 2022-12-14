import 'package:flutter/material.dart';
import 'package:keeper/Controllers/person_controller.dart';
import 'package:keeper/Model/person.dart';
import 'package:keeper/Pages/AddPage/add_task_page.dart';
import 'package:keeper/Pages/edit_person.dart';
import 'package:get/get.dart';

class ViewPage extends StatefulWidget {
  final Person person;
  final int index;
  final String from;
  const ViewPage(
      {Key? key, required this.person, required this.index, required this.from})
      : super(key: key);

  @override
  State<ViewPage> createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('View Person'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GetBuilder<PersonController>(builder: (controller) {
                return ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(60),
                    child: widget.person.personImage != null
                        ? Image.memory(
                            widget.person.personImage!,
                            fit: BoxFit.cover,
                          )
                        : Image.memory(controller.localImage),
                  ),
                );
              }),
            ),
            Column(
              children: [
                Text(
                  widget.person.personName,
                  style: const TextStyle(fontSize: 40),
                ),
                GetBuilder<PersonController>(
                  builder: (controller) {
                    return Text(widget.person.personAmount.isNegative
                        ? "Balance : ${widget.person.personAmount}"
                        : "Advance : ${widget.person.personAmount}");
                  }
                ),
              ],
            ),
            SizedBox(
              height: 500,
              child: GetBuilder<PersonController>(
              builder:  (controler) {
                  return ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.person.listOfTask.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(widget.person.listOfTask[index].taskName),
                          subtitle:
                              Text('${widget.person.listOfTask[index].taskAmount}'),
                          isThreeLine: true,
                          trailing:
                              Text('${widget.person.listOfTask[index].editedTime}'),
                        );
                      });
                }
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: widget.from == 'EDITED_PAGE'?true:false,
            child: FloatingActionButton(child: const Icon(Icons.add), onPressed: () {
               Route route = MaterialPageRoute(builder: (context) {
                      return const AddTaskPage(
                        buttonName: "All",
                      );
                    });
                    Navigator.push(context, route);
            }),
          ),
          const SizedBox(width: 5),
          FloatingActionButton(
            heroTag: '',
            onPressed: () {
              if (widget.from == 'EDITED_PAGE') {
                Route route = MaterialPageRoute(builder: (context) {
                  return EditPage(
                    person: widget.person,
                    index: widget.index,
                  );
                });
                Navigator.of(context).push(route);
              } else {
                Navigator.of(context).pop();
              }
            },
            child: widget.from == 'EDITED_PAGE'
                ? const Icon(Icons.edit)
                : const Icon(Icons.arrow_back),
          ),
        ],
      ),
    );
  }
}
