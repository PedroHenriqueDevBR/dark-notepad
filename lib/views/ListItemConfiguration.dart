import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class ListItemConfiguration extends StatelessWidget {
  BuildContext context;
  IconData _icon;
  String _title;
  String _subtitle;

  ListItemConfiguration(this.context, this._icon, this._title, this._subtitle);

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
      onTap: _openMarkdownDocumentation,
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
              content: Text('URL nao pode ser carregada.')
          )
      );
    }
  }
}
