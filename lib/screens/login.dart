import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/providers/login_provider.dart';
import 'package:pocket_cinema_ticket/screens/home.dart';
import 'package:pocket_cinema_ticket/screens/register.dart';
import 'package:provider/provider.dart';
import '../components/alert_box.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  bool _visibility = true;

  final Map<String?, String?> _loginDetails = {
    "username": "",
    "password": "",
  };

  void _toogle() {
    setState(() {
      _visibility = !_visibility;
    });
  }

  void formSubmit(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      await Provider.of<LoginProvider>(context, listen: false).login(
        _loginDetails['username'].toString(),
        _loginDetails['password'].toString(),
      );
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (ctx) => const HomeScreen(),
        ),
      );
    } catch (e) {
      // Navigator.pop(context);
      final dialog = CustomAlertBox();
      dialog.normalAlertBox(
        context,
        "Username Or Password Was Incorrect",
      );
      setState(() {
        _isLoading = false;
      });
      // throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Form(
          key: _formKey,
          child: Center(
              child: SizedBox(
            width: w * .8,
            height: h * .5,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  gradient: const LinearGradient(
                      begin: Alignment.bottomRight,
                      end: Alignment.topLeft,
                      colors: [
                        Colors.deepPurple,
                        Colors.purple,
                      ])),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15.0,
                    ),
                    const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.orange,
                          fontWeight: FontWeight.bold,
                          fontSize: 32.0),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Username',
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0))),
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Username Required";
                          }
                          return null;
                        },
                        onSaved: (value) => _loginDetails['username'] = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: TextFormField(
                        obscureText: _visibility,
                        decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: _toogle,
                                icon: _visibility
                                    ? const Icon(Icons.visibility)
                                    : const Icon(Icons.visibility_off)),
                            hintText: 'Password',
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0))),
                        enabled: true,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        textInputAction: TextInputAction.done,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password Required";
                          }
                          if (value.length < 3) {
                            return "Password should have more than 3 characters";
                          }
                          return null;
                        },
                        onSaved: (value) => _loginDetails['password'] = value,
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: 140.0,
                      height: 42,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(18.0),
                          child: _isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ElevatedButton(
                                  onPressed: () => formSubmit(context),
                                  child: const Text("Sign In"))),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 3.0, horizontal: 15.0),
                      child: Row(
                        children: [
                          Text(
                            "Are you new ?",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const RegisterScreen(),
                              ),
                            ),
                            child: const Text(
                              "Register",
                              style: TextStyle(
                                  color: Colors.orange,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ))),
    );
  }
}
