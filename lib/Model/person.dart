import 'dart:typed_data';


import 'package:hive_flutter/adapters.dart';

import 'task.dart';
part 'person.g.dart';

@HiveType(typeId: 1)
class Person extends HiveObject{
  @HiveField(1)
  Uint8List? personImage;

  @HiveField(2)
  String personName;

  @HiveField(3)
  int personAmount;

  @HiveField(4)
  List<Task> listOfTask;

  @HiveField(5)
  bool isSelected;

  Person({
    required this.personName,
    required this.personAmount,
    this.personImage,
    this.listOfTask = const <Task>[],
    this.isSelected = false,
  });
}
