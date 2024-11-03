import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note/controller/notes_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotesController extends GetxController {
  RxList<NotesModel> notes = <NotesModel>[].obs;

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  createdAdd() {
    if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
      Get.snackbar(
        'ERROR',
        'This is all Required',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }
    notes.add(NotesModel(
        title: titleController.text,
        description: descriptionController.text,
        createdDate: DateTime.now()));
    // storeData();
    update();

    titleController.clear();
    descriptionController.clear();
    Get.back();
  }

  updateNote(int index, NotesModel note) {
    notes[index] = note;
    // storeData();
    update();

    titleController.clear();
    descriptionController.clear();
    Get.back();
  }

  deletedAll(int index) {
    notes.removeAt(index);
    Get.snackbar(
      'Deleted',
      'This has been deleted',
      snackPosition: SnackPosition.BOTTOM,
    );
    // storeData();
  }

  storeData() async {
    var prefs = await SharedPreferences.getInstance();

    var notesListMap = notes.map(
      (element) {
        return {
          'title': element.title,
          'description': element.description,
          'created_at': element.createdDate.toString(),
          'updated_at': element.updateDate.toString()
        };
      },
    ).toList();

    var notesListString = jsonEncode(notesListMap);
    prefs.setString('Data', notesListString);
  }

  loadData() async {
    var prefs = await SharedPreferences.getInstance();

    var notesString = prefs.getString('Data');
    var notesMap = jsonDecode(notesString!) as List;

    var notesModel = notesMap.map(
      (element) {
        return NotesModel(
          title: element['title'],
          description: element['description'],
          createdDate: DateTime.parse(element['created_at']),
          updateDate: element['updated_at']=='null'?null:DateTime.parse(element['updated_at'])
        );
      },
    ).toList();
    notes.addAll(notesModel);
    update();
  }
  @override
  void onInit() {
  loadData();
    super.onInit();
  }
}

// storeData() async {
//   var prefs = await SharedPreferences.getInstance();
//
//   var notesListMap = notes.map(
//     (element) {
//       return {
//         'title': element.title,
//         'description': element.description,
//         'created_at': element.createdDate.toString(),
//         'updated_at': element.updateDate.toString()
//       };
//     },
//   ).toList();
//
//   var noteListString = jsonEncode(notesListMap);
//
//   prefs.setString('Data', noteListString);
// }
//
//
//
// loadStore() async {
//   var prefs = await SharedPreferences.getInstance();
//
//   var notesString = prefs.getString('Data');
//   if (notesString != null) {
//     var notesMap = jsonDecode(notesString) as List;
//     var notesModel = notesMap.map(
//           (element) {
//         return NotesModel(
//           title: element['title'],
//           description: element['description'],
//           createdDate: DateTime.parse(element['created_at']),
//           updateDate: element['updated_at']=='null'? null:DateTime.parse(element['updated_at']),
//         );
//       },
//     ).toList();
//     notes.addAll(notesModel);
//     update();
//   }
// }
//
// @override
// void onInit() {
//   super.onInit();
//   loadStore();
// }
