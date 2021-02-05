import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/custom_elevated_button.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Time Tracker'),
        elevation: 2.0,
      ),
      body: _buildContent(),
    );
  }

  // container from scaffold
  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Sign In',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 32.0,
              fontWeight: FontWeight.w800,
            ),
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomElevatedButton(
            child: Text(
              'Sign in with Google',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
              ),
            ),
            color: Colors.white,
            borderRadius: 20.0,
            onPressed: () {},
          ),
          SizedBox(
            height: 8.0,
          ),
          CustomElevatedButton(
            child: Text(
              'Sign in with Facebook',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 15.0,
              ),
            ),
            color: Colors.white,
            borderRadius: 20.0,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
