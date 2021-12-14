import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/screens/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/utils/constraints.dart';

class NewsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<NewsListBloc, NewsListState>(
        builder: (context, state) {
          if (state is NewsListLoading) {
            return _buildLoadingStateWidgets();
          } else if (state is NewsListLoaded) {
            return _buildNewsLoadedStateWidgets(state);
          } else if (state is NewsListError) {
            return _buildErrorStateWidgets(state);
          }
          return Container();
        },
      ),
    );
  }

  Widget _buildLoadingStateWidgets() => const Center(
        child: CircularProgressIndicator(),
      );

  Widget _buildNewsLoadedStateWidgets(NewsListLoaded state) => ListView(
        padding: const EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: 30),
        children: state.news
            .map((e) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding),
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
                  ),
                ))
            .toList(),
      );

  Widget _buildErrorStateWidgets(NewsListError state) => Text(state.error);
}
