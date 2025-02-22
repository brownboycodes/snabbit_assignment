import 'package:flutter/material.dart';
import 'package:take_a_break/src/services/shared_preferences_service.dart';
import 'package:take_a_break/take_a_break.dart';

class GuardScreen extends StatefulWidget {
  const GuardScreen({super.key});

  @override
  State<GuardScreen> createState() => _GuardScreenState();
}

class _GuardScreenState extends State<GuardScreen> {
  late Future<String> retrieveStoredId;
  late SharedPreferencesService sharedPreferencesService;
  late FirestoreService firestoreService;

  @override
  void initState() {
    super.initState();
    initializeDependencies();
  }

  void initializeDependencies() {
    sharedPreferencesService = SharedPreferencesService();
    retrieveStoredId = sharedPreferencesService.checkStorage();
    firestoreService= FirestoreService();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
        future: retrieveStoredId,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return LoginScreen(sharedPreferencesService: sharedPreferencesService,);
            } else {
              final doc = firestoreService.getDocument(snapshot.data ?? '');

              return QuestionnaireScreen(
                  doc: doc, firestoreService: firestoreService);
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Something went wrong"),
            );
          } else {
           return Center(
              child: SizedBox(
                height: 64,
                width: 64,
                child: CircularProgressIndicator(),
              ),
            );
          }
        },
      );
  }
}
