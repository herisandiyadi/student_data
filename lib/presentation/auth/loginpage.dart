import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_student_app/common/theme.dart';
import 'package:test_student_app/presentation/cubit/auth/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  static const path = '/loginpage';
  static const routeName = 'loginpage';

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController userC = TextEditingController();
  TextEditingController passwdC = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool validate() {
    if (userC.text.isEmpty || passwdC.text.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    userC.dispose();
    passwdC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: greyColor),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 35),
              child: Form(
                key: formKey,
                child: SizedBox(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: userC,
                        style: dBlueTextStyle.copyWith(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: 'USERNAME',
                          hintStyle: greyTextStyle.copyWith(fontSize: 20),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),
                      TextFormField(
                        controller: passwdC,
                        obscureText: true,
                        style: dBlueTextStyle.copyWith(fontSize: 20),
                        decoration: InputDecoration(
                          hintText: 'PASSWORD',
                          hintStyle: greyTextStyle.copyWith(fontSize: 20),
                          prefixIcon: const Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 55,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24),
                                side: const BorderSide(
                                  color: redColor,
                                ),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all(redColor),
                          ),
                          onPressed: () async {
                            if (validate()) {
                              context
                                  .read<AuthCubit>()
                                  .login(userC.text, passwdC.text);
                            } else {
                              const snackBar = SnackBar(
                                backgroundColor: redColor,
                                content:
                                    Text('Username dan password harus diisi'),
                                duration: Duration(seconds: 2),
                              );

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          },
                          child: BlocListener<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthFailed) {
                                const snackBar = SnackBar(
                                  content: Text(
                                      'Username atau password tidak valid'),
                                  duration: Duration(seconds: 2),
                                  backgroundColor: redColor,
                                );

                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                              if (state is AuthSuccess) {
                                context.replaceNamed('homepage');
                              }
                            },
                            child: Text(
                              'LOGIN',
                              style: whiteTextStyle.copyWith(
                                  fontSize: 16, fontWeight: semiBold),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
