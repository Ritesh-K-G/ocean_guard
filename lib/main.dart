import 'package:flutter/material.dart';
import 'package:ocean_guard/constants/color.dart';
import 'package:ocean_guard/features/authentication/MainAuthScreen.dart';
import 'package:ocean_guard/features/super_admin/admin_navbar.dart';
import 'package:ocean_guard/navbar.dart';
import 'package:ocean_guard/utils/widgets/ImagePicker/MultiImageProvider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'features/cleaner/cleaner_navbar.dart';
import 'firebase_options.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavbarIndexProvider()),
        ChangeNotifierProvider(create: (context) => AdminNavbarIndexProvider()),
        ChangeNotifierProvider(create: (context) => CleanerNavbarIndexProvider()),
        ChangeNotifierProvider(create: (context) => MultiImageProvider())
      ],
      child: MaterialApp(
        title: 'Ocean Guard',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.myBlue),
          useMaterial3: true,
        ),
        home: const AuthCheck(title: 'Ocean Guard'),
        debugShowCheckedModeBanner: false
      ),
    );
  }
}

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key, required this.title});
  final String title;

  @override
  State<AuthCheck> createState() => _AuthCheckState();
}

class _AuthCheckState extends State<AuthCheck> {
  @override
  Widget build(BuildContext context) {
    return const AuthScreen();
  }
}