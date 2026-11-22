import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:fruits_e_commerce/core/helper/app_validator.dart';
import 'package:fruits_e_commerce/core/helper/build_error_bar.dart';
import 'package:fruits_e_commerce/core/services/git_it_sevice.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_button.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:fruits_e_commerce/features/auth/domain/repos/auth_repo.dart';
import 'package:fruits_e_commerce/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_check_box_widget.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_progress_hud.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/rich_text_custom_widget.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class SignupView extends StatelessWidget {
  const new({super.key});
  static const String routeName = "/signup-view";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(authRepo: getIt<AuthRepo>()),
      child: SignupViewWithBloc(),
    );
  }
}

class SignupViewWithBloc extends StatefulWidget {
  const new({super.key});

  @override
  State<SignupViewWithBloc> createState() => _SignupViewWithBlocState();
}

class _SignupViewWithBlocState extends State<SignupViewWithBloc> {
  bool isTermsAccepted = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String _email;
  late String _password;
  late String _fullName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "حساب جديد",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state is SignupErrorState) {
            buildErrorBar(context, state.errorMessage);
          }
        },
        builder: (context, state) {
          return CustomProgressHud(
            isLoading: state is SignupLoadingState ? true : false,
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
            _termsAndCondations(),
            AppTextButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  _formKey.currentState!.save();
                  if (isTermsAccepted) {
                    context.read<SignupCubit>().createUserWithEmailAndPassword(
                      email: _email,
                      password: _password,
                      name: _fullName,
                    );
                  } else {
                    return buildErrorBar(
                      context,
                      "يجب الموفقه علي الشروط و الاحكام",
                    );
                  }
                } else {
                  autovalidateMode = AutovalidateMode.always;
                  setState(() {});
                }
              },
              text: "إنشاء حساب جديد",
              padding: EdgeInsets.symmetric(vertical: 30.h),
            ),
            RichTextCustomWidget(
              onTap: () {
                Navigator.pop(context);
              },
              text1: "لديك حساب بالفعل؟ ",
              text2: " تسجيل الدخول",
            ),
          ],
        ),
      ),
    );
  }

  Padding _termsAndCondations() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCheckBoxWidget(
            isChecked: isTermsAccepted,
            onChanged: (value) {
              setState(() {
                isTermsAccepted = value;
              });
            },
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: "من خلال إنشاء حساب ، فإنك توافق على",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColor.smallTextColor,
                ),
                children: [
                  TextSpan(
                    text: "الشروط والأحكام الخاصة بنا ",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColor.lightPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _formWidget() {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: Column(
        children: [
          AppTextFormField(
            hintText: "الاسم كامل",
            textInputType: TextInputType.name,
            onSaved: _onSavedFullName,
            validator: (value) => AppValidator.validateFullName(value),
          ),
          AppTextFormField(
            hintText: "البريد الإلكتروني",
            textInputType: TextInputType.emailAddress,
            onSaved: _onSavedEmail,
            validator: (value) => AppValidator.validateEmail(value),
          ),
          AppTextFormField(
            hintText: "كلمة المرور",
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
            onSaved: _onSavedPassword,
            validator: (value) => AppValidator.validatePassword(value),
          ),
        ],
      ),
    );
  }

  //////////////////////////////////////////////////////////////
  ///////////////////helper method///////////////////////////////
  //////////////////////////////////////////////////////////////

  void _onSavedPassword(String? value) {
    _password = value!;
  }

  void _onSavedEmail(String? value) {
    _email = value!.trim();
  }

  void _onSavedFullName(String? value) {
    _fullName = value!;
  }
}
