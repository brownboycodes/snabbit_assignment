import 'package:flutter/material.dart';
import 'package:take_a_break/take_a_break.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with CheckboxHelperUtils {
  final _formKey = GlobalKey<FormState>();
  bool _canProceed = false;
  late TextEditingController usernameController;
  late TextEditingController passwordController;
  bool _hasReferral=false;

  @override
  void initState() {
    usernameController=TextEditingController();
    passwordController=TextEditingController();
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
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                        counter: const SizedBox()),
                    style: TextStyle(
                        color: Color(0xFF371382),
                        fontSize: 13,
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: passwordController,
                  keyboardType: TextInputType.number,
                  //following the design provided
                  obscureText: true,
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
                      counter: const SizedBox()),
                  style: TextStyle(
                      color: Color(0xFF371382),
                      fontSize: 13,
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
                    SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        checkColor: Colors.white,
                        fillColor: WidgetStateProperty.resolveWith(getColor),
                        value: _hasReferral,
                        side: BorderSide(color: Color(0xFFD8DAE5), width: 2),
                        shape: CircleBorder(),
                        onChanged: (bool? value) {
                          if(value!=null){
                            setState(() {
                            _hasReferral=value;
                          });
                          }
                        },
                      ),
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
                        alignment: PlaceholderAlignment.bottom,
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
                        alignment: PlaceholderAlignment.bottom,
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // _formKey.currentState?.save();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => QuestionnaireScreen(),
                                  ));
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
                          child: Text(
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
