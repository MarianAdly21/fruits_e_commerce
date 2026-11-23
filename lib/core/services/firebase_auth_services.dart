import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_e_commerce/core/errors/exceptions.dart';
import 'package:fruits_e_commerce/core/errors/failure.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthServices {
  Future<User> signinWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw CustomException(
          message: 'لا يوجد مستخدم بهذا البريد الإلكتروني.',
        );
      } else if (e.code == 'wrong-password') {
        throw CustomException(message: 'كلمة المرور غير صحيحة.');
      } else if (e.code == 'invalid-credential') {
        throw CustomException(
          message: 'البريد الإلكتروني أو كلمة المرور غير صحيحة.',
        );
      } else if (e.code == 'user-disabled') {
        throw CustomException(message: 'تم تعطيل هذا الحساب.');
      } else if (e.code == 'too-many-requests') {
        throw CustomException(message: 'محاولات كثيرة، حاول مرة أخرى لاحقًا.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالإنترنت.');
      } else {
        log(
          "from signinWithEmailAndPassword(FirebaseAuthException) ===> ${e.toString()} ",
        );
        throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log("from signinWithEmailAndPassword ===> ${e.toString()} ");
      throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
    }
  }

  Future<User> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw CustomException(message: 'كلمة المرور ضعيفة جدًا.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(message: 'هذا البريد الإلكتروني مستخدم بالفعل.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(message: 'البريد الإلكتروني غير صالح.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالإنترنت.');
      } else {
        throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
      }
    } catch (e) {
      log("from createUserWithEmailAndPassword ===> ${e.toString()} ");
      throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
    }
  }

  Future<User> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn.instance
          .authenticate();

      final GoogleSignInAuthentication? googleAuth = googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth?.idToken,
      );
      return (await FirebaseAuth.instance.signInWithCredential(credential))
          .user!;
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        throw CancelledByUserException(message: 'GoogleSignInExceptionCode.canceled');
      }
      log("from GoogleSignInException ===> ${e.toString()} ");

      throw CustomException(message: 'تعذّر تسجيل الدخول بحساب جوجل.');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') {
        throw CustomException(message: 'تأكد من اتصالك بالإنترنت.');
      }
      log(
        "from GoogleSignInException (FirebaseAuthException) ===> ${e.toString()} ",
      );
      throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
    } catch (e) {
      log("from GoogleSignInException ===> ${e.toString()} ");
      throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
    }
  }
}
