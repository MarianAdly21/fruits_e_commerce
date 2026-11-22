import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_e_commerce/core/errors/exceptions.dart';
import 'package:fruits_e_commerce/core/errors/failure.dart';
import 'package:fruits_e_commerce/core/services/firebase_auth_services.dart';
import 'package:fruits_e_commerce/features/auth/data/models/user_model.dart';
import 'package:fruits_e_commerce/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_e_commerce/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;

  new({required this.firebaseAuthServices});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      return left(ServerFailure(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      User user = await firebaseAuthServices.signinWithEmailAndPassword(
        email: email,
        password: password,
      );

      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      return left(ServerFailure(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.'));
    }
  }
}
