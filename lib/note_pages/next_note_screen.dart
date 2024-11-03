import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/controller/notes_controller.dart';
import 'package:note/controller/notes_model.dart';

class NextNoteScreen extends StatefulWidget {
  final NotesModel? note;
  final int? index;
  const NextNoteScreen({super.key, this.note, this.index});

  @override
  State<NextNoteScreen> createState() => _NextNoteScreenState();
}

class _NextNoteScreenState extends State<NextNoteScreen> {
  final controller = Get.put(NotesController());

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      controller.titleController.text = widget.note!.title;
      controller.descriptionController.text = widget.note!.description;
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.titleController.clear();
    controller.descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('${widget.note == null ? 'Create' : 'Update'} Screen'),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: controller.titleController,
                style: const TextStyle(
                    fontSize: 21,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                decoration: const InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 30),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 15, vertical: 15)),
              ),
              const SizedBox(
                height: 50,
              ),
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 70,
                decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black.withOpacity(.5),
                        fontSize: 20),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15)),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
          onPressed: () {
            if (widget.note == null) {
              controller.createdAdd();
            } else {
              controller.updateNote(
                widget.index!,
                NotesModel(
                  title: controller.titleController.text,
                  description: controller.descriptionController.text,
                  createdDate: widget.note!.createdDate,
                  updateDate: DateTime.now(),
                ),
              );
            }
          },
          child: const Icon(Icons.add),
        ));
  }
}
