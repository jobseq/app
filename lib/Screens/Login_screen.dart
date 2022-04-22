import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job/Bloc/LoginBloc.dart';
import 'package:job/Network/authenticating_client.dart';
import 'package:job/Screens/Registration_screen.dart';
import 'package:job/Utils/Themes.dart';
import 'package:http/http.dart' as http;


class LoginScreen extends StatelessWidget {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final bloc = LoginBloc(Authenticator(http.Client()));
  LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/Login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (() {
          FocusScope.of(context).requestFocus(FocusNode());
        }),
        child: BlocBuilder<LoginBloc, LoginState>(
          bloc: bloc,
          builder: (ctx, state) {
            if (state is AttemptState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is ErrorState) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }
            
            if (state is LoggedInState) {
              Navigator.of(context).pushNamedAndRemoveUntil(newRouteName, (route) => false)
              return const Center(
                child: Text('Logged in'),
              );
            }
            return Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Job',
                        style: MainHeading1,
                      ),
                      Text(
                        'Search',
                        style: MainHeading2,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 62,
                  ),
                  TextField(
                    controller: _usernameController,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'Enter username',
                      fillColor: Color(0xffE5E5E5),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    scrollPadding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      hintText: 'Enter password',
                      fillColor: Color(0xffE5E5E5),
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 3),
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 36,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (bloc.state is NormalState) {
                        bloc.login(_usernameController.text, _passwordController.text);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: button_gradient,
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        child: const Center(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Nunito',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New to OnionChat? ',
                        style: TextStyle(
                          fontFamily: MainFontFamily,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff626262),
                        ),
                      ),
                      GestureDetector(
                        child: const Text(
                          'Sign Up here',
                          style: TextStyle(
                            fontFamily: MainFontFamily,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: Color(0xff4A4A4A),
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(RegistrationScreen.routeName);
                        },
                      )
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
