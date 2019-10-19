class Note {
  String _title;
  String _description;

  Note(this._title, this._description);

  set title(String title) {
    this._title = title;
  }

  get title {
    return this._title;
  }

  set description(String desc) {
    this._description = desc;
  }

  get description {
    return this._description;
  }

}