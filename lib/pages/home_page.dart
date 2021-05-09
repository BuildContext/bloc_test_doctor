import 'package:bloc_test_doctor/bloc/user_bloc.dart';
import 'package:bloc_test_doctor/bloc/user_state.dart';
import 'package:bloc_test_doctor/services/user_repository.dart';
import 'package:bloc_test_doctor/widgets/action_buttons.dart';
import 'package:bloc_test_doctor/widgets/user_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  final usersRepository = UsersRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) =>
          UserBloc(UserEmptyState(), usersRepository: usersRepository),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Users List'),
          centerTitle: true,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ActionButtons(), Expanded(child: UserList())],
        ),
      ),
    );
  }
}
