import 'package:take_a_break/take_a_break.dart';

class UserData{
  UserData({this.userCredentials, this.skills});
  ///[userCredentials] are the credentials an User might use to access their data
  final UserCredentials? userCredentials;

  ///[skills] contain answers to the questionnaire
  final Questionnaire? skills;
}