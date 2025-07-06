import 'package:deci_mate_decision_making_app/services/functions/auth_func.dart';
import 'package:deci_mate_decision_making_app/utils/colors.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  var email = '';
  var password = '';
  var username = '';
  bool isLoginPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(!isLoginPage ? 'Sign Up' : 'Login'),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(14),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 50),
              isLoginPage
                  ? Container()
                  : TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Valid Username';
                        } else {
                          return null;
                        }
                      },
                      onSaved: (value) {
                        username = value!;
                      },
                      keyboardType: TextInputType.emailAddress,
                      key: ValueKey('username'),
                      decoration: InputDecoration(
                        labelText: 'Enter Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(),
                        ),
                      ),
                    ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Valid Email';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  email = value!;
                },
                keyboardType: TextInputType.emailAddress,
                key: ValueKey('email'),
                decoration: InputDecoration(
                  labelText: 'Enter Email Address',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 10),
              TextFormField(
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Enter Valid Password';
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  password = value!;
                },
                obscureText: true,
                keyboardType: TextInputType.emailAddress,
                key: ValueKey('password'),
                decoration: InputDecoration(
                  labelText: 'Enter Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(AppColors.primary),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      isLoginPage
                          ? signIn(context, email, password)
                          : signUp(context, email, password, username);
                    }
                  },
                  child: Text(
                    isLoginPage ? 'Login' : 'Sign Up',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 6),
              TextButton(
                onPressed: () {
                  setState(() {
                    isLoginPage = !isLoginPage;
                  });
                },
                child: Text(
                  isLoginPage ? 'Sign Up' : 'Login',
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
