import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class YesNoForm extends ConsumerStatefulWidget {
  const YesNoForm({super.key, required this.question,required this.viewModel});

  ///[question] is the [Question] object for which answers will be updated
  final Question question;

  ///[viewModel] contains the state and utility methods to update the state
  final QuestionnaireViewModel viewModel;

  @override
  ConsumerState<YesNoForm> createState() => _YesNoFormState();
}

class _YesNoFormState extends ConsumerState<YesNoForm>
    with CheckboxHelperUtils {
  bool _isYesSelected = false;
  bool _isNoSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.question.question,
          style: TextStyle(
              color: Color(0xFF101840),
              fontSize: 13,
              letterSpacing: -0.24,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    checkColor: Colors.white,
                    fillColor: WidgetStateProperty.resolveWith(getColor),
                    value: _isYesSelected && !_isNoSelected,
                    side: BorderSide(
                        color: Color(_isYesSelected && !_isNoSelected
                            ? 0xFF371382
                            : 0xFFD8DAE5),
                        width: 2),
                    shape: CircleBorder(),
                    onChanged: (bool? value) {
                      if (value != null && value != _isYesSelected) {
                        setState(() {
                          _isYesSelected = value;
                        });
                        widget.viewModel.updateQA(widget.question, true);
                      }
                    },
                  ),
                ),
                const SizedBox(
                  width: 4,
                ),
                Text(
                  QuestionnaireScreenConstants.yes,
                  style: TextStyle(
                      color: Color(0xFF525871),
                      fontSize: 13,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
            const SizedBox(width: 20,),
            Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: Checkbox(
                checkColor: Colors.white,
                fillColor: WidgetStateProperty.resolveWith(getColor),
                value: _isNoSelected && !_isYesSelected,
                side: BorderSide(
                    color: Color(_isNoSelected && !_isYesSelected
                        ? 0xFF371382
                        : 0xFFD8DAE5),
                    width: 2),
                shape: CircleBorder(),
                onChanged: (bool? value) {
                  if (value != null && value != _isNoSelected) {
                    setState(() {
                      _isNoSelected = value;
                    });
                    widget.viewModel.updateQA(widget.question, false);
                    print("jnllnlnlkne");
                  }
                  print("value is $value");
                },
              ),
            ),
            const SizedBox(
              width: 4,
            ),
            Text(
              QuestionnaireScreenConstants.no,
              style: TextStyle(
                  color: Color(0xFF525871),
                  fontSize: 13,
                  letterSpacing: -0.24,
                  fontWeight: FontWeight.w500),
            )
          ],
        ),
          ],
        ),

        const SizedBox(
          height: 32,
        ),
      ],
    );
  }
}
