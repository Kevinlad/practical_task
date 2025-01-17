import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pratical_task/components/custom_textfield.dart';
import 'package:pratical_task/components/social_button.dart';
import 'package:pratical_task/view/login_screen.dart';
import 'package:pratical_task/view_model/auth_view_model.dart';
import '../components/custom_button.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);

  final ValueNotifier<String> gender = ValueNotifier<String>("Male");
  final controller = Get.put(AuthViewModel());
  final _formKey = GlobalKey<FormState>(); 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Form(
            // Wrap everything in a Form widget
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 50),
                InkWell(
                  onTap: () {},
                  child: Container(
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
                ),
                const Text(
                  "Create your Account",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: "First Name",
                  prefixIcon: Icons.person,
                  editingController: controller.firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'First Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: "Last Name",
                  prefixIcon: Icons.person,
                  editingController: controller.lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Last Name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: "Your Email ID",
                  prefixIcon: Icons.email,
                  editingController: controller.emailController,
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
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: "+0000 0000 0000",
                  prefixIcon: Icons.phone,
                  editingController: controller.phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                const Text(
                  "Select Gender",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildGenderOption("Male"),
                    _buildGenderOption("Female"),
                    _buildGenderOption("Other"),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: "Password",
                  prefixIcon: Icons.lock,
                  editingController: controller.passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: "Confirm Password",
                  prefixIcon: Icons.lock,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != controller.passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return controller.isLoading.value
                      ? Center(child: const CircularProgressIndicator())
                      : CustomButtom(
                          text: 'Register',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              controller.signUp();
                            }
                          },
                          color: Color(0xFFFF4201),
                          textColor: Colors.white,
                        );
                }),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already Have An Account? ",
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(LoginScreen());
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                const Center(
                  child: Text(
                    "Continue With Accounts",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 15),
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
      ),
    );
  }

  Widget _buildGenderOption(String label) {
    return ValueListenableBuilder<String>(
      valueListenable: gender,
      builder: (context, selectedGender, _) {
        return GestureDetector(
          onTap: () {
            gender.value = label;
            controller.setGender(label);
          },
          child: Row(
            children: [
              Radio<String>(
                value: label,
                groupValue: selectedGender,
                onChanged: (value) {
                  gender.value = value!;
                  controller.setGender(value);
                },
                activeColor: Colors.orange,
              ),
              Text(label),
            ],
          ),
        );
      },
    );
  }
}
