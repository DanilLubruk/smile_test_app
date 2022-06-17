import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smile_test_app/bloc/news_item_cubit.dart';
import 'package:smile_test_app/bloc/news_list_bloc.dart';
import 'package:smile_test_app/bloc/news_list_cubit.dart';
import 'package:smile_test_app/bloc/paginator_cubit.dart';
import 'package:smile_test_app/ui/news_list_item.dart';
import 'package:smile_test_app/ui/ui_consts.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final NewsListCubit newsListCubit = NewsListCubit();
  final PaginatorCubit paginatorCubit = PaginatorCubit();
  final NewsListBloc newsListBloc = NewsListBloc();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await newsListCubit.loadData();
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          appBar: AppBar(
            title: Text("News",
                style: GoogleFonts.lora(
                    fontSize: UiConsts.headerTextSize, fontWeight: FontWeight.bold)),
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            centerTitle: true,
          ),
          backgroundColor: Theme.of(context).backgroundColor,
          body: Padding(
              padding: const EdgeInsets.all(UiConsts.screenPadding),
              child: dataLoader(context))));

  Widget dataLoader(BuildContext context) => BlocProvider<NewsListCubit>(
      create: (context) => newsListCubit,
      child: BlocConsumer<NewsListCubit, DataState>(
        builder: (context, dataState) {
          if (dataState is DataLoaded) {
            return listLoader(context);
          } else {
            return SizedBox();
          }
        },
        listener: (context, dataState) =>
            newsListBloc.add(NextPagePressed(dataState.news, 0)),
      ));

  Widget listLoader(BuildContext context) => BlocProvider<PaginatorCubit>(
      create: (context) => paginatorCubit,
      child: BlocConsumer<PaginatorCubit, int>(
        builder: (context, pageNumber) => BlocProvider<NewsListBloc>(
          create: (context) => newsListBloc,
          child: listView(context),
        ),
        listener: (context, pageNumber) {},
      ));

  Widget listView(BuildContext context) =>
      BlocConsumer<NewsListBloc, NewsListState>(
          builder: (context, listState) => ListView.builder(
                itemCount: listState.pagedViews.length,
                itemBuilder: (context, index) => BlocProvider<NewsItemCubit>(
                    create: (context) =>
                        NewsItemCubit(listState.pagedViews[index]),
                    child: const Padding(
                        padding:
                            EdgeInsets.only(bottom: UiConsts.screenPadding),
                        child: NewsListItem())),
              ),
          listener: (context, listState) {});
}
