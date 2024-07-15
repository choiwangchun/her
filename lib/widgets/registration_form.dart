import 'package:flutter/material.dart';

class RegistrationForm extends StatefulWidget {
  final Function(String email, String password) onSubmit;

  RegistrationForm({required this.onSubmit});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.onSubmit(_email.trim(), _password.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextFormField(
            key: ValueKey('email'),
            validator: (value) {
              if (value!.isEmpty || !value.contains('@')) {
                return '올바른 이메일 주소를 입력해주세요.';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: '이메일 주소',
            ),
            onSaved: (value) {
              _email = value!;
            },
          ),
          TextFormField(
            key: ValueKey('password'),
            validator: (value) {
              if (value!.isEmpty || value.length < 7) {
                return '비밀번호는 최소 7자 이상이어야 합니다.';
              }
              return null;
            },
            decoration: InputDecoration(labelText: '비밀번호'),
            obscureText: true,
            onSaved: (value) {
              _password = value!;
            },
          ),
          TextFormField(
            key: ValueKey('confirm_password'),
            validator: (value) {
              if (value != _password) {
                return '비밀번호가 일치하지 않습니다.';
              }
              return null;
            },
            decoration: InputDecoration(labelText: '비밀번호 확인'),
            obscureText: true,
          ),
          SizedBox(height: 12),
          ElevatedButton(
            child: Text('회원가입'),
            onPressed: _trySubmit,
          ),
        ],
      ),
    );
  }
}