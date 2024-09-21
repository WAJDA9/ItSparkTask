import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:itsparktask/const/assets.dart';
import 'package:itsparktask/const/colors.dart';
import 'package:itsparktask/const/text.dart';
import 'package:itsparktask/repositories/user_repository.dart';
import 'package:itsparktask/widgets/button_widget.dart';
import 'package:itsparktask/widgets/input_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _stayConnected = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); 

  
  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  
  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r"^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$");
    if (value == null || value.isEmpty) {
      return 'Email cannot be empty';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password cannot be empty';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 40.h),
          child: Form(  
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.w,
                  child: Image.asset(Assets.fullLogo),
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum.",
                    textAlign: TextAlign.center,
                    style: AppTextStyle.infoText.copyWith(fontSize: 14.sp),
                  ),
                ),
                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Column(
                    children: [
                      TextFieldWidget(
                        hintText: "Enter Email Address",
                        isPassword: false,
                        controller: emailController,
                        validator: _validateEmail,  
                      ),
                      SizedBox(height: 16.h),
                      TextFieldWidget(
                        hintText: "Enter Password",
                        isPassword: true,
                        controller: passwordController,
                        validator: _validatePassword,  
                      ),
                      SizedBox(height: 16.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                activeColor: AppColors.primaryColor,
                                value: _stayConnected,
                                onChanged: (bool? value) {
                                  setState(() {
                                    _stayConnected = value!;
                                  });
                                },
                              ),
                              Text(
                                'Stay connected',
                                style: AppTextStyle.infoText.copyWith(
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '/forgot password screen');
                            },
                            child: Text(
                              'Forgot password',
                              style: AppTextStyle.infoText.copyWith(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      SizedBox(
                        width: double.infinity,
                        child: ButtonWidget(
                          buttonText: "Sign in",
                          onClick: () async {
                            
                            if (_formKey.currentState!.validate()) {
                              try {
                                final user = await UserRepository().login(
                                  emailController.text,
                                  passwordController.text,
                                );
                                if (user != null) {
                                  Navigator.pushNamed(context, '/home');
                                } else {
                                  _showSnackBar(context, "Login failed. Please check your credentials.");
                                }
                              } catch (e) {
                                
                                _showSnackBar(context, "An error occurred. Please try again.");
                              }
                            } else {
                             
                              _showSnackBar(context, "Please correct the errors in the form.");
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
