import 'package:flutter/material.dart';
import 'package:sqlite_curd/models/note_model.dart';
import 'package:sqlite_curd/services/database_helper.dart';

class NoteScreen extends StatelessWidget {
  final Note? note;

  const NoteScreen({Key? key, this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    if (note != null) {
      titleController.text = note!.title!;
      titleController.text = note!.title!;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add note"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Center(
                child: Text(
                  "What are You Thinkn about ?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.0),
              child: TextField(
                maxLength: 10,
                controller: titleController,
                decoration: InputDecoration(
                    hintText: "Titile",
                    labelText: "Note Titile",
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 0.75),
                    borderRadius: BorderRadius.all(Radius.circular(20)))),
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Type Here the note',
                labelText: 'note description',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                    width: 0.75,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),

                )
              ),
              keyboardType: TextInputType.multiline,
              onChanged: (str){},
              maxLines: 6,
            ),Spacer(),
            Padding(padding: EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
              onPressed: ()async{
                final title=titleController.value.text;
                final description=descriptionController.value.text;

                if(title.isEmpty || description.isEmpty){
                  return;
                }
                final Note model=Note(title: title,description: description,id: note?.id);
                if(note==null){
                  await DatabaseHelper.addNote(model);
                }else{
                  await DatabaseHelper.updateNote(model);
                }
                Navigator.pop(context);
              },
              child: Text(note== null ? "Save":"Edit",style: TextStyle(fontSize: 20),),
            ),)

          ],
        ),
      ),
    );
  }
}
