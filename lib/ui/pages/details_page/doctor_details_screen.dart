import 'package:bloc_test_doctor/models/doctor.dart';
import 'package:bloc_test_doctor/services/doctors_repository.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_bloc.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_state.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/widgets/button_to_webview.dart';
import 'package:bloc_test_doctor/ui/res/app_strings.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/widgets/details_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorDetailsScreen extends StatelessWidget {
  static const String routeName = '/doc_detail';
  final doctorsRepository = DoctorsRepository();
  final Doctor doctor;

  DoctorDetailsScreen({Key? key, required this.doctor}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsBloc>(
      create: (context) => DetailsBloc(DetailsEmptyState(),
          doctorsRepository: doctorsRepository, url: doctor.detailsLink),
      child: Scaffold(
        appBar: AppBar(
          title: Text('${doctor.firstName} ${doctor.lastName}'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Column(
            children: [
              DetailsRow(
                  name: AppStrings.description,
                  detail: doctor.description,
                  icon: Icons.description),
              SizedBox(
                height: 10,
              ),
              DetailsRow(
                  name: AppStrings.workingHours,
                  detail: doctor.workingHours,
                  icon: Icons.timer),
              SizedBox(
                height: 10,
              ),
              DetailsRow(
                  name: AppStrings.specialty,
                  detail: doctor.speciality,
                  icon: Icons.medical_services),
              SizedBox(
                height: 30,
              ),
              Center(child: ButtonToWebView())
            ],
          ),
        ),
      ),
    );
  }
}
