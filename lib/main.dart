import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/firebase_options.dart';
import 'package:take_a_break/take_a_break.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Take A Break',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        bottomSheetTheme: BottomSheetThemeData(
            dragHandleColor: Color(0xFFD1D1D1), dragHandleSize: Size(36, 4)),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Color(0xFFD8DAE5),
              letterSpacing: -0.24),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD8DADC)),
              borderRadius: BorderRadius.circular(10)),
          outlineBorder: BorderSide(color: Color(0xFFD8DADC)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF371382), width: 1),
              borderRadius: BorderRadius.circular(10)),
          disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFD8DADC)),
              borderRadius: BorderRadius.circular(10)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.redAccent),
              borderRadius: BorderRadius.circular(10)),
        ),
        textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
          disabledBackgroundColor: Color(0xFFEAEAF1),
        )),
        useMaterial3: true,
      ),
      home: GuardScreen(),
    );
  }
}
