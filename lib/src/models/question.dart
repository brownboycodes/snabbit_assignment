import 'package:take_a_break/src/constants/questionnaire_screen_constants.dart';

enum Question{
  hasPhone(QuestionnaireScreenConstants.hasPhone),
  canBringPhone(QuestionnaireScreenConstants.canBringPhone),
  usedMaps(QuestionnaireScreenConstants.usedMaps);
  ///[question] associated with each value
  final String question;
  const Question(this.question);

}