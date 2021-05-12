import 'package:bloc_test_doctor/ui/pages/webview_page/widgets/web_view_container.dart';
import 'package:flutter/material.dart';

class DoctorWebViewScreen extends StatelessWidget {
  static const String routeName = '/doc_webview';

  final String url;

  const DoctorWebViewScreen({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WebViewContainer(url),
    );
  }
}
