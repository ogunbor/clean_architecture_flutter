import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:clean_architecture/presentation/Welcome/Welcome_page.dart';
import 'package:clean_architecture/presentation/sign_in/sign_in_state.dart';

import 'sign_in_bloc.dart';
import 'sign_in_event.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SignInBloc()..add(InitEvent()),
      child: Builder(builder: (context) => _buildPage(context)),
    );
  }

  Widget _buildPage(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final bloc = BlocProvider.of<SignInBloc>(context);

    return Scaffold(
      body: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          if (state.isLogedIn == true) {
            Future.delayed(const Duration(milliseconds: 300), () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (ctx) =>
                      WelcomeScreen(name: state.email ?? "email@test.com")));
            });
          }
          return Center(
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Sign In",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            FontAwesomeIcons.facebook,
                            color: Colors.blue,
                            size: 40.0,
                          ),
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.red,
                            size: 40.0,
                          ),
                          Icon(
                            FontAwesomeIcons.linkedin,
                            color: Colors.blueAccent,
                            size: 40.0,
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12.0,
                      ),
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (email) {
                          if (email == null ||
                              !email.contains("@") ||
                              !email.contains(".")) {
                            return "Please enter valid email address!";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: "Email",
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (password) {
                          if (password == null || password.length < 6) {
                            return "Please enter another password";
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: "Password",
                          errorStyle: TextStyle(
                              color: Colors.red,
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      const Text(
                        "Forgot Your Password",
                        style: TextStyle(color: Colors.grey, fontSize: 18.0),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        onTap: () {
                          if (formKey.currentState?.validate() ?? false) {
                            formKey.currentState?.save();
                            bloc.add(SignInTriggerEvent(
                                email: emailController.text));
                          }
                        },
                        child: Container(
                          height: 50.0,
                          width: 180.0,
                          decoration: const BoxDecoration(
                              color: Colors.deepOrange,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(22.0))),
                          child: const Center(
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
