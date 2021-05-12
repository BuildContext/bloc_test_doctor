import 'package:bloc_test_doctor/services/doctors_repository.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_event.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsBloc extends Bloc<DetailEvent, DetailsState> {
  DoctorsRepository doctorsRepository;
  String url;

  DetailsBloc(DetailsState initialState,
      {required this.doctorsRepository, required this.url})
      : super(initialState);

  @override
  Stream<DetailsState> mapEventToState(DetailEvent event) async* {
    if (event is CheckDetailLinkEvent) {
      yield DetailsCheckingLinkState();
      //print('fdf $url');
      if (await doctorsRepository.checkUrl(url)) {
        yield DetailsCheckedLinkState(url: url);
      } else
        yield CheckedLinkErrorState();
    }
  }
}
