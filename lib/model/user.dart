import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final String avatar;
  final DateTime dateOfBirth;
  final int score;

  UserModel(
      {required this.id,
      required this.username,
      required this.email,
      required this.avatar,
      required this.dateOfBirth,
      this.score = 0});
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      avatar: map['avatar'] ?? '',
      dateOfBirth: (map['dateOfBirth'] != null)
          ? (map['dateOfBirth'] as Timestamp).toDate()
          : DateTime.now(),
      score: (map['score'] is int) 
          ? map['score'] as int
          : int.tryParse(map['score'].toString()) ??
              0,
    );
  }

  factory UserModel.empty() {
    return UserModel(
        id: '',
        username: '',
        email: '',
        avatar: '',
        dateOfBirth: DateTime.now());
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': id,
      'username': username,
      'email': email,
      'avatar': avatar,
      'dateOfBirth': dateOfBirth,
      'score': score
    };
  }

   @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! UserModel) return false;
    
    return other.id == id &&
        other.username == username &&
        other.email == email &&
        other.avatar == avatar &&
        other.dateOfBirth == dateOfBirth &&
        other.score == score;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        username.hashCode ^
        email.hashCode ^
        avatar.hashCode ^
        dateOfBirth.hashCode ^
        score.hashCode;
  }
}
