import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;
import 'package:asuka/asuka.dart' as asuka;

class ListItemConfiguration extends StatelessWidget {
  BuildContext context;
  IconData icon;
  String title;
  String subtitle;
  bool showMarkdown = false;
  Function itemFunction = () {};

  ListItemConfiguration({
    required this.context,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.showMarkdown,
    required this.itemFunction,
  });

  void showMessage(String message) {
    asuka.showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        this.icon,
        color: Colors.white,
      ),
      title: Text(
        this.title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        this.subtitle,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {
        if (showMarkdown) {
          _openMarkdownDocumentation();
        } else {
          itemFunction();
        }
      },
    );
  }

  Future<Null> _openMarkdownDocumentation() async {
    String url = 'https://docs.microsoft.com/pt-br/contribute/how-to-write-use-markdown';
    showMessage('URL não pode ser carregada no momento. Verifique a sua conexão com a internet.');
  }
}
