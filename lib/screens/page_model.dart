import 'package:flutter/material.dart';

class PageModel {
  String _title;
  String _description;
  IconData _icon;

  PageModel(this._title, this._description, this._icon);

  String get description => _description;

  String get title => _title;

  IconData get icon => _icon;
}
