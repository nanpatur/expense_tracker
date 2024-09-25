import 'package:flutter/material.dart';
import 'dart:convert';
import 'home.dart';
import '../widgets/button.dart';
import '../widgets/text_form_field.dart';
import '../services/auth.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  late String username, password;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  _showMsg(msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  Widget _buildUsernameField() {
    return ETTextFormField(
        keyboardType: TextInputType.text,
        label: "Username",
        validator: (usernameValue) {
          if (usernameValue == null || usernameValue.isEmpty) {
            return 'Please enter your username';
          }
          username = usernameValue;
          return null;
        });
  }

  Widget _buildPasswordField() {
    return ETTextFormField(
        keyboardType: TextInputType.text,
        obscureText: _secureText,
        label: "Password",
        suffixIcon: IconButton(
          onPressed: showHide,
          icon: Icon(_secureText ? Icons.visibility_off : Icons.visibility),
        ),
        validator: (passwordValue) {
          if (passwordValue == null || passwordValue.isEmpty) {
            return 'Please enter your password';
          }
          password = passwordValue;
          return null;
        });
  }

  Widget _buildLoginButton() {
    return ETButton(
        text: _isLoading ? 'Proccessing..' : 'Login',
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _login();
          }
        },
        variant:
            _isLoading ? ETButtonVariant.disabled : ETButtonVariant.primary);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 72),
              child: Column(
                children: [
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_circle_left,
                            size: 46,
                            color: Colors.black,
                          ),
                          padding: const EdgeInsets.all(0),
                        ),
                        const SizedBox(height: 18),
                        const Text(
                          "Welcome back! Glad to see you again.",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 46),
                        _buildUsernameField(),
                        const SizedBox(height: 18),
                        _buildPasswordField(),
                        const SizedBox(height: 8),
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        const SizedBox(height: 28),
                        _buildLoginButton(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Does'nt have an account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     new MaterialPageRoute(
                          //         builder: (context) => Register()));
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            decoration: TextDecoration.none,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ))),
    );
  }

  void _login() async {
    setState(() {
      _isLoading = true;
    });
    var data = {'username': username, 'password': password};

    var res = await Network().login(data);
    if (res.statusCode == 200) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      var body = json.decode(res.body);
      _showMsg(body['message']);
    }

    setState(() {
      _isLoading = false;
    });
  }
}
