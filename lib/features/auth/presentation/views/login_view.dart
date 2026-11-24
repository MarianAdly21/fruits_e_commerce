import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:fruits_e_commerce/core/helper/app_validator.dart';
import 'package:fruits_e_commerce/core/helper/build_error_bar.dart';
import 'package:fruits_e_commerce/core/services/git_it_sevice.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_button.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:fruits_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_e_commerce/features/auth/presentation/cubits/login_cubit/cubit/login_cubit.dart';
import 'package:fruits_e_commerce/features/auth/presentation/views/signup_view.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_progress_hud.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/rich_text_custom_widget.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/social_login_button.dart';
import 'package:fruits_e_commerce/res/app_assets.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class LoginView extends StatelessWidget {
  const new({super.key});
  static const String routeName = "/login-view";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(authRepo: getIt<AuthRepo>()),
      child: LoginViewWithBloc(),
    );
  }
}

class LoginViewWithBloc extends StatefulWidget {
  const new({super.key});

  @override
  State<LoginViewWithBloc> createState() => _LoginViewWithBlocState();
}

class _LoginViewWithBlocState extends State<LoginViewWithBloc> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String _email;
  late String _password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "تسجيل الدخول", onTap: () {}),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginErrorState) {
            buildErrorBar(context, state.errorMessage);
          } else if (state is LoginSuccessState) {}
        },
        builder: (context, state) {
          return CustomProgressHud(
            isLoading: state is LoginLoadingState ? true : false,
            child: _buildBody(context),
          );
        },
      ),
    );
  }

  //////////////////////////////////////////////////////////////
  ///////////////////helper widget///////////////////////////////
  //////////////////////////////////////////////////////////////

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _formWidget(),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "نسيت كلمة المرور؟",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColor.lightPrimaryColor,
                  ),
                ),
              ),
            ),
            AppTextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState!.save();
                  context.read<LoginCubit>().signinWithEmailAndPassword(
                    email: _email,
                    password: _password,
                  );
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              text: "تسجيل الدخول",
              padding: EdgeInsets.symmetric(vertical: 33.h),
            ),

            RichTextCustomWidget(
              onTap: () {
                Navigator.pushNamed(context, SignupView.routeName);
              },
              text1: "لا تمتلك حساب؟ ",
              text2: "قم بانشاء حساب",
            ),
            _orDividerWidget(),
            _socialAuthWidgte(),
          ],
        ),
      ),
    );
  }

  Widget _socialAuthWidgte() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        children: [
          SocialLoginButton(
            onPressed: () {
              context.read<LoginCubit>().signinWithGoogle();
            },
            icon: AppAssets.googleIcon,
            text: "تسجيل بواسطة جوجل",
          ),
          Platform.isIOS
              ? SocialLoginButton(
                  onPressed: () {},
                  icon: AppAssets.appleIcon,
                  text: "تسجيل بواسطة أبل",
                )
              : SizedBox.shrink(),
          SocialLoginButton(
            onPressed: () {
              context.read<LoginCubit>().signinWithFacebook();
            },
            icon: AppAssets.facebookIcon,
            text: "تسجيل بواسطة فيسبوك",
          ),
        ],
      ),
    );
  }

  Widget _orDividerWidget() {
    return Padding(
      padding: EdgeInsets.only(top: 33.h, bottom: 16.h),
      child: Row(
        children: [
          _divider(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w),
            child: Text(
              "أو",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColor.blackFont,
              ),
            ),
          ),
          _divider(),
        ],
      ),
    );
  }

  Widget _divider() {
    return Expanded(
      child: Divider(color: AppColor.deviderColor, thickness: 1, height: 1),
    );
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          AppTextFormField(
            hintText: "البريد الإلكتروني",
            textInputType: TextInputType.emailAddress,
            validator: (value) => AppValidator.validateEmail(value),
            onSaved: _onSavedEmail,
          ),
          AppTextFormField(
            hintText: "كلمة المرور",
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            validator: (value) => AppValidator.validatePassword(value),
            onSaved: _onSavedPassword,
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////
  ///////////////////helper widget///////////////////////////////
  //////////////////////////////////////////////////////////////

  void _onSavedPassword(String? value) {
    _password = value!;
  }

  void _onSavedEmail(String? value) {
    _email = value!.trim();
  }
}
