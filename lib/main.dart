import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'core/service/easy_loading_service.dart';
import 'firebase_options.dart';
import 'core/routes/routes_generator.dart';
import 'core/routes/pages_route.dart';
import 'core/service/bloc_observer.dart';
import 'core/utils/app_colors.dart';
import 'core/di/injectable_initializer.dart';
import 'package:bloc/bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configure Dependency Injection
  configureDependencies();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  ConfigLoading();
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easacc',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primaryColor),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      onGenerateRoute: RoutesGenerator.onGenerateRoute,
      initialRoute: PagesRoute.login,
    );
  }
}
