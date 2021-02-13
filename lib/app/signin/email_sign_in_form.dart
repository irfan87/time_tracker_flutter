import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailSignInForm extends StatelessWidget {
  List<Widget> _buildChildren() {
    return [
      TextField(
        decoration: InputDecoration(
          labelText: 'Email',
          hintText: 'your@email.com',
        ),
        keyboardType: TextInputType.emailAddress,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextField(
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8.0,
      ),
      ElevatedButton(
        onPressed: () {},
        child: Text('Sign In'),
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: () {},
        child: Text('New Member? Register'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
