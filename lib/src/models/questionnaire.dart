import 'package:take_a_break/take_a_break.dart';

class Questionnaire {
  Questionnaire(
      {this.tasksDone,
      this.hasPhone,
      this.hasPhoneForJob,
      this.hasUsedMaps,
      this.dateOfBirth});

  ///[tasksDone] are tasks the user the prior experience in
  List<Task>? tasksDone;

  ///[hasPhone] indicates if user owns a smartphone
  bool? hasPhone;

  ///[hasPhoneForJob] indicates if user will be able to bring the smartphone to their job
  bool? hasPhoneForJob;

  ///[hasUsedMaps] indicates if user has prior experience in using Google Maps
  bool? hasUsedMaps;

  ///[dateOfBirth] contains birthday of the user
  DateTime? dateOfBirth;

  Questionnaire copyWith({
    List<Task>? tasksDone,
    DateTime? dateOfBirth,
    bool? hasPhone,
    bool? hasUsedMaps,
    bool? hasPhoneForJob,
  }) {
    return Questionnaire(
      tasksDone: tasksDone ?? this.tasksDone,
      dateOfBirth: dateOfBirth,
      hasPhone: hasPhone,
      hasUsedMaps: hasUsedMaps,
      hasPhoneForJob: hasPhoneForJob,
    );
  }
}
