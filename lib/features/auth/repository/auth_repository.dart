// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:here/common_widget/routing_function.dart';
import 'package:here/features/auth/user_screen.dart';
import 'package:here/features/home_page/main_page.dart';

import '../../../common_widget/common_snackbar.dart';
import '../../../models/user_model.dart';

final authRepositoryProvider = Provider((ref) {
  return AuthRepository(
    firestore: FirebaseFirestore.instance,
    auth: FirebaseAuth.instance,
  );
});

class AuthRepository {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;
  AuthRepository({
    required this.firestore,
    required this.auth,
  });

  Future<String?> getCurrentUserData() async {
    var userData =
        await firestore.collection('users').doc(auth.currentUser?.uid).get();
    UserModel? user;
    if (userData.data() != null) {
      user = UserModel.fromMap(userData.data()!);
      return user.userId;
    }
    return null;
  }

  void logoutUser() async {
    await auth.signOut();
  }

  void createUserWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
    required ProviderRef ref,
  }) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      popAndPushNamed(routeName: UserInformationScreen.routeName, ctx: context);
      
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        showsnackbar(
          context: context,
          msg: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        showsnackbar(
          context: context,
          msg: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      showsnackbar(
        context: context,
        msg: e.toString(),
      );
    }
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required String name,
    required String phoneNumber,
    required ProviderRef ref,
    required String address,
  }) async {
    try {
      var user = UserModel(
        name: name,
        userId: auth.currentUser!.uid,
        phone: phoneNumber,
        userAddress: address,
        email: auth.currentUser!.email!,
      );
      await firestore
          .collection('users')
          .doc(auth.currentUser!.uid)
          .set(user.toMap());
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (route) => false,
      );
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }

  void signInWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushNamedAndRemoveUntil(
        context,
        HomePage.routeName,
        (route) => false,
      );
      return;
    } catch (e) {
      showsnackbar(context: context, msg: e.toString());
    }
  }
}
