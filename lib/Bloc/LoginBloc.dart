import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/Network/authenticating_client.dart';
import 'package:http/http.dart' as http;


class LoginBloc extends Cubit<LoginState> {
  final Authenticator authenticator;

  LoginBloc(this.authenticator) : super(NormalState());

  Future<AuthenticatingClient?> login(final String username, final String password) async {
    if (state is! NormalState) return null;
    emit(AttemptState());
    final token = await authenticator.authenticate(username, password);
    if (token == null) {
      emit(ErrorState("Invalid credentials"));
      await Future.delayed(const Duration(seconds: 1));
      emit(NormalState());
      return null;
    }
    final client = AuthenticatingClient(http.Client(), authenticator, username, password);
    emit(LoggedInState(client));
    return client;
  }
}

abstract class LoginState {}

class NormalState extends LoginState {}

class AttemptState extends LoginState {}

class ErrorState extends LoginState {
  String message;

  ErrorState(this.message);
}

class LoggedInState extends LoginState {
  AuthenticatingClient authenticatingClient;

  LoggedInState(this.authenticatingClient);
}
