import 'dart:convert';
import 'package:bluemark/Common/widgets/custom_button.dart';
import 'package:bluemark/Common/widgets/custom_textfield.dart';
import 'package:bluemark/Features/auth/screens/referral_screen.dart';
import 'package:bluemark/constants/global_variables.dart';
import 'package:bluemark/constants/utils.dart';
import 'package:bluemark/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../main.dart';

enum Auth { signin, signup }

class CustomerAuthScreen extends StatefulWidget {
  const CustomerAuthScreen({Key? key}) : super(key: key);

  @override
  State<CustomerAuthScreen> createState() => _CustomerAuthScreenState();
}

class _CustomerAuthScreenState extends State<CustomerAuthScreen> {
  bool _isSecurePassword = true;
  bool _isSecureConfirmPassword = true;
  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    _confirmPasswordController.dispose();
    _otpController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
    Navigator.push(context, MaterialPageRoute(builder: (_)=> ReferralScreen()));
  }

  void signInUser(){
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  Future <void> sendOTP() async {
    final email = _emailController.text;
    final response = await http.post(
      Uri.parse('${uri}/sendOTP'), // Replace with your Node.js server URL
      body: {'email': email},
    );

    if (response.statusCode == 200) {
      // OTP sent successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP sent successfully')),
      );
      showDialog(context: context, builder: (context) {
        return AlertDialog(title: Text("Enter OTP"),
          content: TextFormField(controller: _otpController, maxLength: 6, keyboardType: TextInputType.number, decoration: InputDecoration(hintText: "Enter OTP sent to ${_emailController.text}", border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black38))),),
          actions: [
            TextButton(onPressed: (){verifyOTP();}, child: Text("Verify OTP")),
            TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: Text("Cancel")),
          ],
        );
      });
    } else {
      // Handle error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to send OTP')),
      );
    }
  }

  Future <void> verifyOTP() async {
    final email = _emailController.text;
    final userOTP = _otpController.text;
    final response = await http.post(
      Uri.parse('${uri}/verifyOTP'), // Replace with your Node.js server URL
      body: {
        'email': email,
        'otp': userOTP,
      },
    );

    if (response.statusCode == 200) {
      // OTP is valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('OTP is valid')),
      );
      signUpUser();
    } else {
      // Invalid OTP
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid OTP or OTP has expired')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Login Page",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Image.asset('images/icon.png', scale: 2.5,),

              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                tileColor: _auth == Auth.signup
                    ? GlobalVariables.backgroundColor
                    : Colors.white,
                title: Text(
                  "Create Account",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signUpFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _nameController,
                          hintText: "Name",
                        ),
                        SizedBox(height: 15),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          obscureText: _isSecurePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: togglePassword(),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              )
                          ),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          obscureText: _isSecureConfirmPassword,
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                              hintText: "Confirm Password",
                              suffixIcon: toggleConfirmPassword(),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              )
                          ),
                        ),
                        // Text("These Details cannot be changed later!"),
                        SizedBox(height: 15),
                        CustomButton(
                            text: "Create Account",
                            // onTap: (){
                            //   if (_signUpFormKey.currentState!.validate() && _confirmPasswordController.text == _passwordController.text && _passwordController.text.length >= 8) {
                            //     signUpUser();
                            //   } else if (_confirmPasswordController.text != _passwordController.text) {
                            //     showSnackBar(context, "Passwords doesn't match");
                            //   } else if(_passwordController.text.length < 8) {
                            //     showSnackBar(context, "Password should be at least 8 character long!");
                            //   } else {
                            //     showSnackBar(context, "Unknown Error!");
                            //   }
                            // },

                          onTap: (){
                              if(_signUpFormKey.currentState!.validate() && _confirmPasswordController.text == _passwordController.text && _passwordController.text.length >= 8) {
                                sendOTP();
                              } else if(_confirmPasswordController.text != _passwordController.text) {
                                showSnackBar(context, "Passwords doesn't match");
                              } else if(_passwordController.text.length < 8) {
                                showSnackBar(context, "Password should be at least 8 characters long!");
                              } else {
                                showSnackBar(context, "Unknown Error!");
                              }
                          },


                            // onTap: () {
                            //   if (_signUpFormKey.currentState!.validate() && _confirmPasswordController.text == _passwordController.text) {
                            //     authService.otpLogin(_emailController.text).then((response){
                            //       if(response.data != null) {
                            //         showDialog(
                            //             context: context,
                            //             builder: (context) {
                            //               return AlertDialog(
                            //                 title: Text(
                            //                   "Enter OTP",
                            //                 ),
                            //                 content: TextFormField(
                            //                   controller: _otpController,
                            //                   maxLength: 4,
                            //                   keyboardType: TextInputType.number,
                            //                   decoration: InputDecoration(
                            //                       hintText: "Enter OTP sent to ${_emailController.text}",
                            //                       border: OutlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.black38
                            //                           )
                            //                       ),
                            //                       enabledBorder: OutlineInputBorder(
                            //                           borderSide: BorderSide(
                            //                               color: Colors.black38
                            //                           )
                            //                       )
                            //                   ),
                            //                 ),
                            //                 actions: [
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       if (response.data != null)
                            //                       {authService.verifyOTP(_emailController.text, response.data!, _otpController.text).then((response){
                            //                         Navigator.pop(context);
                            //                         signUpUser();
                            //                       });}
                            //                       else {
                            //                         showSnackBar(context, "Invalid OTP!");
                            //                       }
                            //                     } ,
                            //                     child: Text("Verify"),
                            //                   ),
                            //                   TextButton(
                            //                     onPressed: () {
                            //                       Navigator.of(context).pop();
                            //                     },
                            //                     child: Text("Cancel"),
                            //                   ),
                            //                 ],
                            //               );
                            //             });
                            //       }
                            //     });
                            //   }
                            //   else if(_confirmPasswordController.text != _passwordController.text) {
                            //     showSnackBar(context, "Passwords doesn't match!");
                            //   }
                            // }
                            )
                      ],
                    ),
                  ),
                ),
              ListTile(
                title: Text(
                  "Sign In",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
                leading: Radio(
                  activeColor: GlobalVariables.secondaryColor,
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Container(
                  padding: EdgeInsets.all(8),
                  color: GlobalVariables.backgroundColor,
                  child: Form(
                    key: _signInFormKey,
                    child: Column(
                      children: [
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email",
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          obscureText: _isSecurePassword,
                          controller: _passwordController,
                          decoration: InputDecoration(
                              hintText: "Password",
                              suffixIcon: togglePassword(),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.black38
                                  )
                              )
                          ),
                        ),
                        SizedBox(height: 15),
                        CustomButton(text: "Sign In", onTap: () {if (_signInFormKey.currentState!.validate()) {
                          signInUser();
                        }

                        })
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
  Widget togglePassword(){
    return IconButton(onPressed: (){setState(() {
      _isSecurePassword = !_isSecurePassword;
    });}, icon: _isSecurePassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility), color: Colors.grey,);
  }
  Widget toggleConfirmPassword(){
    return IconButton(onPressed: (){setState(() {
      _isSecureConfirmPassword = !_isSecureConfirmPassword;
    });}, icon: _isSecureConfirmPassword ? Icon(Icons.visibility_off) : Icon(Icons.visibility), color: Colors.grey,);
  }
}
