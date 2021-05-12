import 'package:bloc_test_doctor/models/doctor.dart';
import 'package:bloc_test_doctor/services/doctor_api_provider.dart';

class DoctorsRepository {
  DoctorProvider _doctorsProvider = DoctorProvider();
  Future<List<Doctor>> getAllDoctors() => _doctorsProvider.getDoctors();
  Future<List<Doctor>> getPartOfDoctors(
          {required int count, required int start}) =>
      _doctorsProvider.getDoctors(start: start, count: count);

  Future<bool> checkUrl(String url) => _doctorsProvider.isValidUrl(url);
}
