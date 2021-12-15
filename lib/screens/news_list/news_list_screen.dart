import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/screens/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/utils/constraints.dart';

class NewsListScreen extends StatelessWidget {
  NewsListScreen({Key? key}) : super(key: key);

  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    _scrollController.addListener(() => _scrollListener(context));
    return Scaffold(
      body: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListLoading) {
            return _buildLoadingStateWidgets();
          } else if (state is NewsListLoaded) {
            return _buildNewsLoadedStateWidgets(context, state);
          } else if (state is NewsListError) {
            return _buildErrorStateWidgets(context, state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildListViewWithRerfreshIndicator(
    BuildContext context, {
    required List<Widget> children,
  }) =>
      RefreshIndicator(
        onRefresh: () async =>
            context.read<NewsListBloc>().add(UpdateRequested()),
        child: ListView(
          padding: const EdgeInsets.only(
            left: horizontalPadding,
            right: horizontalPadding,
            top: 30.0,
          ),
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          children: children,
        ),
      );

  Widget _buildLoadingStateWidgets() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildNewsLoadedStateWidgets(
          BuildContext context, NewsListLoaded state) =>
      _buildListViewWithRerfreshIndicator(context, children: [
        ...state.news
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: _buildNewsCard(e),
                ))
            .toList(),
        if (state.isNextLoading)
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: verticalPadding,
            ),
            child: _buildLoadingStateWidgets(),
          )
      ]);

  Card _buildNewsCard(News e) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        child: Row(
          children: [
            SizedBox(
              width: imageSize,
              height: imageSize,
              child: e.image.url != null
                  ? Image.network(
                      e.image.url!,
                      height: imageSize,
                      width: imageSize,
                    )
                  : null,
            ),
            const SizedBox(
              width: horizontalPadding,
            ),
            Expanded(
                child: Column(
              children: [
                Text(
                  e.name,
                ),
                if (e.description != null)
                  Text(
                    e.description!,
                  ),
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _buildErrorStateWidgets(BuildContext context, NewsListError state) =>
      _buildListViewWithRerfreshIndicator(context, children: [
        Center(
            child: Text(
          state.error,
          textAlign: TextAlign.center,
        )),
      ]);

  _scrollListener(BuildContext context) {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      context.read<NewsListBloc>().add(LoadNextRequested());
    }
  }
}
