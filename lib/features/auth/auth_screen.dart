// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widget/common_snackbar.dart';
import 'controller/auth_controller.dart';

class AuthScreen extends ConsumerStatefulWidget {
  const AuthScreen({super.key});

  static const routeName = '/auth-screen';

  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  bool isLogin = true;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  void login() {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ref.read(authControllerProvider).signInWithEmailAndPassword(
            context: context,
            email: email,
            password: password,
          );
    } else {
      showsnackbar(
        context: context,
        msg: 'please input both the fields properly',
      );
    }
  }

  void signUp() {
    var email = emailController.text.trim();
    var password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      ref.read(authControllerProvider).signUpWithEmailPassword(
            context: context,
            email: email,
            password: password,
          );
    } else {
      showsnackbar(
        context: context,
        msg: 'please input both the fields properly',
      );
    }
  }

  void changeShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Center(
                child: Image.asset(
                  'assets/auth.jpg',
                  fit: BoxFit.fill,
                  width: size.width,
                  height: size.height,
                ),
              ),
              Positioned(
                top: size.height * 0.1,
                child: SizedBox(
                  width: size.width,
                  child: Text(
                    'Pravaas Mitra',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.2,
                child: SizedBox(
                  width: size.width,
                  child: Text(
                    isLogin ? 'Login' : 'Register',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.3,
                child: SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: emailController,
                          decoration: InputDecoration(
                            hintText: 'Email',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.4,
                child: SizedBox(
                  width: size.width,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: size.width * 0.85 * 0.70,
                              child: TextField(
                                obscureText: !showPassword,
                                controller: passwordController,
                                decoration: const InputDecoration.collapsed(
                                  hintText: 'Password',
                                ),
                              ),
                            ),
                            IconButton(
                              splashRadius: 0.1,
                              iconSize: 20,
                              alignment: Alignment.center,
                              icon: !showPassword
                                  ? const Icon(Icons.remove_red_eye)
                                  : const Icon(Icons.password),
                              onPressed: changeShowPassword,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.5,
                // left: size.width * 0.1,
                child: SizedBox(
                  width: size.width,
                  // padding: EdgeInsets.all(10),
                  // margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isLogin ? 'Login' : 'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        debugPrint('tapped');
                        isLogin ? login() : signUp();
                      },
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: size.height * 0.08,
                // left: size.width * 0.1,
                child: SizedBox(
                  width: size.width,
                  // padding: EdgeInsets.all(10),
                  // margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
                    child: GestureDetector(
                      child: Container(
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            isLogin ? 'Sign Up' : 'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          isLogin = !isLogin;
                        });
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
