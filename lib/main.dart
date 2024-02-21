import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
               if (snapshot.hasData) {
          return FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance.collection('users').doc(snapshot.data!.uid).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.done) {
                // Assuming 'authority' is a field in your user document
                final authority = userSnapshot.data!['authority'];
                switch (authority) {
                  case 0:
                    return adminNavbar();
                  case 1:
                    return cleanerNavbar();
                  default:
                    return Navbar();
                }
              }
              return CircularProgressIndicator(); // Show loading while fetching user data
            },
          );
        } else {

          return const AuthScreen();
        }
      },
    );

  }
}