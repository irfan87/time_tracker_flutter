import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_tracker/common_widgets/form_submit_elevated_button.dart';
import 'package:time_tracker/services/auth.dart';

enum EmailSignInFormType {
  signIn,
  register,
}

class EmailSignInForm extends StatefulWidget {
  final AuthBase auth;

  EmailSignInForm({@required this.auth});

  @override
  _EmailSignInFormState createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signIn;

  void _submit() async {
    try {
      if (_formType == EmailSignInFormType.signIn) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassword(_email, _password);
      }

      Navigator.of(context).pop();
    } catch (e) {
      print(e.toString());
    }
  }

  void _toggleFormType() {
    setState(() {
      _formType = _formType == EmailSignInFormType.signIn
          ? EmailSignInFormType.register
          : EmailSignInFormType.signIn;
    });

    _emailController.clear();
    _passwordController.clear();
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signIn
        ? 'Sign In'.toUpperCase()
        : 'Create an account'.toUpperCase();

    final secondaryText = _formType == EmailSignInFormType.signIn
        ? 'Need an Account? Register'
        : 'Have an account? Sign In';

    return [
      _buildEmailTextField(),
      SizedBox(
        height: 8.0,
      ),
      _buildPasswordTextField(),
      SizedBox(
        height: 8.0,
      ),
      FormSubmitElevatedButton(
        text: primaryText,
        onPressed: _submit,
      ),
      SizedBox(
        height: 8.0,
      ),
      TextButton(
        onPressed: _toggleFormType,
        child: Text(secondaryText),
      ),
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      decoration: InputDecoration(
        labelText: 'Email',
        hintText: 'your@email.com',
      ),
      keyboardType: TextInputType.emailAddress,
      autocorrect: false,
      textInputAction: TextInputAction.next,
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
      ),
      obscureText: true,
      textInputAction: TextInputAction.done,
    );
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
