import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_e_commerce/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  new({required super.userId, required super.name, required super.email});

  factory UserModel.fromFirebaseUser(User user) {
    return UserModel(
      userId: user.uid,
      name: user.displayName ?? "",
      email: user.email ?? "",
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["uId"],
      name: json["name"],
      email: json["email"],
    );
  }
}
