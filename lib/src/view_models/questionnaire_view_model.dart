import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';
import 'dart:math';


class QuestionnaireViewModel {
  QuestionnaireViewModel({required this.ref});

  ///[ref] which contains the state
  final WidgetRef ref;

  Questionnaire get state => ref.watch(questionnaireStateProvider);

  ///[updateQA] sets true and false for respective questions
  void updateQA(Question question, bool? answer) {
    ref.read(questionnaireStateProvider.notifier).updateQA(question, answer);
  }

  int getFilledFormCount() {
    int count = 0;
    if (state.tasksDone?.isNotEmpty == true) {
      count++;
    }
    if (state.hasPhone != null) {
      count++;
    }
    if (state.hasPhoneForJob != null) {
      count++;
    }
    if (state.hasUsedMaps != null) {
      count++;
    }
    if (state.dateOfBirth != null) {
      count++;
    }

    return count;
  }

  bool validateForm() {
    return getFilledFormCount() == 5;
  }

  Duration generateRandomDuration() {
  final random = Random();
  final seconds = random.nextInt(600 - 10 + 1) + 10;
  return Duration(seconds: seconds);
}
}

extension TasksDoneFormViewModel on QuestionnaireViewModel {
  bool isTaskAdded(Task task) {
    return state.tasksDone?.contains(task) == true;
  }

  void onChanged(bool? value, Task task,{Function(Task)? onAdd,Function(Task)? onRemove}) {
    if (value == true) {
      addTaskDone(task);
      if(onAdd!=null){
        onAdd(task);
      }
    } else if (value == false) {
      if (isTaskAdded(task)) {
        removeTaskDone(task);
        if(onRemove!=null){
          onRemove(task);
        }
      }
    }
  }

  ///[addTaskDone] adds a task that the user has prior experience in
  void addTaskDone(Task task) {
    ref.read(questionnaireStateProvider.notifier).addTaskDone(task);
  }

  ///[removeTaskDone] removes a task that the user had previously marked
  void removeTaskDone(Task task) {
    ref.read(questionnaireStateProvider.notifier).removeTaskDone(task);
  }
}

extension DobViewModel on QuestionnaireViewModel {
  ///[updateDateOfBirth] updates date of birth
  void updateDateOfBirth(DateTime dob) {
    ref.read(questionnaireStateProvider.notifier).updateDateOfBirth(dob);
  }

  void resetDob() {
    if (state.dateOfBirth != null) {
      ref.read(questionnaireStateProvider.notifier).resetDateOfBirth();
    }
  }
}
