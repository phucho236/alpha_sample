import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/services/config_service.dart';
import 'package:alpha_sample/utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseConsumerWidget extends StatefulWidget {
  const BaseConsumerWidget({Key key}) : super(key: key);
}

abstract class BaseConsumerState<W extends BaseConsumerWidget>
    extends State<W> {
  bool isShowRefreshIndicator = false;
  dynamic _param;
  BaseBloc _bloc;

  BaseBloc createBloc();

  StreamSubscription _appSubscription;
  AppBloc appBloc;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  Completer<Null> _completer;
  ConfigService configService = locator<ConfigService>();

  _init() {
    _bloc = createBloc();
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  @override
  void initState() {
    super.initState();
    _init();
    onWidgetDidBuild(() {
      _appSubscription = appBloc?.listen((state) {
        if (state is UpdateConfigState) {
          if (state.config != configService.config)
            setState(() => configService.config = state.config);
        }
      });
    });
  }

  /// abstract methods get cubit
  BaseBloc getBloc() => _bloc;

  /// handle listener bloc {show dialog, show loading}
  void handleListener(context, state) {
    if (state is ErrorState) {
      onLoadComplete();
      showInfoError(context, state.message);
    }
  }

  Widget _refreshIndicator({Widget child}) {
    if (isShowRefreshIndicator)
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        child: child,
        onRefresh: _onRefresh,
      );
    return child;
  }

  Widget _gestureDetector(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }

  Widget blocConsumer(BuildContext context, {dynamic param}) {
    _param = param;
    return _refreshIndicator(
      child: BlocConsumer(
        cubit: _bloc,
        listener: (BuildContext context, state) {
          return handleListener(context, state);
        },
        builder: (BuildContext context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: handleState(context, state),
          );
        },
      ),
    );
  }

  void onInitialState() => _bloc?.add(FetchDataEvent());

  Widget bodyContentView(BuildContext context, BaseState state);

  Widget handleState(BuildContext context, BaseState state) {
    if (state is InitialState) onInitialState();

    if (state is DataLoadedState) {
      onLoadComplete();
      return _gestureDetector(context, bodyContentView(context, state));
    }

    return _gestureDetector(context, bodyContentView(context, state));
  }

  Future<Null> _onRefresh() {
    _completer = Completer<Null>();
    _bloc?.add(FetchDataEvent(param: _param));
    return _completer.future;
  }

  void onLoadComplete() {
    if (_completer?.isCompleted == false) _completer.complete(null);
  }

  void addEvent(BaseEvent event) {
    _bloc?.add(event);
  }

  @override
  void dispose() {
    _appSubscription?.cancel();
    super.dispose();
  }
}
