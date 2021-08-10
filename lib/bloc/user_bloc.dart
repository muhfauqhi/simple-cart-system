import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dekornata_app_test/models/user.dart';
import 'package:dekornata_app_test/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserDataProvider userProvider = UserDataProvider();

  UserBloc() : super(UserInitial()) {
    add(UserInitializedEvent());
  }

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is UserInitializedEvent) {
      User user = await userProvider.getUser();
      yield UserLoadedState(user);
    }
  }
}
