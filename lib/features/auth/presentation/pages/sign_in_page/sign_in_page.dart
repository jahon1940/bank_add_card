import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../constants/constants.dart';
import '../../../../../routes/name_routes.dart';
import '../../../../main/presentation/pages/main_page/main_page.dart';
import '../../bloc/auth_bloc.dart';
import '../../mixin/mixin.dart';
import '../../widgets/global_button.dart';
import '../../widgets/text_field_widget.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> with SignInPageMixin {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return const MainPage();
              } else {
                return Scaffold(
                  resizeToAvoidBottomInset: true,
                  appBar: AppBar(
                    foregroundColor: Colors.white,
                    leading: Container(),
                    backgroundColor: AppColors.mainColor,
                    centerTitle: true,
                    title: const Text('My Bank App'),
                    elevation: 0,
                  ),
                  body: ListView(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 50),
                        child: Icon(
                          Icons.account_balance_wallet_sharp,
                          size: 100,
                          color: AppColors.mainColor,
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 50, left: 20, right: 20),
                        child: TextFieldWidget(
                          textEditingController: emailController,
                          hintText: 'Enter your email',
                          labelText: 'Email',
                          prefixIcon: const Icon(Icons.mail),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: TextFieldPasswordWidget(
                          textEditingController: passwordController,
                          hintTextController: 'Enter your Password',
                          labelTextController: 'Password',
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 30, left: 20, right: 20),
                        child: GlobalButton(
                            buttonName: 'Sign In',
                            onTap: () {
                              if (emailController.text.isNotEmpty &&
                                  passwordController.text.isNotEmpty) {
                                context.read<AuthBloc>().add(SignInEmailEvent(
                                    email: emailController.text,
                                    password: passwordController.text));

                              }
                            }),
                      ),
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Text(
                            '- OR Continue with -',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF575757),
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            context.read<AuthBloc>().add(SignUpGoogleEvent());
                          },
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: AppColors.mainColor.withOpacity(0.1),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: SvgPicture.asset(AppImages.google),
                            ),

                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 110, right: 20),
                        child: RichText(
                            text: TextSpan(
                                text: "Create An Account ",
                                style: const TextStyle(color: Colors.black),
                                children: [
                              TextSpan(
                                text: ' Sign Up',
                                style: const TextStyle(
                                  color: AppColors.mainColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.pushNamed(
                                        context, RouteName.signUp);
                                  },
                              ),
                            ])),
                      )
                    ],
                  ),
                );
              }
            });
      },
    );
  }
}
