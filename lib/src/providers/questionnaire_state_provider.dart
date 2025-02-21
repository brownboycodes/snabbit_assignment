import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class QuestionnaireStateProvider extends StateNotifier<Questionnaire> {
  QuestionnaireStateProvider() : super(Questionnaire());

  /// Adds a task
  void addTaskDone(Task task) {
    final oldTasks = List<Task>.from(state.tasksDone ?? []);
    oldTasks.add(task);
    state = state.copyWith(
        tasksDone: oldTasks,
        dateOfBirth: state.dateOfBirth,
        hasPhoneForJob: state.hasPhoneForJob,
        hasUsedMaps: state.hasUsedMaps,
        hasPhone: state.hasPhone);
  }

  /// Removes a task
  void removeTaskDone(Task task) {
    final oldTasks = List<Task>.from(state.tasksDone ?? []);
    oldTasks.remove(task);
    state = state.copyWith(
        tasksDone: oldTasks,
        dateOfBirth: state.dateOfBirth,
        hasPhoneForJob: state.hasPhoneForJob,
        hasUsedMaps: state.hasUsedMaps,
        hasPhone: state.hasPhone);
  }

  /// Updates date of birth
  void updateDateOfBirth(DateTime dob) {
    state = state.copyWith(
        dateOfBirth: dob,
        hasPhone: state.hasPhone,
        hasPhoneForJob: state.hasPhoneForJob,
        hasUsedMaps: state.hasUsedMaps,
        tasksDone: state.tasksDone);
  }

  /// Resets date of birth
  void resetDateOfBirth() {
    state = state.copyWith(
        dateOfBirth: null,
        hasPhone: state.hasPhone,
        hasPhoneForJob: state.hasPhoneForJob,
        hasUsedMaps: state.hasUsedMaps,
        tasksDone: state.tasksDone);
  }

  /// Updates answers to questions
  void updateQA(Question question, bool? answer) {
    switch (question) {
      case Question.hasPhone:
        state = state.copyWith(
            hasPhone: answer,
            dateOfBirth: state.dateOfBirth,
            hasPhoneForJob: state.hasPhoneForJob,
            hasUsedMaps: state.hasUsedMaps,
            tasksDone: state.tasksDone);
        break;
      case Question.usedMaps:
        state = state.copyWith(
            hasUsedMaps: answer,
            dateOfBirth: state.dateOfBirth,
            hasPhoneForJob: state.hasPhoneForJob,
            hasPhone: state.hasPhone,
            tasksDone: state.tasksDone);
        break;
      case Question.canBringPhone:
        state = state.copyWith(
            hasPhoneForJob: answer,
            dateOfBirth: state.dateOfBirth,
            hasPhone: state.hasPhone,
            hasUsedMaps: state.hasUsedMaps,
            tasksDone: state.tasksDone);
        break;
    }
  }
}

final questionnaireStateProvider = StateNotifierProvider.autoDispose<
    QuestionnaireStateProvider, Questionnaire>(
  (ref) {
    return QuestionnaireStateProvider();
  },
);
