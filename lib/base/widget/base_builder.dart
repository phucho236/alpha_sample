import 'dart:async';

import 'package:alpha_sample/base/builder/app_event.dart';
import 'package:alpha_sample/base/builder/app_state.dart';
import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/strings.dart';
import 'package:alpha_sample/services/config_service.dart';
import 'package:alpha_sample/utils/common_utils.dart';
import 'package:alpha_sample/widgets/container/error_widget.dart';
import 'package:alpha_sample/widgets/container/progress_indicators_widget.dart';
import 'package:alpha_sample/widgets/dialog/common_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BaseBuilderWidget extends StatefulWidget {
  const BaseBuilderWidget({Key key}) : super(key: key);
}

abstract class BaseBuilderState<W extends BaseBuilderWidget> extends State<W> {
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

  @override
  void initState() {
    super.initState();
    _init();
    onWidgetDidBuild(() {
      _appSubscription = appBloc?.listen((state) {
        if (state is UpdateConfigState) {
          if (state.config != configService.config)
            setState(() => configService.config = state.config);
        } else if (state is ShowLoadingState) {
          showWaitingDialog(state.context);
        } else if (state is DismissLoadingState) {
          dismissDialog(state.context);
        }
      });
    });
  }

  _init() {
    _bloc = createBloc();
    appBloc = BlocProvider.of<AppBloc>(context);
  }

  showDialog(BuildContext context) async {
    showWaitingDialog(context);
  }

  dismissDialog(BuildContext context) {
    if (context != null) {
      try {
        Navigator.pop(context);
      } catch (e) {
        print("${e.runtimeType} - ${e.toString()}");
      }
    }
  }

  /// abstract methods
  BaseBloc getBloc() => _bloc;

  Widget _refreshIndicator({Widget child}) {
    if (isShowRefreshIndicator)
      return RefreshIndicator(
        key: _refreshIndicatorKey,
        child: child,
        onRefresh: _onRefresh,
      );
    return child;
  }

  Widget blocBuilder(BuildContext context, {dynamic param}) {
    _param = param;
    return _refreshIndicator(
      child: BlocBuilder<BaseBloc, BaseState>(
        cubit: _bloc,
        builder: (context, state) {
          return AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: handleState(context, state),
          );
        },
      ),
    );
  }

  void onLoadComplete() {
    if (_completer?.isCompleted == false) _completer.complete(null);
  }

  void onInitialState() => _bloc?.add(FetchDataEvent());

  /// reload error
  void onReload() => _bloc?.add(FetchDataEvent());

  Widget bodyContentView(BuildContext context, dynamic data);

  Widget emptyView(BuildContext context) {
    return Center(
      child: Text(emptyLabel(context)),
    );
  }

  Widget handleState(BuildContext context, BaseState state) {
    if (state is ErrorState) {
      onLoadComplete();
      return errorView(context, state, onReload);
    }

    if (state is InitialState) onInitialState();

    if (state is DataLoadedState) {
      onLoadComplete();
      // check if data object null
      if (state.data == null) return emptyView(context);
      // check if data list null
      if (state.data is List && state.data?.length == 0)
        return emptyView(context);

      return bodyContentView(context, state.data);
    }

    return ProgressIndicators();
  }

  void addAppEvent(AppEvent event) => appBloc?.add(event);

  void addEvent(BaseEvent event) => _bloc?.add(event);

  Future<Null> _onRefresh() {
    _completer = Completer<Null>();
    _bloc?.add(FetchDataEvent(param: _param));
    return _completer.future;
  }

  @override
  void dispose() {
    _appSubscription?.cancel();
    super.dispose();
  }
}
