import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_state.dart';
class MainCubit extends Cubit<MainState> {

  MainCubit() : super(MainPageInitial());

  int activePage = 0;

  void changeActivePageIndex(int newActivePage) {
    emit(PageChangeInit());

    activePage = newActivePage;

    emit(PageChanged());
  }

}
