import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/controller/notes_controller.dart';
import 'package:note/note_pages/custom_note.dart';
import 'package:note/note_pages/next_note_screen.dart';

class NoteScreen extends StatelessWidget {
  const NoteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(NotesController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(onPressed: (){
          }, icon:Icon(Icons.settings))
        ],
        title: const Text('Note App',style: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.bold
        ),),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child:  controller.notes.isEmpty? const Center(child: Text('No Notes Now')):
        Obx(()=>ListView.builder(
          itemCount: controller.notes.length,
          itemBuilder: (context, index) {
            return  CustomNote( index: index,);
          },)),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        onPressed: (){
          Get.to(()=> NextNoteScreen());
        },child: const Icon(Icons.add),),
    );
  }
}
