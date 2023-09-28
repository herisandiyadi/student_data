import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_student_app/data/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepositoryImpl authRepositoryImpl;
  AuthCubit(this.authRepositoryImpl) : super(AuthInitial());

  Future<void> login(String username, String password) async {
    Future.delayed(const Duration(seconds: 2));
    emit(AuthLoading());
    try {
      final result = await authRepositoryImpl.login(username, password);

      emit(AuthSuccess(result));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
