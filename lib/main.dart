import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

void main() {
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
    letterSpacing: -0.24
  ),
  contentPadding: EdgeInsets.symmetric(vertical: 15,horizontal: 16),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFD8DADC)),borderRadius: BorderRadius.circular(10)
  ),
  outlineBorder: BorderSide(color: Color(0xFFD8DADC)),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFF371382),width: 1),borderRadius: BorderRadius.circular(10)
  ),
  disabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xFFD8DADC)),borderRadius: BorderRadius.circular(10)
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.redAccent),borderRadius: BorderRadius.circular(10)
  ),
),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            disabledBackgroundColor: Color(0xFFEAEAF1),
          )
      ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
      ),
    );
  }
}
