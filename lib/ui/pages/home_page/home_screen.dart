import 'package:bloc_test_doctor/services/doctors_repository.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/widgets/doctor_list.dart';
import 'package:bloc_test_doctor/ui/res/app_strings.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/doctor_bloc.dart';
import 'bloc/doctor_state.dart';

class HomeScreen extends StatelessWidget {
  final doctorsRepository = DoctorsRepository();
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DoctorBloc>(
      create: (context) =>
          DoctorBloc(DoctorEmptyState(), doctorsRepository: doctorsRepository),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(AppStrings.doctorsList),
          centerTitle: true,
        ),
        body: DoctorList(),
      ),
    );
  }
}
