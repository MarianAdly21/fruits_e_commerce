import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_button.dart';
import 'package:fruits_e_commerce/core/widgets/app_text_form_field.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_app_bar.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/custom_check_box_widget.dart';
import 'package:fruits_e_commerce/features/auth/presentation/widgets/rich_text_custom_widget.dart';
import 'package:fruits_e_commerce/res/app_color.dart';

class SignupView extends StatefulWidget {
  const new({super.key});
  static const String routeName = "/signup-view";

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "حساب جديد",
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _formWidget(),
            _termsAndCondations(),

            AppTextButton(
              onPressed: () {},
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
      child: Column(
        children: [
          AppTextFormField(
            hintText: "الاسم كامل",
            textInputType: TextInputType.name,
          ),
          AppTextFormField(
            hintText: "البريد الإلكتروني",
            textInputType: TextInputType.emailAddress,
          ),
          AppTextFormField(
            hintText: "كلمة المرور",
            obscureText: true,
            textInputType: TextInputType.visiblePassword,
          ),
        ],
      ),
    );
  }
}
