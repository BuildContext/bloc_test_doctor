import 'package:bloc_test_doctor/ui/pages/home_page/bloc/doctor_bloc.dart';
import 'package:bloc_test_doctor/ui/pages/home_page/bloc/doctor_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllertWithButton extends StatelessWidget {
  final String? allertMessage;
  final String buttonText;
  final DoctorEvent buttonEventInit;

  AllertWithButton(
      {this.allertMessage,
      required this.buttonText,
      required this.buttonEventInit});

  @override
  Widget build(BuildContext context) {
    final DoctorBloc doctorBloc = BlocProvider.of<DoctorBloc>(context);
    return Center(
      child: Column(
        children: [
          Text(
            allertMessage ?? '',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text(buttonText),
            onPressed: () {
              doctorBloc.add(buttonEventInit);
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
