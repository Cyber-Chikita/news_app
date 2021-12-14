part of './news_list_bloc.dart';

abstract class NewsListEvent {}

class UpdateRequested extends NewsListEvent {}

class LoadNextRequested extends NewsListEvent {
  final DateTime sinceDate;
  final int offset;

  LoadNextRequested(this.sinceDate, this.offset);
}
