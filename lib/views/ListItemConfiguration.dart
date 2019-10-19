import 'package:flutter/material.dart';

class ListItemConfiguration extends StatelessWidget {

  IconData _icon;
  String _title;
  String _subtitle;

  ListItemConfiguration(this._icon, this._title, this._subtitle);

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
      onTap: (){},
    );
  }
}
