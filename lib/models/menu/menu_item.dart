import 'package:alpha_sample/base/provider/menu_provider.dart';
import 'package:alpha_sample/models/menu/menu_theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MenuItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final Duration animationDuration;
  final Function onSelect;
  Color selectedBackgroundColor;
  Color selectedForegroundColor;
  Color selectedLabelColor;

  int index;
  int selectedIndex;
  MenuTheme theme;
  double itemWidth;

  void setIndex(int index) {
    this.index = index;
  }

  Color _getDerivedBorderColor() {
    return theme.selectedItemBorderColor ?? theme.barBackgroundColor;
  }

  Color _getBorderColor(bool isOn) {
    return isOn ? _getDerivedBorderColor() : Colors.transparent;
  }

  bool _isItemSelected() {
    return index == (selectedIndex != null ? selectedIndex : index);
  }

  static const kDefaultAnimationDuration = Duration(milliseconds: 1500);

  MenuItem({
    Key key,
    this.label,
    this.itemWidth,
    this.selectedBackgroundColor,
    this.selectedForegroundColor,
    this.selectedLabelColor,
    this.iconData,
    this.onSelect,
    this.animationDuration = kDefaultAnimationDuration,
  }) : super(key: key);

  Center _makeLabel(String label) {
    bool isSelected = _isItemSelected();
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: isSelected
              ? theme.selectedItemTextStyle.fontSize
              : theme.unselectedItemTextStyle.fontSize,
          fontWeight: isSelected
              ? theme.selectedItemTextStyle.fontWeight
              : theme.unselectedItemTextStyle.fontWeight,
          color: isSelected
              ? selectedLabelColor ?? theme.selectedItemLabelColor
              : theme.unselectedItemLabelColor,
          //letterSpacing: isSelected ? 1.0 : 1.0,
        ),
      ),
    );
  }

  // tạo icon selected
  Widget _makeIconArea(double itemWidth, IconData iconData) {
    bool isSelected = _isItemSelected();
    return isSelected
        ? Container(
            height: 65,
            width: 95,
            //alignment: Alignment.center,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                // Image.asset('../../assets/images/profile_icon.png'),
                Center(
                  child: _makeIcon(iconData),
                ),
              ],
            ),
          )
        : Container(
            height: 63,
            width: 95,
            alignment: Alignment.bottomCenter,
            child: _makeIcon(iconData),
          );
  }

  Widget _makeIcon(
    IconData iconData,
  ) {
    bool isSelected = _isItemSelected();
    return Icon(
      iconData,
      size: 30.0,
      color: isSelected
          ? selectedForegroundColor ?? theme.selectedItemIconColor
          : theme.unselectedItemIconColor,
    );
  }

  getTheme(context) async {
    theme = Provider.of<MenuProvider>(context).getmenuTheme;
  }

  @override
  Widget build(BuildContext context) {
    getTheme(context);

    double itemHeight;
    double topOffset;
    double iconTopSpacer;
    double shadowTopSpacer;

    Widget labelWidget;
    Widget iconAreaWidget;

    try {
      itemWidth = theme != null ? theme.itemWidth : 200;
      selectedBackgroundColor = selectedBackgroundColor ??
          (theme != null
              ? theme.selectedItemBackgroundColor
              : Colors.blueAccent);
      selectedForegroundColor = selectedForegroundColor ??
          (theme != null ? theme.selectedItemIconColor : Colors.white);
      selectedLabelColor = selectedLabelColor ??
          (theme != null ? theme.selectedItemLabelColor : Colors.grey);

      bool isSelected = _isItemSelected();
      itemHeight = itemWidth != null ? itemWidth - 20 : 150;
      topOffset = isSelected ? -20 : -10;
      iconTopSpacer = isSelected ? 20 : 20;
      shadowTopSpacer = 20;

      labelWidget = _makeLabel(label);
      iconAreaWidget = _makeIconArea(itemWidth, iconData);
    } catch (e) {
      debugPrint('error : ${e}');
    }

    return AnimatedContainer(
      width: itemWidth,
      height: double.maxFinite,
      duration: animationDuration,
      child: SizedBox(
        width: itemWidth,
        height: itemHeight,
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              // top: 00.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: iconTopSpacer),
                  iconAreaWidget,
                  labelWidget,
                  SizedBox(height: shadowTopSpacer),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
