import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/Bloc/JobListBloc.dart';
import 'package:job/Screens/Login_screen.dart';
import 'package:job/Screens/Registration_screen.dart';

import 'Repository/JobRepository.dart';
import 'Screens/Job_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: '',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: LoginScreen.routeName,
        onGenerateRoute: (settings) {
          switch(settings.name) {
            case LoginScreen.routeName:
              return MaterialPageRoute(builder: (_) => LoginScreen());
            case RegistrationScreen.routeName:
              return MaterialPageRoute(builder: (_) => RegistrationScreen());
            case JobList.routeName:
              final JobListArguments args = settings.arguments as JobListArguments;
              return MaterialPageRoute(builder: (_) => JobList(args));
          }
    });
  }
}
