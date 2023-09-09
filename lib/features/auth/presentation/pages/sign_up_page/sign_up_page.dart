import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../constants/constants.dart';
import '../../../../../routes/name_routes.dart';
import '../../bloc/auth_bloc.dart';
import '../../mixin/mixin.dart';
import '../../widgets/global_button.dart';
import '../../widgets/text_field_widget.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> with SignInPageMixin {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            foregroundColor: Colors.white,
            title: const Text('Sign In'),
            backgroundColor: AppColors.mainColor,
            elevation: 0,
          ),
          body: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 150, left: 20, right: 20),
                child: TextFieldWidget(
                  textEditingController: nameController,
                  hintText: 'Enter your name',
                  labelText: 'Name',
                  prefixIcon: const Icon(Icons.person),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFieldWidget(
                  textEditingController: emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  prefixIcon: const Icon(Icons.mail),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: TextFieldPasswordWidget(
                  textEditingController: passwordController,
                  hintTextController: 'Enter your Password',
                  labelTextController: 'Password',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: GlobalButton(
                    buttonName: 'Sign Up',
                    onTap: () {
                      if (emailController.text.isNotEmpty &&
                          passwordController.text.isNotEmpty &&
                          nameController.text.isNotEmpty) {
                        context.read<AuthBloc>().add(SignUpEmailEvent(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text,
                            ));
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Success!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  context.read<AuthBloc>().add(SignOutEvent());
                                  Navigator.pushNamed(
                                      context, RouteName.signIn);
                                },
                                child: const Text(
                                  'Back to Sign In Page',
                                  style: TextStyle(color: AppColors.mainColor),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }),
              ),
            ],
          ),
        );
      },
    );
  }
}
