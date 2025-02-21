import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class QuestionnaireScreen extends ConsumerStatefulWidget {
  const QuestionnaireScreen({super.key});

  @override
  ConsumerState<QuestionnaireScreen> createState() =>
      _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends ConsumerState<QuestionnaireScreen> {
  late QuestionnaireViewModel viewModel;

  @override
  void initState() {
    super.initState();
    viewModel = QuestionnaireViewModel(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }
//
// class QuestionnaireScreen extends ConsumerWidget {
//   const QuestionnaireScreen({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LinearProgressIndicator(
                value: viewModel.getFilledFormCount() / 5,
                color: Color(0xFF3030D6),
                backgroundColor: Color(0xFFD8DAE5),
                borderRadius: BorderRadius.circular(6),
                minHeight: 6,
              ),
              const SizedBox(
                height: 32,
              ),
              Text(
                QuestionnaireScreenConstants.title,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.24,
                    color: Color(0xFF101840)),
              ),
              Text(
                QuestionnaireScreenConstants.subtitle,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.24,
                    color: Color(0xFF525871)),
              ),
              const SizedBox(
                height: 24,
              ),
              TasksDoneForm(
                viewModel: viewModel,
              ),
              // YesNoForm(question: Question.hasPhone),
              ...Question.values.map(
                (e) => YesNoForm(
                  question: e,
                  viewModel: viewModel,
                ),
              ),
              DobForm(
                viewModel: viewModel,
              ),
              // Spacer(),
              //             Expanded(child: SizedBox()),
      //         Container(
      //   margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      //   constraints: BoxConstraints(maxHeight: 48, maxWidth: double.maxFinite),
      //   child: Row(
      //     children: [
      //       Expanded(
      //         child: TextButton(
      //           onPressed: () {
      //             if (viewModel.validateForm()) {
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => BreakScreen(),
      //                   ));
      //             }
      //           },
      //           style: TextButton.styleFrom(
      //               disabledBackgroundColor: Color(0xFFEAEAF1),
      //               backgroundColor: viewModel.validateForm()?Color(0xFF371382):Color(0xFFEAEAF1),
      //               shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(8)),
      //               padding: EdgeInsets.symmetric(vertical: 14.5)),
      //           child: Text(
      //             ButtonTextConstants.continueForward,
      //             style: TextStyle(
      //                 fontSize: 13,
      //                 fontWeight: FontWeight.w600,
      //                 letterSpacing: 0,
      //                 color:viewModel.validateForm()? Colors.white:Color(0xFF8F95B2)),
      //           ),
      //         ),
      //       ),
      //     ],
      //   ),
      // )
            ],
          ),
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        constraints: BoxConstraints(maxHeight: 48, maxWidth: double.maxFinite),
        child: Row(
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  if (viewModel.validateForm()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => BreakScreen(),
                        ));
                  }
                },
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Color(0xFFEAEAF1),
                    backgroundColor: viewModel.validateForm()?Color(0xFF371382):Color(0xFFEAEAF1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 14.5)),
                child: Text(
                  ButtonTextConstants.continueForward,
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0,
                      color:viewModel.validateForm()? Colors.white:Color(0xFF8F95B2)),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
