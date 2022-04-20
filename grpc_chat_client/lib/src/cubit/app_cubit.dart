import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

class AppCubit extends HydratedCubit<AppState> {
  AppCubit() : super(const AppState());

  void saveUsername(String username) async {
    emit(state.copyWith(username: username));
  }

  @override
  AppState? fromJson(Map<String, dynamic> json) {
    return AppState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AppState state) {
    return state.toJson();
  }
}

class AppState extends Equatable {
  final String? username;

  const AppState({this.username});

  @override
  List<Object?> get props => [
        username,
      ];

  static fromJson(Map map) {
    return AppState(
      username: map['username'],
    );
  }

  Map<String, dynamic>? toJson() {
    return {
      'username': username,
    };
  }

  AppState copyWith({
    String? username,
  }) {
    return AppState(
      username: username ?? this.username,
    );
  }
}
