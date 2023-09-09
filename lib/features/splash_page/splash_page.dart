import 'package:empty_feature_folder/constants/constants.dart';
import 'package:flutter/material.dart';
import '../../routes/name_routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 3),
    ).then(
      (value) {
        Navigator.pushReplacementNamed(context, RouteName.signIn);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: AppColors.mainColor,
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          Icon(
            Icons.account_balance_wallet_sharp,
            size: 100,
            color: Colors.white,
          ),
          Text('My Bank App',style: TextStyle(color: Colors.white),),
            ],
          ),
        ));
  }
}
