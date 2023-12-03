import 'package:bloc/bloc.dart';

import 'state.dart';

class NewsAppCubit extends Cubit<NewsAppState> {
  NewsAppCubit() : super(NewsAppState().init());
}
