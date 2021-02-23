import 'package:flutter/foundation.dart';
import 'package:time_tracker/app/models/email_sign_in_model.dart';
import 'package:time_tracker/app/signin/validators.dart';

class EmailSignInChangeModel with EmailAndPasswordValidators, ChangeNotifier {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  EmailSignInChangeModel({
    this.email = '',
    this.password = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Sign In'.toUpperCase()
        : 'Create an account'.toUpperCase();
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Need an Account? Register'
        : 'Have an account? Sign In';
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);

    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);

    return showErrorText ? invalidEmailErrorText : null;
  }

  EmailSignInChangeModel copyWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    return EmailSignInChangeModel(
      email: email ?? this.email,
      password: password ?? this.password,
      formType: formType ?? this.formType,
      isLoading: isLoading ?? this.isLoading,
      submitted: submitted ?? this.submitted,
    );
  }
}
