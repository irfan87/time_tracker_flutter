import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/form_submit_elevated_button.dart';

class EmailSignInForm extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _submit() {
    print(
        'Email: ${_emailController.text}\nPassword: ${_passwordController.text}');
  }

  List<Widget> _buildChildren() {
    return [
      TextField(
        controller: _emailController,
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
        controller: _passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitElevatedButton(
        text: 'Sign In',
        onPressed: _submit,
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
