import 'package:asuka/asuka.dart' as asuka;
import 'package:dark_notepad/src/core/dal/SQFLite.dart';
import 'package:dark_notepad/src/core/models/Note.dart';
import 'package:dark_notepad/src/pages/create_note/create_note_page.dart';
import 'package:dark_notepad/src/pages/show_note/show_note_page.dart';
import 'package:flutter/material.dart';
import 'package:rx_notifier/rx_notifier.dart';
import 'package:share/share.dart';

class HomeController {
  RxList<Note> notes = RxList<Note>([]);
  RxNotifier<bool> orderDesc = RxNotifier<bool>(false);
  RxNotifier<IconData> iconOrder = RxNotifier<IconData>(Icons.arrow_downward);

  void showMessage(String message) {
    asuka.showSnackBar(SnackBar(content: Text(message)));
  }

  void orderList() {
    orderDesc.value = !orderDesc.value;
    getNotesFromDatabase();
    iconOrder.value = orderDesc.value ? Icons.arrow_upward : Icons.arrow_downward;
  }

  void createNote({required BuildContext context}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CreateNoteActivity()),
    ).then((value) {
      getNotesFromDatabase();
    });
  }

  void showNote({required BuildContext context, required int id}) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ShowNoteActivity(id)));
  }

  void editNote({required BuildContext context, required int id}) async {
    await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CreateNoteActivity(
        id: id,
      );
    })).then((value) {
      getNotesFromDatabase();
    });
  }

  void getNotesFromDatabase() async {
    SQLFlite sqlFlite = SQLFlite();
    List<Note> response = await sqlFlite.getAllNotes(orderDefault: orderDesc.value);
    notes.clear();
    notes.addAll(response);
  }

  void deleteNote({required int id}) async {
    print('ponto de parada');
    SQLFlite sqlFlite = SQLFlite();
    await sqlFlite.deleteNoteOfID(id);
    notes.removeWhere((note) => note.id == id);
    showMessage('Nota deletada');
  }

  void shareApp() {
    Share.share('Markdown editor, editor de markdown simples de utilizar, sem anúncios. '
        'Baixe agora mesmo em https://play.google.com/store/apps/details?id=com.pedrohenriquedevbr.dolar_agora');
  }
}
