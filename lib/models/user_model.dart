class UserModel {
  final String uid;
  final String fullName;
  final String studentId;
  final String email;
  final String role;
  final String photoUrl;
  final DateTime? createdAt;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.studentId,
    required this.email,
    this.role = 'student',
    this.photoUrl = '',
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'fullName': fullName,
      'studentId': studentId,
      'email': email,
      'role': role,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
    };
  }
}
