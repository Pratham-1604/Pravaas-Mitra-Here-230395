import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../repository/auth_repository.dart';

final authControllerProvider = Provider((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AuthController(ref: ref, authRepository: authRepository);
});

final userDataAuthProvider = FutureProvider((ref) {
  final authController = ref.watch(authControllerProvider);
  return authController.getuserData();
});

class AuthController {
  final ProviderRef ref;
  final AuthRepository authRepository;

  AuthController({
    required this.ref,
    required this.authRepository,
  });

  Future<String?> getuserData() async {
    String? userId = await authRepository.getCurrentUserData();
    return userId;
  }

  void logout() {
    return authRepository.logoutUser();
  }

  void signUpWithEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    return authRepository.createUserWithEmailPassword(
      context: context,
      email: email,
      password: password,
      ref: ref,
    );
  }

  void saveUserDataToFirebase({
    required BuildContext context,
    required String name,
    required String phoneNumber,
    required File? profilePic,
    required String address,
  }) {
    return authRepository.saveUserDataToFirebase(
      context: context,
      name: name,
      phoneNumber: phoneNumber,
      address: address,
      ref: ref,
    );
  }

  void signInWithEmailAndPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) {
    return authRepository.signInWithEmailPassword(
      context: context,
      email: email,
      password: password,
    );
  }
}
