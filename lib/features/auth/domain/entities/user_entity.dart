class UserEntity {
  final String userId;
  final String name;
  final String email;

  new({required this.userId, required this.name, required this.email});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'uId': userId};
  }
}
