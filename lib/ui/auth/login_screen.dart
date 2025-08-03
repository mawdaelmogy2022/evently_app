import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/providers/event_list_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:evently_app/ui/auth/widget/custom_text_buttom.dart';
import 'package:evently_app/ui/widget/custom_buttom.dart';
import 'package:evently_app/ui/widget/custom_text_form_field.dart';
import 'package:evently_app/utils/app_color.dart';
import 'package:evently_app/utils/app_image.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:evently_app/utils/app_style.dart';
import 'package:evently_app/utils/dialog_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .03),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                AppImage.logoImage,
                width: size.width * .4,
                height: size.height * .4,
              ),
              Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter email";
                          }
                          final bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          if (emailValid == false) {
                            return "please enter valid email";
                          }
                        },
                        textEditingController: emailController,
                        prefixIcon:
                            const Icon(Icons.email, color: AppColor.grayColor),
                        hintText: AppLocalizations.of(context)!.email,
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter password";
                          }
                          if (value.length < 6) {
                            return "password must be at least 6 char";
                          }
                        },
                        textEditingController: passwordController,
                        prefixIcon: const Icon(Icons.password,
                            color: AppColor.grayColor),
                        hintText: AppLocalizations.of(context)!.password,
                        sufixIcon: const Icon(Icons.visibility_off_outlined,
                            color: AppColor.grayColor),
                      ),
                      CustomTextButtom(
                        onpressed: () {},
                        text: AppLocalizations.of(context)!.forget_password,
                      ),
                      CustomButtom(
                        text: AppLocalizations.of(context)!.login,
                        onpressed: () async {
                          if (formKey.currentState!.validate()) {
                            DialogUtils.showLoading(
                                context: context, loadingText: 'Waiting....');
                            try {
                              final credential = await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: emailController.text,
                                      password: passwordController.text);
                              // to do : read user from fireStore
                              var user =
                                  await FirebaseUtils.readUserFrimFirestore(
                                      credential.user?.uid ?? '');
                              if (user == null) {
                                return;
                              }
                              // to do : save user in provider
                              var userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);
                              userProvider.updateUser(user);
                              var eventListProvider =
                                  Provider.of<EventListProvider>(context,
                                      listen: false);
                              eventListProvider.changeSelectedIndex(
                                  0, userProvider.currentUser!.id);
                              eventListProvider.getAllFavouriteEvent(
                                  userProvider.currentUser!.id);
                              DialogUtils.hideLoading(context: context);
                              DialogUtils.showMessage(
                                context: context,
                                message: 'Login Succussfully',
                                posActionName: 'ok',
                                posAction: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamedAndRemoveUntil(
                                    AppRoutes.homeRoute,
                                    (route) => false,
                                  );
                                },
                              );
                              //   print('Login Succussfully');
                              //    print("id :${credential.user?.uid ?? ''}");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'user-not-found') {
                                DialogUtils.hideLoading(context: context);
                                DialogUtils.showMessage(
                                    context: context,
                                    message: 'No user found for that email.');
                                print('No user found for that email.');
                              } else if (e.code == 'wrong-password') {
                                DialogUtils.hideLoading(context: context);
                                DialogUtils.showMessage(
                                    context: context,
                                    message:
                                        'Wrong password provided for that user.');
                                print('Wrong password provided for that user.');
                              } else if (e.code == 'network-request-failed') {
                                DialogUtils.hideLoading(context: context);
                                DialogUtils.showMessage(
                                    context: context,
                                    message:
                                        'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
                                print(
                                    'A network error (such as timeout, interrupted connection or unreachable host) has occurred.');
                              } else if (e.code == 'invalid-credential') {
                                DialogUtils.hideLoading(context: context);
                                DialogUtils.showMessage(
                                    context: context,
                                    message:
                                        'The supplied auth credential is incorrect, malformed or has expired.');
                                print(
                                    'The supplied auth credential is incorrect, malformed or has expired.');
                              }
                            } catch (e) {
                              DialogUtils.hideLoading(context: context);
                              DialogUtils.showMessage(
                                  context: context, message: e.toString());
                              print(e);
                            }
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(context)!.dont_have_account,
                            style: AppStyle.black16meduim,
                          ),
                          CustomTextButtom(
                              onpressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.registerRoute);
                              },
                              text:
                                  AppLocalizations.of(context)!.create_account)
                        ],
                      ),
                    ],
                  )),
              Row(
                children: [
                  Expanded(
                      child: Divider(
                    color: AppColor.primaryblueColor,
                    thickness: 1,
                    indent: size.width * .07,
                    endIndent: size.width * .04,
                  )),
                  Text(
                    AppLocalizations.of(context)!.or,
                    style: AppStyle.blue16meduim,
                  ),
                  Expanded(
                      child: Divider(
                    color: AppColor.primaryblueColor,
                    thickness: 1,
                    indent: size.width * .04,
                    endIndent: size.width * .07,
                  ))
                ],
              ),
              SizedBox(
                height: size.height * .02,
              ),
              CustomButtom(
                  imageIcon: true,
                  imageIconUrl: AppImage.googleIconImage,
                  backgroundColor: AppColor.transparentColor,
                  text: AppLocalizations.of(context)!.login_with_google,
                  textStyle: AppStyle.blue20meduim,
                  onpressed: () {})
            ],
          ),
        ),
      )),
    );
  }
}
