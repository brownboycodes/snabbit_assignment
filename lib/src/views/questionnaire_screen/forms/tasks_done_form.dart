import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class TasksDoneForm extends ConsumerStatefulWidget {
  const TasksDoneForm({super.key, required this.viewModel});

  ///[viewModel] contains the state and utility methods to update the state
  final QuestionnaireViewModel viewModel;

  @override
  ConsumerState<TasksDoneForm> createState() => _TasksDoneFormState();
}

class _TasksDoneFormState extends ConsumerState<TasksDoneForm>
    with CheckboxHelperUtils {
  List<Task> selectedTasks = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          QuestionnaireScreenConstants.tasksDoneBefore,
          style: TextStyle(
              color: Color(0xFF101840),
              fontSize: 13,
              letterSpacing: -0.24,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        GridView.count(
            primary: true,
            crossAxisSpacing: 0,
            mainAxisSpacing: 8,
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 157 / 24,
            children: Task.values
                .map(
                  (task) {
                    bool isTaskAdded = widget.viewModel.isTaskAdded(task);
                return Row(
                  children: [
                    CustomCheckbox(
                        checkColor: Colors.white,
                        value: isTaskAdded,
                        isCircle: false,
                        // fillColor:
                        // WidgetStateProperty.resolveWith(getColor),
                        // value: _isNoSelected && !_isYesSelected,
                        // side: BorderSide(
                        //     color: Color(0xFFD8DAE5), width: 2),
                        backgroundColor: isTaskAdded?Color(0xFF371382):Colors.transparent,
                        borderColor: isTaskAdded
                            ? Color(0xFF371382)
                            : Color(0xFFD8DAE5),
                        onChanged: (value) =>
                            widget.viewModel.onChanged(
                              value,
                              task,
                              onAdd: (task) {
                                selectedTasks.add(task);
                                setState(() {});
                              },
                              onRemove: (task) {
                                selectedTasks.remove(task);
                                setState(() {});
                              },
                            )),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      task.label,
                      style: TextStyle(
                          color: Color(0xFF525871),
                          fontSize: 13,
                          letterSpacing: -0.24,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                );
              },
                )
                .toList()),
        const SizedBox(
          height: 24,
        )
      ],
    );
  }
}
