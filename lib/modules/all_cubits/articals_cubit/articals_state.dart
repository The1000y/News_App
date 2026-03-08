part of 'articals_cubit.dart';

sealed class ArticalsState {}

final class ArticalsInitial extends ArticalsState {}

class SuccessGetArtical extends ArticalsState {
  List<Artical>? listArtical = [];
  SuccessGetArtical({required this.listArtical});
}

class ErrorGetArtical extends ArticalsState {
  ErrorGetArtical();
}

class LoadingGetArtical extends ArticalsState {
  LoadingGetArtical();
}
