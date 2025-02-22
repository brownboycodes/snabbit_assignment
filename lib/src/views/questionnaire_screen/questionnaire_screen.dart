import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:take_a_break/take_a_break.dart';

class QuestionnaireScreen extends ConsumerStatefulWidget {
  const QuestionnaireScreen(
      {super.key, required this.doc, required this.firestoreService});

  final DocumentReference doc;

  //obtaining Firestore service via dependency injection
  final FirestoreService firestoreService;

  @override
  ConsumerState<QuestionnaireScreen> createState() =>
      _QuestionnaireScreenState();
}

class _QuestionnaireScreenState extends ConsumerState<QuestionnaireScreen> {
  late QuestionnaireViewModel viewModel;
  bool pageIsLoading = false;

  @override
  void initState() {
    super.initState();
    viewModel = QuestionnaireViewModel(ref: ref);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            padding: EdgeInsets.zero,
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: Color(0xFF404055), size: 24)),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                tween: Tween<double>(
                  begin: 0,
                  end: viewModel.getFilledFormCount().toDouble(),
                ),
                builder: (context, value, _) => LinearProgressIndicator(
                      value: value / 5,
                      color: Color(0xFF3030D6),
                      backgroundColor: Color(0xFFD8DAE5),
                      borderRadius: BorderRadius.circular(6),
                      minHeight: 6,
                    )),
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: EdgeInsets.all(16),
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
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
              ...Question.values.map(
                (e) => YesNoForm(
                  question: e,
                  viewModel: viewModel,
                ),
              ),
              DobForm(
                viewModel: viewModel,
              ),
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
                onPressed: () async {
                  if (viewModel.validateForm()) {
                    setState(() {
                      pageIsLoading = true;
                    });
                    final questionnaire = ref.read(questionnaireStateProvider);
                    widget.firestoreService
                        .updateQuestionnaire(widget.doc, questionnaire);
                    //instead of fetching th duration from an api I am generating one locally
                    final randomDuration = viewModel.generateRandomDuration();
                    final doc = await widget.doc.get();
                    if (doc.exists && mounted) {
                      Map<String, dynamic> json =
                          doc.data() as Map<String, dynamic>;
                      final userData = UserData.fromJson(json);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BreakScreen(
                              duration: randomDuration,
                              username:
                                  userData.userCredentials?.username ?? '',
                            ),
                          ));
                    } else {
                      setState(() {
                        pageIsLoading = false;
                      });
                    }
                  }
                },
                style: TextButton.styleFrom(
                    disabledBackgroundColor: Color(0xFFEAEAF1),
                    backgroundColor: viewModel.validateForm()
                        ? Color(0xFF371382)
                        : Color(0xFFEAEAF1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    padding: EdgeInsets.symmetric(vertical: 14.5)),
                child: pageIsLoading
                    ? SizedBox(
                        height: 16,
                        width: 16,
                        child: CircularProgressIndicator(color: Colors.white,),
                      )
                    : Text(
                        ButtonTextConstants.continueForward,
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0,
                            color: viewModel.validateForm()
                                ? Colors.white
                                : Color(0xFF8F95B2)),
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
