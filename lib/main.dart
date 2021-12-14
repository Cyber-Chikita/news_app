import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/repositories/news_repository.dart';
import 'package:news_app/screens/news_list/bloc/news_list_bloc.dart';
import 'package:news_app/screens/news_list/news_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: RepositoryProvider(
        create: (context) => NewsRepository(),
        child: BlocProvider(
          create: (context) => NewsListBloc(
            NewsListLoading(),
            context.read<NewsRepository>(),
          )..add(UpdateRequested()),
          child: NewsListScreen(),
        ),
      ),
    );
  }
}
