import 'package:firebase_auth/firebase_auth.dart';
import 'package:fruits_e_commerce/core/errors/exceptions.dart';

class FirebaseAuthServices {
  // Future<User> createUserWithEmailAndPassword({
  //   required String email,
  //   required String password,
  // }) async {
  //   try {
  //     final credential = await FirebaseAuth.instance
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //     return credential.user!;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       throw CustomException(message: 'هذا البريد الإلكتروني مستخدم بالفعل.');
  //     } else if (e.code == 'wrong-password') {
  //       throw CustomException(message: 'كلمة المرور ضعيفة جدًا.');
  //     } else {
  //       throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
  //     }
  //   } catch (e) {
  //     throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
  //   }
  // }

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
      throw CustomException(message: 'حدث خطأ، حاول مرة أخرى لاحقًا.');
    }
  }
}
