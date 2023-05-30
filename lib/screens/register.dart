import 'package:flutter/material.dart';
import '../providers/register_provider.dart';
import 'package:provider/provider.dart';
import '../components/alert_box.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegiterScreenState();
}

class _RegiterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool _isLoading = false;
  bool _visibility = true;

  final Map<String?, String?> _registerDetails = {
    "username": "",
    "password": "",
    "email": "",
    "full_name": "",
    "phone": "",
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
      await Provider.of<RegisterProvider>(context, listen: false).registerUser(
        username: _registerDetails['username'].toString(),
        password: _registerDetails['password'].toString(),
        email: _registerDetails['email'].toString(),
        fullName: _registerDetails['full_name'].toString(),
        phone: _registerDetails['phone'].toString(),
      );
      setState(() {
        _isLoading = false;
      });
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
    } catch (e) {
      // Navigator.pop(context);
      final dialog = CustomAlertBox();
      dialog.normalAlertBox(
        context,
        "Please Do not leave any field empty!",
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
            width: w * .85,
            height: h * .85,
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
                      "Register",
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
                        onSaved: (value) =>
                            _registerDetails['username'] = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Colors.grey.shade300,
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                        ),
                        keyboardType: TextInputType.name,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email Required";
                          }
                          if (!value.endsWith('@gmail.com')) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                        onSaved: (value) => _registerDetails['email'] = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Full Name',
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
                            return "Fullname Required";
                          }
                          return null;
                        },
                        onSaved: (value) =>
                            _registerDetails['full_name'] = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10.0),
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Phone',
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(25.0))),
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.black87),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Phone Required";
                          }
                          return null;
                        },
                        onSaved: (value) => _registerDetails['phone'] = value,
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
                        onSaved: (value) =>
                            _registerDetails['password'] = value,
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
                                child: const Text("Sign In"),
                              ),
                      ),
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
                            "Already a user ?",
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: const Text(
                              "Login",
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
