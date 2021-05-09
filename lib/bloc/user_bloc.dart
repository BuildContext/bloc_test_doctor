import 'package:bloc_test_doctor/bloc/user_event.dart';
import 'package:bloc_test_doctor/bloc/user_state.dart';
import 'package:bloc_test_doctor/models/user.dart';
import 'package:bloc_test_doctor/services/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UsersRepository usersRepository;

  UserBloc(UserEmptyState initialState, {required this.usersRepository})
      : super(initialState);
  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    print(event.runtimeType);
    if (event is UserLoadEvent) {
      yield UserLoadingState();
      try {
        final List<User> _loadedUserList = await usersRepository.getAllUsers();
        yield UserLoadedState(loadedUser: _loadedUserList);
      } catch (_) {
        print(_);
        yield UserErrorState();
      }
    } else if (event is UserClearEvent) {
      yield UserEmptyState();
    }
  }
}
