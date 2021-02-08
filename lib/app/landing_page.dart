import 'package:flutter/material.dart';
import 'package:time_tracker/app/signin/sign_in.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}
