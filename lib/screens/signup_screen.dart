// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import 'package:toastification/toastification.dart';
//
// import '../Route/app_route.dart';
// import '../controllers/signup_controller.dart';
// import '../services/api_service.dart';
//
// class RegisterScreen extends StatelessWidget {
//   const RegisterScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController usernameController = TextEditingController();
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     TextEditingController confirmPasswordController = TextEditingController();
//     var formKey = GlobalKey<FormState>();
//
//     var registerController = Get.put(RegisterController());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [
//             // Image.asset(
//             //   'assets/images/register.gif',
//             //   height: 280.h,
//             // ),
//             const Spacer(),
//             Expanded(
//               flex: 8,
//               child: SingleChildScrollView(
//                 child: Form(
//                   key: formKey,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Center(
//                         child: Stack(
//                           alignment: Alignment.bottomRight,
//                           children: [
//                             GetBuilder<RegisterController>(builder: (context) {
//                               return CircleAvatar(
//                                 radius: 65.w,
//                                 foregroundImage:
//                                     (registerController.image != null)
//                                         ? FileImage(registerController.image!)
//                                         : null,
//                                 child: (registerController.image != null)
//                                     ? const Text("")
//                                     : Icon(
//                                         Icons.person,
//                                         size: 45.sp,
//                                       ),
//                               );
//                             }),
//                             FloatingActionButton.small(
//                               onPressed: () {
//                                 registerController.pickUserImage();
//                               },
//                               child: const Icon(Icons.add_a_photo_outlined),
//                             )
//                           ],
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Text(
//                         "Username",
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       TextFormField(
//                         controller: usernameController,
//                         validator: (value) =>
//                             value!.isEmpty ? "Username is required" : null,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xfff2f6fa),
//                           hintText: "Enter username",
//                           prefixIcon: const Icon(
//                             Icons.person,
//                             color: Colors.grey,
//                           ),
//                           hintStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Text(
//                         "Email",
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       TextFormField(
//                         controller: emailController,
//                         validator: (value) {
//                           if (value!.isEmpty) {
//                             return "Email is required";
//                           }
//
//                           // Regular expression for validating email
//                           String pattern =
//                               r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
//                           RegExp regExp = RegExp(pattern);
//
//                           if (!regExp.hasMatch(value)) {
//                             return "Invalid email address";
//                           }
//                           return null;
//                         },
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xfff2f6fa),
//                           hintText: "Enter email",
//                           prefixIcon: const Icon(
//                             Icons.email,
//                             color: Colors.grey,
//                           ),
//                           hintStyle: const TextStyle(
//                             color: Colors.grey,
//                             fontWeight: FontWeight.w400,
//                           ),
//                           enabledBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                           ),
//                           focusedBorder: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Text(
//                         "Password",
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Obx(() {
//                         return TextFormField(
//                           obscureText:
//                               registerController.isPasswordVisible.value,
//                           controller: passwordController,
//                           validator: (value) =>
//                               value!.isEmpty ? "Password is required" : null,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: const Color(0xfff2f6fa),
//                             hintText: "Enter password",
//                             prefixIcon: const Icon(
//                               Icons.lock,
//                               color: Colors.grey,
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 registerController.togglePasswordVisibility();
//                               },
//                               icon: Icon(
//                                 (registerController.isPasswordVisible.value)
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                               ),
//                             ),
//                             hintStyle: const TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Text(
//                         "Confirm Password",
//                         style: TextStyle(
//                           fontSize: 18.sp,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10.h,
//                       ),
//                       Obx(() {
//                         return TextFormField(
//                           obscureText:
//                               registerController.isConfirmPasswordVisible.value,
//                           controller: confirmPasswordController,
//                           validator: (value) => value!.isEmpty
//                               ? "Confirm password is required"
//                               : null,
//                           decoration: InputDecoration(
//                             filled: true,
//                             fillColor: const Color(0xfff2f6fa),
//                             hintText: "Enter confirm password",
//                             prefixIcon: const Icon(
//                               Icons.lock,
//                               color: Colors.grey,
//                             ),
//                             suffixIcon: IconButton(
//                               onPressed: () {
//                                 registerController
//                                     .toggleConfirmPasswordVisibility();
//                               },
//                               icon: Icon(
//                                 (registerController
//                                         .isConfirmPasswordVisible.value)
//                                     ? Icons.visibility_off
//                                     : Icons.visibility,
//                               ),
//                             ),
//                             hintStyle: const TextStyle(
//                               color: Colors.grey,
//                               fontWeight: FontWeight.w400,
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                             focusedBorder: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(12),
//                               borderSide: BorderSide(
//                                 color: Colors.grey.shade300,
//                               ),
//                             ),
//                           ),
//                         );
//                       }),
//                       SizedBox(
//                         height: 20.h,
//                       ),
//                       Align(
//                         child: GestureDetector(
//                           onTap: () async {
//                             if (formKey.currentState!.validate() &&
//                                 registerController.image != null) {
//                               String username = usernameController.text.trim();
//                               String email = emailController.text.trim();
//                               String password = passwordController.text.trim();
//                               String confirmPassword =
//                                   confirmPasswordController.text.trim();
//
//                               if (password == confirmPassword) {
//                                 String image = await ImageUploadService.instance
//                                     .uploadImage(
//                                         imageFile: registerController.image!);
//
//                                 registerController.registerNewUser(
//                                   userName: username,
//                                   email: email,
//                                   password: password,
//                                   image: image,
//                                 );
//                               } else {
//                                 toastification.show(
//                                   title: const Text("ERROR"),
//                                   description: const Text(
//                                     "Password and confirm password do not match",
//                                   ),
//                                   autoCloseDuration: const Duration(
//                                     seconds: 3,
//                                   ),
//                                   type: ToastificationType.error,
//                                   style: ToastificationStyle.flatColored,
//                                 );
//                               }
//                             }
//                           },
//                           child: Container(
//                             height: 50.h,
//                             width: 140.w,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               color: const Color(0xff518cf7),
//                             ),
//                             alignment: Alignment.center,
//                             child: Text(
//                               "Register",
//                               style: TextStyle(
//                                 fontSize: 16.sp,
//                                 fontWeight: FontWeight.bold,
//                                 letterSpacing: 0.8,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Text.rich(
//               TextSpan(
//                 text: "Already have an account? ",
//                 children: [
//                   TextSpan(
//                     text: "Login",
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Get.toNamed(AppRoute.logIn);
//                       },
//                     style: const TextStyle(
//                       color: Color(0xff518cf7),
//                       fontWeight: FontWeight.bold,
//                       decoration: TextDecoration.underline,
//                       decorationColor: Color(0xff518cf7),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:toastification/toastification.dart';

import '../Route/app_route.dart';
import '../controllers/signup_controller.dart';
import '../services/api_service.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();
    var formKey = GlobalKey<FormState>();

    var registerController = Get.put(RegisterController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6a11cb), Color(0xff2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Profile Avatar
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      GetBuilder<RegisterController>(builder: (context) {
                        return CircleAvatar(
                          radius: 65.w,
                          foregroundImage: (registerController.image != null)
                              ? FileImage(registerController.image!)
                              : null,
                          backgroundColor: Colors.white,
                          child: (registerController.image == null)
                              ? Icon(
                                  Icons.person,
                                  size: 45.sp,
                                  color: Colors.grey.shade700,
                                )
                              : null,
                        );
                      }),
                      FloatingActionButton.small(
                        onPressed: () {
                          registerController.pickUserImage();
                        },
                        backgroundColor: Colors.white,
                        child: const Icon(Icons.add_a_photo_outlined,
                            color: Colors.black),
                      )
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Form Container
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 3,
                        )
                      ],
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                              "Username", Icons.person, usernameController),
                          _buildTextField("Email", Icons.email, emailController,
                              isEmail: true),
                          _buildPasswordField(
                              "Password",
                              Icons.lock,
                              passwordController,
                              registerController.isPasswordVisible,
                              registerController.togglePasswordVisibility),
                          _buildPasswordField(
                              "Confirm Password",
                              Icons.lock,
                              confirmPasswordController,
                              registerController.isConfirmPasswordVisible,
                              registerController
                                  .toggleConfirmPasswordVisibility),

                          SizedBox(height: 20.h),

                          // Register Button
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate() &&
                                    registerController.image != null) {
                                  String username =
                                      usernameController.text.trim();
                                  String email = emailController.text.trim();
                                  String password =
                                      passwordController.text.trim();
                                  String confirmPassword =
                                      confirmPasswordController.text.trim();

                                  if (password == confirmPassword) {
                                    String image = await ImageUploadService
                                        .instance
                                        .uploadImage(
                                      imageFile: registerController.image!,
                                    );

                                    registerController.registerNewUser(
                                      userName: username,
                                      email: email,
                                      password: password,
                                      image: image,
                                    );
                                  } else {
                                    toastification.show(
                                      title: const Text("ERROR"),
                                      description: const Text(
                                        "Password and confirm password do not match",
                                      ),
                                      autoCloseDuration:
                                          const Duration(seconds: 3),
                                      type: ToastificationType.error,
                                      style: ToastificationStyle.flatColored,
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 14.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                backgroundColor: const Color(0xff2575fc),
                              ),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.8,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 15.h),

                          // Login Text
                          Center(
                            child: Text.rich(
                              TextSpan(
                                text: "Already have an account? ",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey.shade700,
                                ),
                                children: [
                                  TextSpan(
                                    text: "Login",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Get.toNamed(AppRoute.logIn);
                                      },
                                    style: TextStyle(
                                      color: const Color(0xff2575fc),
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                      fontSize: 14.sp,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, IconData icon, TextEditingController controller,
      {bool isEmail = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return "$label is required";
          }

          if (isEmail) {
            String pattern =
                r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
            if (!RegExp(pattern).hasMatch(value)) {
              return "Invalid email address";
            }
          }
          return null;
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xfff2f6fa),
          hintText: "Enter $label",
          prefixIcon: Icon(icon, color: Colors.grey),
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
      String label,
      IconData icon,
      TextEditingController controller,
      RxBool isVisible,
      VoidCallback toggleVisibility) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Obx(() {
        return TextFormField(
          obscureText: isVisible.value,
          controller: controller,
          validator: (value) => value!.isEmpty ? "$label is required" : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xfff2f6fa),
            hintText: "Enter $label",
            prefixIcon: Icon(icon, color: Colors.grey),
            suffixIcon: IconButton(
              onPressed: toggleVisibility,
              icon: Icon(
                  isVisible.value ? Icons.visibility_off : Icons.visibility),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
          ),
        );
      }),
    );
  }
}
