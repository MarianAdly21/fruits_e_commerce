import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_e_commerce/core/errors/exceptions.dart';
import 'package:fruits_e_commerce/core/errors/failure.dart';
import 'package:fruits_e_commerce/core/services/database_service.dart';
import 'package:fruits_e_commerce/core/services/firebase_auth_services.dart';
import 'package:fruits_e_commerce/core/utils/backend_endpoints.dart';
import 'package:fruits_e_commerce/features/auth/data/models/user_model.dart';
import 'package:fruits_e_commerce/features/auth/domain/entities/user_entity.dart';
import 'package:fruits_e_commerce/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthServices firebaseAuthServices;
  final DatabaseServices databaseServices;

  new({required this.firebaseAuthServices, required this.databaseServices});

  @override
  Future<Either<Failure, UserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
  }) async {
    User? user;
    try {
      user = await firebaseAuthServices.createUserWithEmailAndPassword(
        email: email,
        password: password,
        name: name,
      );
      // var userEntity = UserModel.fromFirebaseUser(user);

      var userEntity = UserEntity(name: name, email: email, userId: user.uid);
      await addUserData(user: userEntity);
      return right(userEntity);
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      await deleteUser(user);
      log("createUserWithEmailAndPassword=====> ${e.toString()}");
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
      var userEntity = await getUserData(uId: user.uid);

      return right(userEntity);
    } on CustomException catch (e) {
      log("from signinWithEmailAndPassword ===> ${e.toString()} ");
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      log("from signinWithEmailAndPassword ===> ${e.toString()} ");
      return left(ServerFailure(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithGoogle() async {
    User? user;
    try {
      user = await firebaseAuthServices.signInWithGoogle();

      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      await deleteUser(user);

      if (e is CancelledByUserException) {
        log(
          "from signinWithGoogleRepoImpl(CancelledByUserException) ===> ${e.toString()} ",
        );
        return left(CancelledFailure(message: ''));
      } else {
        return left(ServerFailure(message: e.toString()));
      }
    } catch (e) {
      await deleteUser(user);

      log("from signinWithGoogleRepoImpl ===> ${e.toString()} ");
      return left(ServerFailure(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> signinWithFacebook() async {
    User? user;
    try {
      user = await firebaseAuthServices.signInWithFacebook();
      var userEntity = UserModel.fromFirebaseUser(user);
      await addUserData(user: userEntity);
      return right(UserModel.fromFirebaseUser(user));
    } on CustomException catch (e) {
      await deleteUser(user);
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      await deleteUser(user);
      log("from signinWithFacebookRepoImpl ===> ${e.toString()} ");
      return left(ServerFailure(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.'));
    }
  }

  @override
  Future<dynamic> addUserData({required UserEntity user}) async {
    await databaseServices.addDate(
      path: BackendEndpoints.addUserData,
      data: user.toMap(),
      documentId: user.userId,
    );
  }

  @override
  Future<UserEntity> getUserData({required String uId}) async {
    Map<String, dynamic> data = await databaseServices.getDate(
      path: BackendEndpoints.getUserData,
      documentId: uId,
    );
    return UserModel.fromJson(data);
  }

  Future<void> deleteUser(User? user) async {
    if (user != null) {
      await firebaseAuthServices.deleteUser();
    }
  }
}
