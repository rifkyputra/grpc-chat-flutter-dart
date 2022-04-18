import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit(AppState initialState) : super(initialState);

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class AppState extends Equatable {
  final String username;
}
