part of './news_list_bloc.dart';

abstract class NewsListEvent {}

class UpdateRequested extends NewsListEvent {}

class LoadNextRequested extends NewsListEvent {}
