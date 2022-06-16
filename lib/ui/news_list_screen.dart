import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smile_test_app/bloc/news_list_bloc.dart';
import 'package:smile_test_app/bloc/news_list_cubit.dart';
import 'package:smile_test_app/bloc/paginator_cubit.dart';

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
  }

  @override
  Widget build(BuildContext context) => WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
          appBar: AppBar(title: Text("News")),
          backgroundColor: Theme.of(context).backgroundColor,
          body: dataLoader(context)));

  Widget dataLoader(BuildContext context) => BlocProvider<NewsListCubit>(
      create: (context) => newsListCubit,
      child: BlocConsumer<NewsListCubit, DataState>(
        builder: (context, dataState) {
          if (dataState is DataLoaded) {
            return listLoader(context);
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              await newsListCubit.loadData();
            });
            return SizedBox();
          }
        },
        listener: (context, dataState) => newsListBloc.add(NextPagePressed(dataState.news, 0)),
      ));

  Widget listLoader(BuildContext context) => BlocProvider<PaginatorCubit>(
      create: (context) => paginatorCubit,
      child: BlocConsumer<PaginatorCubit, int>(
        builder: (context, pageNumber) =>
            BlocConsumer<NewsListCubit, DataState>(
                builder: (context, dataState) => BlocProvider<NewsListBloc>(
                      create: (context) => newsListBloc,
                      child: listView(context),
                    ),
                listener: (context, dataState) => newsListBloc
                    .add(NextPagePressed(dataState.news, pageNumber))),
        listener: (context, pageNumber) {},
      ));

  Widget listView(BuildContext context) =>
      BlocConsumer<NewsListBloc, NewsListState>(
          builder: (context, listState) => ListView.builder(
                itemCount: listState.pagedViews.length,
                itemBuilder: (context, index) =>
                    Text(listState.pagedViews[index].title),
              ),
          listener: (context, listState) {});
}
