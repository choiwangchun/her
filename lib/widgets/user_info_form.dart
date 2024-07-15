import 'package:flutter/material.dart';

class UserInfoForm extends StatefulWidget {
  final Function(String gender, int age, String mbti) onSubmit;

  UserInfoForm({required this.onSubmit});

  @override
  _UserInfoFormState createState() => _UserInfoFormState();
}

class _UserInfoFormState extends State<UserInfoForm> {
  final _formKey = GlobalKey<FormState>();
  String _gender = '';
  int _age = 0;
  String _mbti = '';

  final List<String> _genders = ['남성', '여성', '기타'];
  final List<String> _mbtiTypes = [
    'ISTJ', 'ISFJ', 'INFJ', 'INTJ', 'ISTP', 'ISFP', 'INFP', 'INTP',
    'ESTP', 'ESFP', 'ENFP', 'ENTP', 'ESTJ', 'ESFJ', 'ENFJ', 'ENTJ'
  ];

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      widget.onSubmit(_gender, _age, _mbti);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          DropdownButtonFormField<String>(
            value: _gender.isNotEmpty ? _gender : null,
            hint: Text('성별을 선택하세요'),
            items: _genders.map((gender) {
              return DropdownMenuItem(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _gender = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '성별을 선택해주세요';
              }
              return null;
            },
          ),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: '나이'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return '나이를 입력해주세요';
              }
              if (int.tryParse(value) == null) {
                return '올바른 나이를 입력해주세요';
              }
              return null;
            },
            onSaved: (value) {
              _age = int.parse(value!);
            },
          ),
          DropdownButtonFormField<String>(
            value: _mbti.isNotEmpty ? _mbti : null,
            hint: Text('MBTI를 선택하세요'),
            items: _mbtiTypes.map((mbti) {
              return DropdownMenuItem(
                value: mbti,
                child: Text(mbti),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _mbti = value!;
              });
            },
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'MBTI를 선택해주세요';
              }
              return null;
            },
          ),
          SizedBox(height: 12),
          ElevatedButton(
            child: Text('정보 저장'),
            onPressed: _trySubmit,
          ),
        ],
      ),
    );
  }
}