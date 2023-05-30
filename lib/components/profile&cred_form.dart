// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:pocket_cinema_ticket/components/alert_box.dart';
import 'package:pocket_cinema_ticket/providers/login_provider.dart';
import 'package:pocket_cinema_ticket/providers/profile.dart';
import 'package:provider/provider.dart';

class ProfileCredentialForm extends StatefulWidget {
  final String formtype;
  const ProfileCredentialForm({required this.formtype, super.key});

  @override
  State<ProfileCredentialForm> createState() => _ProfileCredentialFormState();
}

class _ProfileCredentialFormState extends State<ProfileCredentialForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  bool isLoading = false;

  Map<String, String?> profileDetails = {
    'full_name': "",
    'email': "",
    'phone': "",
    'username': "",
  };

  Map<String, String> changePwDetails = {
    'old_password': "",
    'new_password': "",
  };

  void changePwFormSubmit(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() => isLoading = true);
      await Provider.of<LoginProvider>(context, listen: false)
          .changePassword(
            context,
            changePwDetails['old_password']!,
            changePwDetails['new_password']!,
          )
          .then((_) => setState(() => isLoading = false))
          .then((_) => CustomAlertBox().regularAlertBox(context, "Successfull",
              "Your Password was changed successfully"));
      Navigator.pop(context);
    } catch (e) {
      print(e);
      await CustomAlertBox()
          .normalAlertBox(context, "Please create a unique password.");
      Navigator.of(context).pop();
    }
  }

  void profileFormSubmit(BuildContext context) async {
    try {
      if (!_formKey.currentState!.validate()) {
        return;
      }
      _formKey.currentState!.save();
      setState(() {
        isLoading = true;
      });
      await Provider.of<ProfileProvider>(context, listen: false)
          .editProile(
            context,
            username: profileDetails['username'],
            email: profileDetails['email'],
            phone: profileDetails['phone'],
            fullName: profileDetails['full_name'],
          )
          .then((_) => setState(() {
                isLoading = false;
              }))
          .then((_) => CustomAlertBox().regularAlertBox(
              context, "Alert", "Successfully Edited Profile"));

      Navigator.pop(context);
    } catch (e) {
      await CustomAlertBox().normalAlertBox(context, "Something went wrong!!");
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .5,
      child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: widget.formtype == "profile"
                ? ProfileForm(
                    loader: isLoading,
                    profileCred: profileDetails,
                    submit: () => profileFormSubmit(context),
                  )
                : Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Do Not Leave This Field Empty";
                            }
                            return null;
                          },
                          onSaved: (value) => changePwDetails['old_password'] =
                              value.toString(),
                          decoration: InputDecoration(
                              hintText: "Old Password",
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: TextFormField(
                          obscureText: true,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.black87),
                          onSaved: (value) => changePwDetails['new_password'] =
                              value.toString(),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please Do Not Leave This Field Empty";
                            }
                            if (value.length < 4) {
                              return "There should be atleast 4 characters in your passwords";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              hintText: "New Password",
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0))),
                        ),
                      ),
                      isLoading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              width: 150,
                              child: ElevatedButton(
                                  onPressed: () => changePwFormSubmit(context),
                                  child: const Text("Save")))
                    ],
                  ),
          )),
    );
  }
}

class ProfileForm extends StatefulWidget {
  const ProfileForm({
    required this.profileCred,
    required this.submit,
    required this.loader,
    super.key,
  });

  final VoidCallback submit;
  final Map<String, String?> profileCred;
  final bool loader;

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter Your Full Name";
              }
              return null;
            },
            onSaved: (value) => widget.profileCred['full_name'] = value,
            decoration: InputDecoration(
                hintText: "Full Name",
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            validator: (value) {
              if (!value!.endsWith("@gmail.com")) {
                return "Do Not Leave This Field Empty";
              }
              return null;
            },
            onSaved: (value) => widget.profileCred['email'] = value,
            decoration: InputDecoration(
                hintText: "Email",
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            validator: (value) {
              if (value.runtimeType == int) {
                return "Please Use Correct Type For Numbers";
              }
              return null;
            },
            onSaved: (value) => widget.profileCred['phone'],
            decoration: InputDecoration(
                hintText: "Phone",
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.name,
            style: const TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.normal,
                color: Colors.black87),
            onSaved: (value) => widget.profileCred['username'] = value,
            decoration: InputDecoration(
                hintText: "Username",
                filled: true,
                fillColor: Colors.grey.shade300,
                border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
        widget.loader == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SizedBox(
                width: 150,
                child: ElevatedButton(
                    onPressed: widget.submit, child: const Text("Save")))
      ],
    );
  }
}
