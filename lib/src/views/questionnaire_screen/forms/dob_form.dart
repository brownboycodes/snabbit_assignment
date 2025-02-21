// Create a Form widget.
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class DobForm extends ConsumerStatefulWidget {
  const DobForm({super.key, required this.viewModel});

  ///[viewModel] contains the state and utility methods to update the state
  final QuestionnaireViewModel viewModel;

  @override
  DobFormState createState() {
    return DobFormState();
  }
}

class DobFormState extends ConsumerState<DobForm> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController dayController;
  late TextEditingController monthController;
  late TextEditingController yearController;

  @override
  void initState() {
    dayController = TextEditingController();
    monthController = TextEditingController();
    yearController = TextEditingController();
    super.initState();
  }

  void _onFormUpdated(String value) {
    try{
      final day = int.parse(dayController.text);
      final month = int.parse(monthController.text);
      final year = int.parse(yearController.text);
      if ((day > 0 && day <= 31) &&
          (month > 0 && month <= 12) &&
          (year > 0 && year < 10000)) {
        widget.viewModel.updateDateOfBirth(DateTime(year, month, day));
      } else {
        widget.viewModel.resetDob();
      }
    }catch(error){
      widget.viewModel.resetDob();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          QuestionnaireScreenConstants.dob,
          style: TextStyle(
              color: Color(0xFF101840),
              fontSize: 13,
              letterSpacing: -0.24,
              fontWeight: FontWeight.w600),
        ),
        const SizedBox(
          height: 16,
        ),
        Form(
          key: _formKey,
          child: Wrap(
            // crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              SizedBox(
                width: 78,
                child: TextFormField(
                  controller: dayController,
                  scrollPadding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom + 13 * 4),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                  onChanged: _onFormUpdated,
                  onTapOutside: (event) {
                    if (FocusManager.instance.primaryFocus != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "DD",
                    counter: const SizedBox(),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFD8DADC)),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  style: TextStyle(
                      color: Color(0xFF371382),
                      fontSize: 13,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 78,
                child: TextFormField(
                  controller: monthController,
                  scrollPadding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom + 13 * 4),
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  textAlign: TextAlign.center,
                 onChanged: _onFormUpdated,
                  onTapOutside: (event) {
                    if (FocusManager.instance.primaryFocus != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  decoration: InputDecoration(
                      hintText: "MM", counter: const SizedBox()),
                  style: TextStyle(
                      color: Color(0xFF371382),
                      fontSize: 13,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w500),
                ),
              ),
              SizedBox(
                width: 78,
                child: TextFormField(
                  controller: yearController,
                  scrollPadding: EdgeInsets.only(
                      bottom:
                          MediaQuery.of(context).viewInsets.bottom + 13 * 4),
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  textAlign: TextAlign.center,
                  onTapOutside: (event) {
                    if (FocusManager.instance.primaryFocus != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  onChanged: _onFormUpdated,
                  decoration: InputDecoration(
                      hintText: "YYYY", counter: const SizedBox()),
                  style: TextStyle(
                      color: Color(0xFF371382),
                      fontSize: 13,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
