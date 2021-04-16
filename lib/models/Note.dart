class Note {
  int? id;
  late String _title;
  late String _description;

  Note(String title, String description, {this.id}) {
    this._title = title != null ? title : '';
    this._description = description != null ? description : '';
  }

  set title(String title) {
    this._title = title;
  }

  String get title {
    return this._title;
  }

  void set description(String desc) {
    this._description = desc;
  }

  String get description {
    return this._description;
  }
}
