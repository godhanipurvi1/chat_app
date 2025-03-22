// import 'package:chat_app/Route/app_route.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../controllers/login_controller.dart';
//
// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     var loginKey = GlobalKey<FormState>();
//
//     var controller = Get.put(LoginController());
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Logo or Image at the top
//               // Image.asset(
//               //   'assets/images/login.gif', // Your logo or animated gif
//               //   height: 150.h, // Adjust height based on your logo size
//               // ),
//               // SizedBox(height: 40.h), // Space after the logo
//
//               // Form for email and password
//               Form(
//                 key: loginKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     // Email Input
//                     Text(
//                       "Email",
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     TextFormField(
//                       controller: emailController,
//                       validator: (val) {
//                         if (val!.isEmpty) {
//                           return "Please enter your email.";
//                         }
//                         // Regular expression for email validation
//                         final emailRegExp = RegExp(
//                             r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
//                         if (!emailRegExp.hasMatch(val)) {
//                           return "Email is not valid.";
//                         }
//                         return null;
//                       },
//                       decoration: InputDecoration(
//                         filled: true,
//                         fillColor: const Color(0xfff2f6fa),
//                         hintText: "Enter your email",
//                         prefixIcon: const Icon(
//                           Icons.email,
//                           color: Colors.grey,
//                         ),
//                         hintStyle: const TextStyle(
//                           color: Colors.grey,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                           borderSide: BorderSide(
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//
//                     // Password Input
//                     Text(
//                       "Password",
//                       style: TextStyle(
//                         fontSize: 20.sp,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     SizedBox(height: 10.h),
//                     Obx(() {
//                       return TextFormField(
//                         obscureText: controller.isPassword.value,
//                         controller: passwordController,
//                         validator: (val) =>
//                             val!.isEmpty ? "Password is required." : null,
//                         decoration: InputDecoration(
//                           filled: true,
//                           fillColor: const Color(0xfff2f6fa),
//                           hintText: "Enter your password",
//                           prefixIcon: const Icon(
//                             Icons.lock,
//                             color: Colors.grey,
//                           ),
//                           suffixIcon: IconButton(
//                             onPressed: () {
//                               controller.changeVisibilityPassword();
//                             },
//                             icon: Icon(
//                               controller.isPassword.value
//                                   ? Icons.visibility_off
//                                   : Icons.visibility,
//                             ),
//                           ),
//                           hintStyle: const TextStyle(
//                             color: Colors.grey,
//                           ),
//                           border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(12),
//                             borderSide: BorderSide(
//                               color: Colors.grey.shade300,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                     SizedBox(
//                         height: 30
//                             .h), // Add spacing between the password field and buttons
//
//                     // Login Button
//                     Align(
//                       alignment: Alignment.center,
//                       child: GestureDetector(
//                         onTap: () {
//                           if (loginKey.currentState!.validate()) {
//                             controller.loginNewUser(
//                               email: emailController.text.trim(),
//                               password: passwordController.text.trim(),
//                             );
//                           }
//                         },
//                         child: Container(
//                           height: 50.h,
//                           width: 180.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             color: const Color(0xff518cf7),
//                           ),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "Login",
//                             style: TextStyle(
//                               fontSize: 16.sp,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 15.h),
//
//                     // Sign in with Google button
//                     Align(
//                       alignment: Alignment.center,
//                       child: OutlinedButton.icon(
//                         onPressed: () {
//                           controller.signInWithGoogle();
//                         },
//                         icon: Icon(
//                           Icons.g_mobiledata,
//                           size: 25.sp,
//                           color: Colors.black,
//                         ),
//                         label: const Text(
//                           "Sign In With Google",
//                           style: TextStyle(
//                             color: Colors.black,
//                           ),
//                         ),
//                         style: OutlinedButton.styleFrom(
//                           padding: EdgeInsets.symmetric(vertical: 12.h),
//                           side: BorderSide(color: Colors.grey),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 30.h),
//
//                     // Register Link
//                     Text.rich(
//                       TextSpan(
//                         text: "Don't have an account? ",
//                         children: [
//                           TextSpan(
//                             text: "Register",
//                             recognizer: TapGestureRecognizer()
//                               ..onTap = () {
//                                 Get.toNamed(AppRoute.signup);
//                               },
//                             style: const TextStyle(
//                               color: Color(0xff518cf7),
//                               fontWeight: FontWeight.bold,
//                               decoration: TextDecoration.underline,
//                               decorationColor: Color(0xff518cf7),
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:chat_app/Route/app_route.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    var loginKey = GlobalKey<FormState>();
    var controller = Get.put(LoginController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff6a11cb), Color(0xff2575fc)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20.w),
            width: 350.w,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome Back! ",
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 20.h),
                  Form(
                    key: loginKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(height: 10.h),
                        TextFormField(
                          controller: emailController,
                          validator: (val) =>
                              val!.isEmpty ? "Please enter your email." : null,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.grey[200],
                            hintText: "Enter your email",
                            prefixIcon:
                                const Icon(Icons.email, color: Colors.grey),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              //  borderSide: BorderSide.none,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 15.h, horizontal: 20.w),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text("Password",
                            style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                        SizedBox(height: 10.h),
                        Obx(() => TextFormField(
                              obscureText: controller.isPassword.value,
                              controller: passwordController,
                              validator: (val) =>
                                  val!.isEmpty ? "Password is required." : null,
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                hintText: "Enter your password",
                                prefixIcon:
                                    const Icon(Icons.lock, color: Colors.grey),
                                suffixIcon: IconButton(
                                  onPressed:
                                      controller.changeVisibilityPassword,
                                  icon: Icon(controller.isPassword.value
                                      ? Icons.visibility_off
                                      : Icons.visibility),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 20.w),
                              ),
                            )),
                        SizedBox(height: 30.h),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              if (loginKey.currentState!.validate()) {
                                controller.loginNewUser(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              }
                            },
                            child: Container(
                              height: 50.h,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color(0xff518cf7),
                              ),
                              alignment: Alignment.center,
                              child: Text("Login ",
                                  style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Align(
                          alignment: Alignment.center,
                          child: OutlinedButton.icon(
                            onPressed: controller.signInWithGoogle,
                            icon: Icon(Icons.g_mobiledata,
                                size: 25.sp, color: Colors.black),
                            label: const Text("Sign In With Google",
                                style: TextStyle(color: Colors.black)),
                            style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              side: BorderSide(color: Colors.grey),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Center(
                          child: Text.rich(
                            TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  color: Colors.black, fontSize: 16.sp),
                              children: [
                                TextSpan(
                                  text: "Register",
                                  recognizer: TapGestureRecognizer()
                                    ..onTap =
                                        () => Get.toNamed(AppRoute.signup),
                                  style: TextStyle(
                                      color: Color(0xff518cf7),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.sp,
                                      decoration: TextDecoration.underline),
                                )
                              ],
                            ),
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
      ),
    );
  }
}
