// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:here/features/auth/auth_screen.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static const routeName = '/onboarding';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Center(
              child: Image.asset(
                'assets/mountain.jpg',
                fit: BoxFit.cover,
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
              bottom: size.height * 0.25,
              left: size.width * 0.1,
              child: SizedBox(
                width: size.width,
                child: Text(
                  'Plan your',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.20,
              left: size.width * 0.1,
              child: SizedBox(
                width: size.width,
                child: Text(
                  'Luxurious',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.15,
              left: size.width * 0.1,
              child: SizedBox(
                width: size.width,
                child: Text(
                  'Vacation',
                  style: TextStyle(
                    fontSize: 36,
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
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
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Explore',
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
                      Navigator.of(context).popAndPushNamed(
                        AuthScreen.routeName,
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
