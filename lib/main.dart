import 'package:empty_feature_folder/routes/app_routes.dart';
import 'package:empty_feature_folder/routes/name_routes.dart';
import 'package:empty_feature_folder/services/notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/main/presentation/bloc/main_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
        BlocProvider<MainBloc>(create: (BuildContext context) => MainBloc()),
      ],
      child: KeyboardDismisser(
        child: MaterialApp(
          theme: ThemeData(useMaterial3: true),
          initialRoute: RouteName.splash,
          onGenerateRoute: AppRoutes.generateRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
