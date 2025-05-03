import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loginapplication/screens/splash_screen.dart';
import 'package:loginapplication/screens/recipe_input_screen.dart'; // Import the RecipeInputScreen
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SplashScreen(), // Show splash screen initially
      routes: {
        '/recipe-generator': (context) =>
            RecipeInputScreen(), // Add a route for RecipeInputScreen
      },
    );
  }
}
