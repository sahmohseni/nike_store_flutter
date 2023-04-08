import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nike_store/src/presentation/ui/auth/bloc/auth_bloc.dart';
import 'package:nike_store/theme.dart';

class AuthScreen extends StatefulWidget {
  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final TextEditingController userNameController =
      TextEditingController(text: 'test@gmail.com');
  final TextEditingController passWordController =
      TextEditingController(text: '123456');
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocProvider<AuthBloc>(
        create: (context) {
          final authBloc = AuthBloc();
          authBloc.stream.forEach((state) {
            if (state is AuthSuccess) {
              Navigator.of(context).pop();
            } else if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(
                state.errorMessage,
                style: const TextStyle(fontFamily: 'dana', color: Colors.white),
              )));
            }
          });
          authBloc.add(AuthStart());
          return authBloc;
        },
        child: Scaffold(
          body: SafeArea(
            child: Center(
              child: BlocBuilder<AuthBloc, AuthState>(
                buildWhen: (previous, current) {
                  return current is AuthLoading ||
                      current is AuthError ||
                      current is AuthInitial;
                },
                builder: (context, state) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 124),
                        child: Image.asset(
                          'assets/images/nike_logo.png',
                          height: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(24, 90, 24, 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: LightTheme.primaryColor,
                              ),
                              child: Center(
                                child: Text(
                                  state.loginMode ? 'ورود' : 'ثبت نام',
                                  style: const TextStyle(
                                      color: Colors.white, fontFamily: 'dana'),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            //--------------------------------------------------------
                            //username container
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: LightTheme.itemBackGroundColor),
                                child: TextField(
                                  controller: userNameController,
                                  decoration: const InputDecoration(
                                      hintText: 'ایمیل',
                                      hintTextDirection: TextDirection.rtl,
                                      hintStyle: TextStyle(
                                          fontFamily: 'dana', fontSize: 10),
                                      prefixIcon: Icon(
                                        CupertinoIcons.mail_solid,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            //--------------------------------------------------------
                            //password textfiled
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 16, 0, 16),
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: LightTheme.itemBackGroundColor),
                                child: TextField(
                                  controller: passWordController,
                                  decoration: const InputDecoration(
                                      hintText: 'رمزعبور',
                                      hintTextDirection: TextDirection.rtl,
                                      hintStyle: TextStyle(
                                          fontFamily: 'dana', fontSize: 10),
                                      prefixIcon: Icon(
                                        CupertinoIcons.mail_solid,
                                        color: Colors.grey,
                                        size: 16,
                                      ),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none)),
                                ),
                              ),
                            ),
                            //--------------------------------------------------------
                            //auth button
                            Container(
                              height: 40,
                              decoration: const BoxDecoration(),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              LightTheme.primaryColor),
                                      elevation: MaterialStateProperty.all(0),
                                      shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15)))),
                                  onPressed: () {
                                    BlocProvider.of<AuthBloc>(context).add(
                                        AuthButtonClicked(
                                            userName: userNameController.text,
                                            passWord: passWordController.text));
                                  },
                                  child: state is AuthLoading
                                      ? const SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                      : Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                state.loginMode
                                                    ? 'ورود به حساب کاربری'
                                                    : 'ثبت نام',
                                                style: const TextStyle(
                                                    fontFamily: 'dana'),
                                              ),
                                              const SizedBox(
                                                width: 12,
                                              ),
                                              Icon(
                                                state.loginMode
                                                    ? CupertinoIcons.arrow_left
                                                    : CupertinoIcons
                                                        .person_badge_plus,
                                                size: 16,
                                              )
                                            ],
                                          ),
                                        )),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(state.loginMode
                                      ? 'حساب کاربری ندارید؟'
                                      : 'حساب کاربری دارید؟'),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      BlocProvider.of<AuthBloc>(context)
                                          .add(AuthChangeModeClicked());
                                    },
                                    child: Text(
                                      state.loginMode
                                          ? 'یکیشو بساز'
                                          : 'وارد شو',
                                      style: const TextStyle(
                                          fontFamily: 'dana',
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
