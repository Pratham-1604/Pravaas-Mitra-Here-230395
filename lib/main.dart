import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:here/features/auth/auth_screen.dart';
import 'package:here/features/auth/controller/auth_controller.dart';
import 'package:here/features/auth/user_screen.dart';
import 'package:here/features/onboarding/onboarding_screen.dart';

import '/firebase_options.dart';

import 'common_widget/error.dart';
import 'common_widget/loader.dart';
import 'features/home_page/main_page.dart';

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
        OnboardingScreen.routeName:(context) => OnboardingScreen(),
        AuthScreen.routeName: (context) => AuthScreen(),
        HomePage.routeName: (context) => HomePage(),
        UserInformationScreen.routeName:(context) => UserInformationScreen(),
      },
      home: ref.watch(userDataAuthProvider).when(
            data: (data) =>
                data != null ? const HomePage() : const OnboardingScreen(),
                // const HomePage(),
            error: (error, stacktrace) {
              debugPrint(error.toString());
              return ErrorScreen(
                error: error.toString(),
              );
            },
            loading: () => const LoaderPage(),
          ),
    );
  }
}
