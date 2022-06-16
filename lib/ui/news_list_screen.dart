import 'package:flutter/cupertino.dart';
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
    newsListCubit.loadData();
  }

  @override
  Widget build(BuildContext context) => dataLoader(context);

  Widget dataLoader(BuildContext context) =>
      BlocBuilder<NewsListCubit, DataState>(
          bloc: newsListCubit,
          builder: (context, dataState) {
            if (dataState is DataLoaded) {
              return listLoader(context);
            } else {
              return SizedBox();
            }
          });

  Widget listLoader(BuildContext context) => BlocConsumer<PaginatorCubit, int>(
      builder: (context, pageNumber) => BlocConsumer<NewsListCubit, DataState>(
          builder: (context, dataState) => BlocBuilder<PaginatorCubit, int>(
                bloc: paginatorCubit,
                builder: (context, dataState) =>
                    BlocBuilder<NewsListBloc, NewsListState>(
                  bloc: newsListBloc,
                  builder: (context, listState) => listView(context),
                ),
              ),
          listener: (context, dataState) =>
              newsListBloc.add(NextPagePressed(dataState.news, pageNumber))),
      listener: (context, pageNumber) {});

  Widget listView(BuildContext context) =>
      BlocConsumer<NewsListBloc, NewsListState>(
          builder: (context, listState) => ListView.builder(
                itemCount: listState.pagedViews.length,
                itemBuilder: (context, index) =>
                    Text(listState.pagedViews[index].title),
              ),
          listener: (context, listState) {});
}
