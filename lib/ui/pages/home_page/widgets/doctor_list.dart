import 'package:bloc_test_doctor/models/doctor.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/doctor_details_screen.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/bloc/doctor_bloc.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/bloc/doctor_event.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/bloc/doctor_state.dart';
import 'package:bloc_test_doctor/ui/res/app_strings.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/widgets/alert_with_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final ScrollController _scrollController = ScrollController();

  final List<Doctor> _doctors = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final DoctorBloc doctorBloc = BlocProvider.of<DoctorBloc>(context);
    bool isLoadingListView = false;
    doctorBloc.add(DoctorLoadEvent());
    return BlocConsumer<DoctorBloc, DoctorState>(listener: (context, state) {
      if (state is DoctorLoadedState && state.loadedDoctor.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppStrings.noMoreDoctors),
          duration: Duration(milliseconds: 700),
        ));
      }
    }, builder: (context, state) {
      if (state is DoctorEmptyState) {
        return AllertWithButton(
            allertMessage: AppStrings.messageReloadLater,
            buttonText: AppStrings.buttonReloadText,
            buttonEventInit: DoctorLoadEvent());
      }

      if (state is DoctorLoadingState && _doctors.isEmpty) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is DoctorLoadingState && _doctors.isNotEmpty) {
        isLoadingListView = true;
      }

      if (state is DoctorLoadedState) {
        _doctors.addAll(state.loadedDoctor);
        doctorBloc.isFetching = false;
        isLoadingListView = false;
      }

      if (state is DoctorErrorState) {
        return AllertWithButton(
            allertMessage: AppStrings.messageError,
            buttonText: AppStrings.buttonReloadText,
            buttonEventInit: DoctorLoadEvent());
      }

      return ListView.builder(
        controller: _scrollController
          ..addListener(() {
            if (_scrollController.offset ==
                    _scrollController.position.maxScrollExtent &&
                !doctorBloc.isFetching) {
              doctorBloc
                ..isFetching = true
                ..add(DoctorLoadEvent());
            }
          }),
        itemCount: _doctors.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () {
            Navigator.of(context).pushNamed(DoctorDetailsScreen.routeName,
                arguments: _doctors[index]);
          },
          child: Column(
            children: [
              Container(
                height: 120,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                color: index % 2 == 0 ? Colors.white : Colors.blue[50],
                child: ListTile(
                  leading: _doctors[index].avatarLink != null
                      ? CircleAvatar(
                          radius: (52),
                          backgroundColor:
                              index % 2 == 0 ? Colors.blue[50] : Colors.white,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(48),
                            child: Image.network(
                              _doctors[index].avatarLink!,
                              fit: BoxFit.cover,
                              width: 48,
                              height: 48,
                            ),
                          ),
                        )
                      : Text(AppStrings.noImage),
                  title: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_doctors[index].firstName} ${_doctors[index].lastName}',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              isLoadingListView && index == _doctors.length - 1
                  ? Container(
                      height: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          ),
        ),
      );
    });
  }
}
