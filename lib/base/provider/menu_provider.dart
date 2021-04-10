import 'package:alpha_sample/models/menu/menu_item.dart';
import 'package:alpha_sample/models/menu/menu_theme.dart';
import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  MenuTheme _menuTheme = new MenuTheme();
  MenuItem _menuItem;

  List<MenuItem> _listMenu;

  // get
  get getlistMenu => _listMenu;
  get getmenuTheme => _menuTheme;
  get getmenuItem => _menuItem;

  // set
  setMenuTheme({@required MenuTheme newValue}) {
    _menuTheme = newValue;
    notifyListeners();
  }

  setMenuItems({@required MenuItem newValue}) {
    _menuItem = newValue;
    notifyListeners();
  }

  setListMenu({@required List<MenuItem> newValue}) {
    _listMenu = newValue;
    notifyListeners();
  }
}
