import 'package:alpha_sample/models/menu/menu_item.dart';
import 'package:alpha_sample/models/menu/menu_theme.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatefulWidget {
  final Function onSelectItem;
  final MenuTheme theme;
  final List<MenuItem> listMenuItem;
  final int selectedIndex;

  const MenuScreen(
      {Key key,
      this.onSelectItem,
      this.theme,
      this.selectedIndex,
      this.listMenuItem})
      : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<MenuItem> listMenuItem;

  @override
  void initState() {
    super.initState();
    listMenuItem = widget.listMenuItem;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [AppColors.dark_text, AppColors.dark_text],
          ),
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: ListView(
                children: listMenuItem != null
                    ? listMenuItem.map((item) {
                        var index = listMenuItem.indexOf(item);
                        item.setIndex(index);
                        return GestureDetector(
                          onTap: () => item.onSelect(),
                          child: Container(
                            color: Colors.transparent,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width /
                                  listMenuItem.length,
                              height: 50,
                              child: item,
                            ),
                          ),
                        );
                      }).toList()
                    : [],
              ),
            ),
            FlatButton(
              onPressed: () {
                /// Logout
              },
              child: Text('Logout',
                  style: Style.largeStFontWhite
                      .copyWith(fontWeight: typeExtraBold)),
            ),
          ],
        ),
      ),
    );
  }
}
