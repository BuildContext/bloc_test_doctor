import 'package:bloc_test_doctor/models/doctor.dart';
import 'package:bloc_test_doctor/services/doctors_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'doctor_event.dart';
import 'doctor_state.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorsRepository doctorsRepository;

  bool isFetching = false;

  ///simulate backend query for pagination
  int itemsToLoad = 7;
  int countOfLoaded = 0;

  DoctorBloc(DoctorState initialState, {required this.doctorsRepository})
      : super(initialState);
  @override
  Stream<DoctorState> mapEventToState(DoctorEvent event) async* {
    if (event is DoctorLoadEvent) {
      yield DoctorLoadingState();
      try {
        final List<Doctor> _loadedDoctorList =
            await doctorsRepository.getPartOfDoctors(
          start: countOfLoaded,
          count: itemsToLoad,
        );
        yield DoctorLoadedState(loadedDoctor: _loadedDoctorList);
        countOfLoaded += itemsToLoad;
      } catch (_) {
        //print(_);
        yield DoctorErrorState();
      }
    } else if (event is DoctorClearEvent) {
      yield DoctorEmptyState();
    }
  }
}
