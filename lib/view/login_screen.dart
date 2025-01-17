import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pratical_task/components/custom_button.dart';
import 'package:pratical_task/components/social_button.dart';
import 'package:pratical_task/view/sign_up.dart';
import 'package:pratical_task/view_model/auth_view_model.dart';

import '../components/custom_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  AuthViewModel controller = Get.put(AuthViewModel());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                    color: Color(0xFFFFE8E0),
                    borderRadius: BorderRadius.circular(15)),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Color(0xFFFF4201),
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 50),
              const Text(
                'Login Your Account',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 30),
              CustomTextField(
                hintText: 'Email',
                editingController: controller.emailController,
                prefixIcon: Icons.email,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Email is required';
                  }
                  if (!RegExp(r"^[a-zA-Z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]")
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 40),
              CustomTextField(
                editingController: controller.passwordController,
                hintText: 'Password',
                prefixIcon: Icons.lock,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password is required';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forget Password?',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Obx(() {
                return controller.isLoading.value
                    ? Center(child: const CircularProgressIndicator())
                    : CustomButtom(
                        text: 'LOGIN',
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                          controller.login();
                          }
                        },
                        color: Color(0xFFFF4201),
                        textColor: Colors.white,
                      );
              }),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Create New Account? ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(RegisterScreen());
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Color(0xFFFF4201)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Continue with Accounts",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButton(
                      label: "GOOGLE",
                      backgroundColor: Colors.white,
                      textColor: Colors.black),
                  SocialButton(
                      label: "FACEBOOK",
                      backgroundColor: Color(0xFF4267B2),
                      textColor: Colors.white),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
