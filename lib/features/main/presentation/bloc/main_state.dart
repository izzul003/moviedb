
part of 'main_cubit.dart';
abstract class MainState extends Equatable {
  const MainState();

  @override
  List<Object> get props => [];
}

class MainPageInitial extends MainState {}

class PageChangeInit extends MainState {}

class PageChanged extends MainState {}