import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/provider/app_theme_store.dart';
import 'package:alpha_sample/base/provider/language_store.dart';
import 'package:alpha_sample/base/provider/menu_provider.dart';
import 'package:alpha_sample/base/widget/base_builder.dart';
import 'package:alpha_sample/models/menu/menu_item.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/services/admod_service.dart';
import 'package:alpha_sample/views/Q&A/helpPage.dart';
import 'package:alpha_sample/views/download/downloadPage.dart';
import 'package:alpha_sample/views/home/home_bloc.dart';
import 'package:alpha_sample/views/login/login_page.dart';
import 'package:alpha_sample/views/map/googleMap.dart';
import 'package:alpha_sample/views/profile/profile_page.dart';
import 'package:alpha_sample/views/sample/builder/sample_builder_page.dart';
import 'package:alpha_sample/views/sample/consumer/sample_consumer_page.dart';
import 'package:alpha_sample/views/sample/paging/sample_paging_page.dart';
import 'package:alpha_sample/widgets/container/app_bar_widget.dart';
import 'package:alpha_sample/widgets/container/main_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends BaseBuilderWidget {
  static const String routeName = "/HomePage";

  final dynamic profileModel;

  HomePage({this.profileModel});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends BaseBuilderState<HomePage>
    with AutomaticKeepAliveClientMixin<HomePage>, AfterLayoutMixin {
  LanguageStore languageStore;
  AppThemeStore appThemeStore;
  final _adMobService = locator<AdMobService>();

  dynamic get _profileModel => widget.profileModel;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [];
  List<Widget> _actions = [];

  List<MenuItem> listItem;
  bool isMenuRight = false;

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  void initState() {
    super.initState();
    _adMobService.loadRewardedVideo();
    _widgetOptions = [
      SampleBuilderPage(),
      SampleConsumerPage(),
      SamplePagingPage(),
      ProfilePage(profileModel: _profileModel),
    ];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    languageStore = Provider.of<LanguageStore>(context);
    appThemeStore = Provider.of<AppThemeStore>(context);
    setItemMenu(context);
    if (_actions.length < 2) {
      if (configService.multiLanguage.enableFeature)
        _actions.add(ActionChangeLanguage(languageStore));
      if (configService.darkMode.enableFeature)
        _actions.add(ActionChangeTheme(appThemeStore));
    }
  }

  @override
  Future<void> afterFirstLayout(BuildContext context) async {
    if (configService.ads.enableFeature) {
      await Future.delayed(const Duration(seconds: 15), () {
        _adMobService?.showRewardedVideo();
      });
    }
  }

  @override
  BaseBloc createBloc() => HomeBloc();

  setItemMenu(BuildContext context) {
    isMenuRight = false;
    listItem = new List<MenuItem>();
    listItem.add(new MenuItem(
      label: 'Main',
      iconData: Icons.home,
      onSelect: () => Navigator.pushNamed(context, LoginPage.routeName),
    ));
    listItem.add(new MenuItem(
      label: 'Setting',
      iconData: Icons.settings,
    ));
    listItem.add(new MenuItem(
      label: 'Q&A',
      iconData: Icons.question_answer,
      onSelect: () => Navigator.pushNamed(context, HelpPage.routeName),
    ));
    listItem.add(new MenuItem(
      label: 'Google Map',
      iconData: Icons.map,
      onSelect: () => Navigator.pushNamed(context, MapPage.routeName),
    ));
    listItem.add(new MenuItem(
      label: 'Download',
      iconData: Icons.file_download,
      onSelect: () => Navigator.pushNamed(context, DownloadPage.routeName),
    ));
    Provider.of<MenuProvider>(context).setListMenu(newValue: listItem);
    listItem = Provider.of<MenuProvider>(context).getlistMenu;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: ASAppBar(
        showBack: false,
        actions: _actions,
        title: homeLabel(context),
      ),
      drawer: MenuScreen(listMenuItem: listItem),
      endDrawer: MenuScreen(listMenuItem: listItem),
      body: blocBuilder(context),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            label: 'Builder',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            label: 'Consumer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assistant),
            label: 'Paging',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'User',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        onTap: _onItemTapped,
      ),
    );
  }

  @override
  Widget bodyContentView(BuildContext context, data) {
    return _widgetOptions.elementAt(_selectedIndex);
  }

  @override
  bool get wantKeepAlive => true;
}
