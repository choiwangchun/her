class User {
  final String email;
  String? gender;
  int? age;
  String? mbti;

  User({
    required this.email,
    this.gender,
    this.age,
    this.mbti,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'gender': gender,
      'age': age,
      'mbti': mbti,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      gender: json['gender'],
      age: json['age'],
      mbti: json['mbti'],
    );
  }
}