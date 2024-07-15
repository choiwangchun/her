import 'package:flutter/material.dart';

class PersonalitySelectionForm extends StatefulWidget {
  final Function(String mbti, String interest, String talkStyle, String age) onSubmit;

  PersonalitySelectionForm({required this.onSubmit});

  @override
  _PersonalitySelectionFormState createState() => _PersonalitySelectionFormState();
}

class _PersonalitySelectionFormState extends State<PersonalitySelectionForm> {
  String _mbti = '';
  String _interest = '';
  String _talkStyle = '';
  String _age = '';

  final List<String> _mbtiTypes = [
    'ISTJ', 'ISFJ', 'INFJ', 'INTJ', 'ISTP', 'ISFP', 'INFP', 'INTP',
    'ESTP', 'ESFP', 'ENFP', 'ENTP', 'ESTJ', 'ESFJ', 'ENFJ', 'ENTJ'
  ];
  final List<String> _interests = ['예술/문화', '스포츠/운동', '과학/기술', '여행/모험', '음식/요리'];
  final List<String> _talkStyles = ['유머러스한', '진지한', '지적인', '감성적인'];
  final List<String> _ageGroups = ['20-24세', '25-29세', '30-34세', '35-39세'];

  void _trySubmit() {
    if (_mbti.isNotEmpty && _interest.isNotEmpty && _talkStyle.isNotEmpty && _age.isNotEmpty) {
      widget.onSubmit(_mbti, _interest, _talkStyle, _age);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('모든 항목을 선택해주세요.')),
      );
    }
  }

  Widget _buildSelectionSection(String title, List<String> options, String selectedValue, Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            return ChoiceChip(
              label: Text(option),
              selected: selectedValue == option,
              onSelected: (selected) {
                if (selected) {
                  onSelect(option);
                }
              },
            );
          }).toList(),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildSelectionSection('MBTI', _mbtiTypes, _mbti, (value) => setState(() => _mbti = value)),
            _buildSelectionSection('관심사', _interests, _interest, (value) => setState(() => _interest = value)),
            _buildSelectionSection('대화 스타일', _talkStyles, _talkStyle, (value) => setState(() => _talkStyle = value)),
            _buildSelectionSection('나이', _ageGroups, _age, (value) => setState(() => _age = value)),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                child: Text('선택 완료'),
                onPressed: _trySubmit,
              ),
            ),
          ],
        ),
      ),
    );
  }
}