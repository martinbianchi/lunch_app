import 'package:bloc/bloc.dart';
import 'package:lunch_app/blocs/authentication/authentication_event.dart';
import 'package:lunch_app/blocs/authentication/authentication_state.dart';
import 'package:lunch_app/repositories/user_repository.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> { 
  final UserRepository userRepository;

  AuthenticationBloc({this.userRepository});

  @override 
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    if(event is AppStarted) {
      final bool hasToken = await userRepository.hasToken();

      if(hasToken) {
        yield AuthenticationAuthenticated();
      }
      else{
        yield AuthenticationUnauthenticated();
      }
    }

    if(event is LoggedIn) {
      yield AuthenticationLoading();

      await userRepository.persistToken(event.token);
      yield AuthenticationAuthenticated();
    }

    if(event is LoggedOut) {
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }

}