import 'package:flutter/material.dart';
import 'package:take_a_break/take_a_break.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.sharedPreferencesService});

  ///using dependency injection
  final SharedPreferencesService sharedPreferencesService;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CheckboxHelperUtils {
  final _formKey = GlobalKey<FormState>();
  bool _canProceed = false;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool _hasReferral = false;
  bool pageIsLoading = false;

  @override
  void initState() {
    usernameController = TextEditingController();
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 74.0, left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LoginScreenConstants.title,
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.24,
                    color: Color(0xFF101840)),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 50,
                child: TextFormField(
                    controller: usernameController,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the username';
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      if (FocusManager.instance.primaryFocus != null) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      }
                    },
                    onChanged: _onTextFormChanged,
                    decoration: InputDecoration(
                        hintText: LoginScreenConstants.usernameHint,
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 16),
                        counter: const SizedBox()),
                    style: TextStyle(
                        color: Color(0xFF101840),
                        fontSize: 13,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500)),
              ),
              const SizedBox(
                height: 16,
              ),
              Container(
                height: 50,
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  //following the design provided
                  obscureText: true,
                  obscuringCharacter: '●',
                  maxLength: 24,
                  textAlign: TextAlign.start,
                  validator: (value) {
                    if (FocusManager.instance.primaryFocus?.hasFocus == true &&
                        (value == null || value.isEmpty)) {
                      return 'Please enter the password';
                    }
                    return null;
                  },
                  onChanged: _onTextFormChanged,
                  onTapOutside: (event) {
                    if (FocusManager.instance.primaryFocus != null) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  decoration: InputDecoration(
                      hintText: LoginScreenConstants.passwordHint,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      counter: const SizedBox()),
                  style: TextStyle(
                      color: Color(0xFF101840),
                      fontSize: passwordController.text.isNotEmpty ? 28 : 13,
                      letterSpacing: -0.24,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomCheckbox(
                      checkColor: Colors.white,
                      backgroundColor:
                          _hasReferral ? Color(0xFF371382) : Colors.transparent,
                      value: _hasReferral,
                      borderColor:
                          Color(_hasReferral ? 0xFF371382 : 0xFFD8DAE5),
                      isCircle: true,
                      onChanged: (bool? value) {
                        if (value != null) {
                          setState(() {
                            _hasReferral = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      LoginScreenConstants.referral,
                      style: TextStyle(
                          color: Color(0xFF525871),
                          fontSize: 13,
                          letterSpacing: -0.24,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                ),
              ),
              Spacer(),
              RichText(
                  text: TextSpan(
                      text: LoginScreenConstants.terms,
                      style: TextStyle(
                          color: Color(0xFF525871),
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.24),
                      children: [
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          child: Text(LoginScreenConstants.termsOfUse,
                              style: TextStyle(
                                  color: Color(0xFF525871),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.24,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF525871))),
                        )),
                    TextSpan(text: " & "),
                    WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: InkWell(
                          customBorder: Border(
                              bottom: BorderSide(color: Color(0xFF525871))),
                          child: Text(LoginScreenConstants.privacyPolicy,
                              style: TextStyle(
                                  color: Color(0xFF525871),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: -0.24,
                                  decoration: TextDecoration.underline,
                                  decorationColor: Color(0xFF525871))),
                        ))
                  ])),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: ConstrainedBox(
                  constraints:
                      BoxConstraints(maxHeight: 48, maxWidth: double.maxFinite),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                pageIsLoading = true;
                              });
                              final userCredentials = UserCredentials(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  hasReferralCode: _hasReferral);
                              final firestoreService = FirestoreService();
                              final doc = await firestoreService
                                  .createUser(userCredentials);
                              widget.sharedPreferencesService.savePath(doc.id);
                              if (mounted) {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => QuestionnaireScreen(
                                        doc: doc,
                                        firestoreService: firestoreService,
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
                              backgroundColor: _canProceed
                                  ? Color(0xFF371382)
                                  : Color(0xFFEAEAF1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              padding: EdgeInsets.symmetric(vertical: 14.5)),
                          child: pageIsLoading
                              ? SizedBox(
                                  height: 16,
                                  width: 16,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  ButtonTextConstants.continueForward,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0,
                                      color: _canProceed
                                          ? Colors.white
                                          : Color(0xFF8F95B2)),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onTextFormChanged(value) {
    if (value.isEmpty && _canProceed) {
      setState(() {
        _canProceed = false;
      });
    } else if (_canProceed == false) {
      setState(() {
        _canProceed = true;
      });
    }
  }
}
