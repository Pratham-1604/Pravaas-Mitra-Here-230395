import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:here/features/skeleton/test_home_page.dart';

import 'features/auth/auth_screen.dart';
import 'features/auth/controller/auth_controller.dart';
import 'features/auth/user_screen.dart';
import 'features/onboarding/onboarding_screen.dart';

import '/firebase_options.dart';

import 'common_widget/error.dart';
import 'common_widget/loader.dart';
import 'features/skeleton/skeleton.dart';

import 'package:here_sdk/core.dart';
import 'package:here_sdk/core.engine.dart';
import 'package:here_sdk/core.errors.dart';

void _initializeHERESDK() async {
  // Needs to be called before accessing SDKOptions to load necessary libraries.
  SdkContext.init(IsolateOrigin.main);

  // Set your credentials for the HERE SDK.
  String accessKeyId = "mbmLosDSem7_ljHgub7Qrg";
  String accessKeySecret =
      "I5_O9L9V0ThyE-n9evGsBELz7TGKmm2a97EiJp-joZNUS_6RjRKtPffZtR8gMtE_VcZh4iJSPO0s5GmVrP6r-w";
  SDKOptions sdkOptions =
      SDKOptions.withAccessKeySecret(accessKeyId, accessKeySecret);

  try {
    await SDKNativeEngine.makeSharedInstance(sdkOptions);
  } on InstantiationException {
    throw Exception("Failed to initialize the HERE SDK.");
  }
}

void _disposeHERESDK() async {
  // Free HERE SDK resources before the application shuts down.
  await SDKNativeEngine.sharedInstance?.dispose();
  SdkContext.release();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  _initializeHERESDK();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        OnboardingScreen.routeName: (context) => OnboardingScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        Skeleton.routeName: (context) => Skeleton(),
        TestHomePage.routeName: (context) => TestHomePage(),
        UserInformationScreen.routeName: (context) => UserInformationScreen(),
      },
      home: ref.watch(userDataAuthProvider).when(
            data: (data) {
              debugPrint("hello");
              debugPrint(data.toString());
              // return data != null
              //     ? const Skeleton()
              //     : const OnboardingScreen();
              return const Skeleton();
              // return const TestHomePage();
            },
            error: (error, stacktrace) {
              debugPrint(stacktrace.toString());
              debugPrint(error.toString());
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoaderPage(),
          ),
      // home: const TestHomePage(),
      // home: const HomePage(),
    );
  }
}
