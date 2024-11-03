import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note/note_pages/next_note_screen.dart';
import '../controller/notes_controller.dart';


class CustomNote extends StatelessWidget {
  final int index;
  const CustomNote({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(NotesController());
    final document=controller.notes[index];
    return InkWell(
      onTap: () {
      Get.to(()=>NextNoteScreen(note: document,index: index,));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: Column(
          children: [
            ListTile(
              title:Text(document.title,style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 25
              ),),
              subtitle: Text(document.description,
                maxLines: 2,overflow: TextOverflow.ellipsis,style: TextStyle(
                    color: Colors.black.withOpacity(.7)
                ),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Created Date:${document.createdDate.day}/${document.createdDate.month}/${document.createdDate.year}',style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                  if(document.updateDate!=null)const Text('Updated Date:01/12/24',style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                  ),),
                  InkWell(
                      onTap: () {
                        controller.deletedAll(index);
                      },
                      child: const Icon(Icons.delete))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
