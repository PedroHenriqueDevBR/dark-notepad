import 'package:dolar_agora/models/Note.dart';

class SQLFlite {

  List<Note> notes = [];

  removeNote(int index) {
    this.notes.removeAt(index);
  }

  addNote(String title, String desc) {
    Note note = Note(title, desc);
    this.notes.add(note);
  }

  listInit() {
    for (int i = 0; i < 25; i++) {
      this.notes.add(Note('Nota $i',
          """
          # Markdown Example
Markdown allows you to easily include formatted text, images, and even formatted Dart code in your app.

## Styling
Style text as _italic_, __bold__, or `inline code`.

- Use bulleted lists
- To better clarify
- Your points

## Links
You can use [hyperlinks](hyperlink) in markdown

## Images

You can include images:

![Flutter logo](https://flutter.io/images/flutter-mark-square-100.png#100x100)

## Markdown widget

This is an example of how to create your own Markdown widget:

    new Markdown(data: 'Hello _world_!');

## Code blocks
Formatted Dart code looks really pretty too:

```
void main() {
  runApp(new MaterialApp(
    home: new Scaffold(
      body: new Markdown(data: markdownData)
    )
  ));
}
```

Enjoy!
          """
      ));
    }
  }

}