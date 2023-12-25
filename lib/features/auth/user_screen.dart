// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common_widget/common_snackbar.dart';
import 'controller/auth_controller.dart';

class UserInformationScreen extends ConsumerStatefulWidget {
  const UserInformationScreen({super.key});

  static const routeName = '/userInfo';

  @override
  ConsumerState<UserInformationScreen> createState() =>
      _UserInformationScreenState();
}

class _UserInformationScreenState extends ConsumerState<UserInformationScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  void saveUserDataToFirebase() {
    String name = nameController.text.trim();
    String phoneNumber = phoneController.text.trim();
    String address = addressController.text.trim();

    if (name.isNotEmpty && phoneNumber.isNotEmpty) {
      ref.read(authControllerProvider).saveUserDataToFirebase(
            context: context,
            name: name,
            phoneNumber: phoneNumber.toString(),
            address: address,
          );
    } else {
      showsnackbar(context: context, msg: 'enter all fields');
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
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
                    'Fill in your details',
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
                          controller: nameController,
                          decoration: InputDecoration(
                            hintText: 'Name',
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
                        child: TextField(
                          controller: addressController,
                          decoration: InputDecoration(
                            hintText: 'HomeTown/City',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.5,
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
                          controller: phoneController,
                          decoration: InputDecoration(
                            hintText: 'Phone Number',
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: size.height * 0.6,
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
                            'Let\'s Go! ',
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
                        saveUserDataToFirebase();
                        // isLogin ? login() : signUp();
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
