import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ListItemConfiguration extends StatelessWidget {
  BuildContext context;
  IconData _icon;
  String _title;
  String _subtitle;
  bool _showMarkdown = false;
  Function itemFunction;

  ListItemConfiguration(this.context, this._icon, this._title, this._subtitle, this._showMarkdown, {this.itemFunction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        this._icon,
        color: Colors.white,
      ),
      title: Text(
        this._title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        this._subtitle,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onTap: () {
        if (_showMarkdown) {
          _openMarkdownDocumentation();
        } else {
          itemFunction();
        }
      },
    );
  }

  Future<Null> _openMarkdownDocumentation() async {
    String url = 'https://docs.microsoft.com/pt-br/contribute/how-to-write-use-markdown';
    if (await url_launcher.canLaunch(url)) {
      Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => WebviewScaffold(
                url: url,
                initialChild: Center(child: CircularProgressIndicator(),),
                appBar: AppBar(title: Text(url),),
              )
          )
      );
    } else {
      Scaffold.of(context).showSnackBar(
          SnackBar(
              content: Text('URL não pode ser carregada no momento. Verifique a sua conexão com a internet.')
          )
      );
    }
  }
}
