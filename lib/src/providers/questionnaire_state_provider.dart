import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class QuestionnaireStateProvider extends StateNotifier<Questionnaire> {
  QuestionnaireStateProvider() : super(Questionnaire());

  ///[addTaskDone] adds a task that the user has prior experience in
  void addTaskDone(Task task) {
    final oldTasks = state.tasksDone ?? [];
    state.tasksDone=oldTasks..add(task);
    print("task to add is $task and state task is ${state.tasksDone}");
  }

  ///[removeTaskDone] removes a task that the user had previously marked
  void removeTaskDone(Task task) {
    final oldTasks = state.tasksDone ?? [];
    if(oldTasks.isNotEmpty){
      int matchingIndex=oldTasks.indexWhere((element) => element==task,);
      if(matchingIndex!=-1){
        oldTasks.removeAt(matchingIndex);
        state.tasksDone=oldTasks;
        print("task removed zt");
      }
      print(state.tasksDone);
    }
  }

  ///[updateDateOfBirth] updates date of birth
  void updateDateOfBirth(DateTime dob) {
    state.dateOfBirth = dob;
  }

  void resetDateOfBirth(){
    state.dateOfBirth=null;
  }

  ///[updateQA] sets true and false for respective questions
  void updateQA(Question question, bool? answer) {
    switch (question) {
      case Question.hasPhone:
        state.hasPhone = answer;
        break;
      case Question.usedMaps:
        state.hasUsedMaps = answer;
        break;
      case Question.canBringPhone:
        state.hasPhoneForJob = answer;
    }
  }
}

final questionnaireStateProvider = StateNotifierProvider.autoDispose<
    QuestionnaireStateProvider, Questionnaire>(
  (ref) {
    return QuestionnaireStateProvider();
  },
);
