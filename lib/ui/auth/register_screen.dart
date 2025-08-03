import 'package:evently_app/firebase_utils.dart';
import 'package:evently_app/model/my_user_model.dart';
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

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.transparentColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColor.blackColor),
        title: Text(
          AppLocalizations.of(context)!.register,
          style: AppStyle.black16meduim,
        ),
        centerTitle: true,
      ),
      body: Padding(
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
                    children: [
                      CustomTextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "please enter name";
                          }
                        },
                        textEditingController: nameController,
                        prefixIcon:
                            const Icon(Icons.person, color: AppColor.grayColor),
                        hintText: AppLocalizations.of(context)!.name,
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
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
                          if (value.toString() != passwordController.text) {
                            return "must Enter match password ";
                          }
                        },
                        textEditingController: repasswordController,
                        prefixIcon: const Icon(Icons.password,
                            color: AppColor.grayColor),
                        hintText: AppLocalizations.of(context)!.re_password,
                        sufixIcon: const Icon(Icons.visibility_off_outlined,
                            color: AppColor.grayColor),
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      CustomButtom(
                        text: AppLocalizations.of(context)!.create_account,
                        onpressed: () async {
                          if (formKey.currentState!.validate()) {
                            DialogUtils.showLoading(
                                context: context, loadingText: 'Loading....');
                            try {
                              // to da : sing Up
                              final credential = await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              // to do : save user
                              MyUserModel myuser = MyUserModel(
                                  id: credential.user?.uid ?? '',
                                  name: nameController.text,
                                  email: emailController.text);
                              FirebaseUtils.addUserToFireStore(myuser);
                              var userProvider = Provider.of<UserProvider>(
                                  context,
                                  listen: false);
                              userProvider.updateUser(myuser);
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
                                message: 'Register Successfully',
                                posActionName: 'ok',
                                posAction: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pushNamedAndRemoveUntil(
                                    AppRoutes.homeRoute,
                                    (route) => false,
                                  );
                                },
                              );
                              print('Register Succussfully');
                              print("id :${credential.user?.uid ?? ''}");
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'weak-password') {
                                DialogUtils.hideLoading(context: context);
                                DialogUtils.showMessage(
                                    context: context,
                                    message:
                                        'The password provided is too weak.');
                                print('The password provided is too weak.');
                              } else if (e.code == 'email-already-in-use') {
                                DialogUtils.hideLoading(context: context);
                                DialogUtils.showMessage(
                                    context: context,
                                    message:
                                        'he account already exists for that email.');
                                print(
                                    'The account already exists for that email.');
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
                    ],
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppLocalizations.of(context)!.already_have_account,
                    style: AppStyle.black16meduim,
                  ),
                  CustomTextButtom(
                      onpressed: () {
                        Navigator.pushNamed(context, AppRoutes.loginRoute);
                      },
                      text: AppLocalizations.of(context)!.login)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
