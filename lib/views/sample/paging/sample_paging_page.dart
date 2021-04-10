import 'package:alpha_sample/base/builder/base.dart';
import 'package:alpha_sample/base/builder/base_bloc.dart';
import 'package:alpha_sample/base/builder/base_event.dart';
import 'package:alpha_sample/base/widget/base_paging.dart';
import 'package:alpha_sample/models/sample/post_model.dart';
import 'package:alpha_sample/my_app/locator.dart';
import 'package:alpha_sample/resources/styles.dart';
import 'package:alpha_sample/services/admod_service.dart';
import 'package:alpha_sample/views/sample/builder/sample_builder_bloc.dart';
import 'package:alpha_sample/views/sample/paging/sample_paging_bloc.dart';
import 'package:alpha_sample/widgets/container/bottom_loader_widget.dart';
import 'package:flutter/material.dart';

class SamplePagingPage extends BasePagingWidget {
  static const String routeName = "/SamplePagingPage";

  @override
  SamplePagingState createState() => SamplePagingState();
}

final _adMobService = locator<AdMobService>();

class SamplePagingState extends BasePagingState<SamplePagingPage>
    with AutomaticKeepAliveClientMixin<SamplePagingPage> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  List<PostModel> employees = [];
  @override
  bool get isShowRefreshIndicator => true;

  @override
  BaseBloc createBloc() => SamplePagingBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return blocBuilder(context);
  }

  @override
  Widget bodyContentView(BuildContext context, state) {
    if (state is DataLoadedState) employees = [];
    if (state.data != null) employees.addAll(state.data as List<PostModel>);

    return bodyContent(employees, state);
  }

  Widget bodyContent(List<PostModel> employees, state) {
    return SingleChildScrollView(
      controller: _scrollController,
      physics: AlwaysScrollableScrollPhysics(),
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: employees.length,
        padding: const EdgeInsets.all(12.0),
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Item(
            index: index,
            postModel: employees[index],
            lengthList: employees.length,
            isListMAx:
                state is LoadMoreSuccessState ? state.hasReachedMax : false,
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(height: 12.0);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      addEvent(LoadMoreEvent());
    }
  }
}

class Item extends StatelessWidget {
  Item({this.postModel, this.index, this.lengthList, this.isListMAx});
  final PostModel postModel;
  final int index;
  final int lengthList;
  final bool isListMAx;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('- userId: ${postModel.userId}'),
                SizedBox(height: 6.0),
                Text('- id: ${postModel.id}',
                    style: Style.normalStFontDarkText),
                SizedBox(height: 6.0),
                Text('- title: ${postModel.title} ',
                    style: Style.normalStFontDarkText),
                Text('- body: ${postModel.body} ',
                    style: Style.normalStFontDarkText),
                index % 5 == 0
                    ? Container(
                        height: 350,
                        child: _adMobService.nativeAdMob(
                          errLoadAds: SizedBox(
                            height: 0,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ),
        isListMAx
            ? Container()
            : index == lengthList - 1
                ? BottomLoader()
                : Container()
      ],
    );
  }
}
