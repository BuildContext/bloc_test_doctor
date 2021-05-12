import 'package:bloc_test_doctor/models/doctor.dart';

abstract class DoctorState {}

class DoctorEmptyState extends DoctorState {}

class DoctorLoadingState extends DoctorState {}

class DoctorLoadedState extends DoctorState {
  List<Doctor> loadedDoctor;

  DoctorLoadedState({required this.loadedDoctor});
}

class DoctorErrorState extends DoctorState {}
