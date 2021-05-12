import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_bloc.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_event.dart';
import 'package:bloc_test_doctor/ui/pages/details_page/bloc/details_state.dart';
import 'package:bloc_test_doctor/ui/pages/webview_page/web_view_screen.dart';
import 'package:bloc_test_doctor/ui/res/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ButtonToWebView extends StatelessWidget {
  const ButtonToWebView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailsBloc detailsBloc = BlocProvider.of<DetailsBloc>(context);
    detailsBloc.add(CheckDetailLinkEvent());
    return BlocBuilder<DetailsBloc, DetailsState>(
      builder: (context, state) {
        //print(state.runtimeType);
        if (state is DetailsCheckingLinkState) {
          return CircularProgressIndicator();
        } else if (state is DetailsCheckedLinkState) {
          return MaterialButton(
            onPressed: () {
              Navigator.of(context).pushNamed(DoctorWebViewScreen.routeName,
                  arguments: state.url);
            },
            child: Text(AppStrings.buttonDescrDoctor),
            color: Colors.blue[50],
          );
        } else if (state is CheckedLinkErrorState) {
          return Text(AppStrings.noMoreDetails);
        }
        return SizedBox.shrink();
      },
    );
  }
}
