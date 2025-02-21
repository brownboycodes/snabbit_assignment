import 'package:take_a_break/take_a_break.dart';

enum Task {
  cuttingVegetables(TaskConstants.cuttingVegetables),
  sweeping(TaskConstants.sweeping),
  mopping(TaskConstants.mopping),
  cleaningBathrooms(TaskConstants.cleaningBathrooms),
  laundry(TaskConstants.laundry),
  washingDishes(TaskConstants.washingDishes),
  none(TaskConstants.none);

  ///[label]  corresponding string value for each task
  final String label;
  const Task(this.label);

  Task fromString(String? label) {
    switch (label) {
      case TaskConstants.cuttingVegetables:
        return Task.cuttingVegetables;
      case TaskConstants.sweeping:
        return Task.sweeping;
      case TaskConstants.mopping:
        return Task.mopping;
      case TaskConstants.cleaningBathrooms:
        return Task.cleaningBathrooms;
      case TaskConstants.laundry:
        return Task.laundry;
      case TaskConstants.washingDishes:
        return Task.washingDishes;
      default:
        return Task.none;
    }
  }
}
