import 'package:flutter/material.dart';
import '../../../Common/widgets/custom_button.dart';
import '../../../Common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../../main.dart';
import '../../../services/auth_service.dart';

enum Auth { signin, signup }

class AdminAuthScreen extends StatefulWidget {
  const AdminAuthScreen({Key? key}) : super(key: key);

  @override
  State<AdminAuthScreen> createState() => _AdminAuthScreenState();
}

class _AdminAuthScreenState extends State<AdminAuthScreen> {
  bool _isSecurePassword = true;

  Auth _auth = Auth.signup;
  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void signUpUser() {
    authService.signUpUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signInUser(){
    authService.signInUser(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("Admin Login Page", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Text(
                  "Welcome Admin",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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

                        }),
                      ],
                    ),
                  ),
                ),
              SizedBox(height: 25,),
              Container(alignment: Alignment.center, child: Text("If User is detected will automatically Log in as User!", style: TextStyle(fontWeight: FontWeight.w500),),)
            ],
          ),
        ),
      ),
    );
  }

  Widget togglePassword(){
    return IconButton(onPressed: (){setState(() {
      _isSecurePassword = !_isSecurePassword;
    });}, icon: _isSecurePassword ? Icon(Icons.visibility) : Icon(Icons.visibility_off), color: Colors.grey,);
  }
}
