// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:chatchain/Screens/home_page.dart';
import 'package:chatchain/Services/firebase_auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_verification_code/flutter_verification_code.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_auth/email_auth.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;

import '../Classes/userr.dart';
import '../animation/fadeAnimation.dart';
import '../constants.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  static String id = "signup_page";

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int currentStep = 0;
  DateTime _dateTime = DateTime.now();
  late String name = "";
  late String surname = "";
  late String dateOfBirth = _dateTime.day.toString() +
      "/" +
      _dateTime.month.toString() +
      "/" +
      _dateTime.year.toString();
  late String profileImage = "";

  late String email = "";
  late String password = "";
  late String confirm_password = "";
  bool showPassword = false;

  File? _image;

  late EmailAuth emailAuth;
  late String verificationCode = "";
  bool isVerified = false;
  bool isOver18 = false;

  bool _onEditing = true;

  var path = null;
  var fileName = null;

  Future<File?> getPhoto(bool isCamera) async {
    final XFile? image;
    if (isCamera) {
      image = await ImagePicker().pickImage(source: ImageSource.camera);
    } else {
      image = await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    final File? file = File(image!.path);
    return file;
  }

  void sendOTP() async {
    emailAuth = new EmailAuth(sessionName: "Chat Chain");
    var result = await emailAuth.sendOtp(recipientMail: email);
    if (result) {
      print("oTP SEND");
    } else {
      print("ERROR");
    }
  }

  Future uploadFile(String filePath, String fileName, String uid) async {
    File file = File(filePath);

    try {
      await FirebaseStorage.instance
          .ref('Users/$uid')
          .child('$fileName')
          .putFile(file);

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .update({'image': fileName});
    } on firebase_core.FirebaseException catch (e) {}
  }

  bool isAgeOver18(String date) {
    String year = date.substring(date.length - 4);

    int intYear = int.parse(year);
    if (DateTime.now().year - intYear >= 18) {
      setState(() {
        isOver18 = true;
      });
    } else {
      setState(() {
        isOver18 = false;
      });
    }
    return isOver18;
  }

  bool isEmail(String email) {
    if (email.contains("@")) {
      return true;
    }

    return false;
  }

  bool isPassword(String password) {
    if (password.length >= 8) {
      return true;
    }

    return false;
  }

  bool isPasswordConfirmd(String password, String confrimPassword) {
    if (password == confrimPassword) {
      return true;
    }
    return false;
  }

  bool isStep1ButtonActive(String date) {
    return isAgeOver18(date) && name.length >= 2 && surname.length >= 2;
  }

  bool isStep2ButtonActive(
      String email, String password, String confrimPassword) {
    return (isEmail(email) &&
        isPassword(password) &&
        isPasswordConfirmd(password, confrimPassword));
  }

  Future<bool> verifyOTP(String code) async {
    var result = emailAuth.validateOtp(recipientMail: email, userOtp: code);
    if (result) {
      print("otp verified");
      setState(() {
        isVerified = true;
      });
      return true;
    } else {
      print("Invalid");
      return false;
    }
    return false;
  }

  List<Step> getSteps() => [
        Step(
            isActive: currentStep >= 0,
            title: Text('Information'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Name",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    onChanged: ((value) {
                      setState(() {
                        name = value;
                      });
                    }),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      hintText: 'Enter Name',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.abc,
                        color: Colors.red,
                        size: 25,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Surname",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    onChanged: ((value) {
                      setState(() {
                        surname = value;
                      });
                    }),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      //labelText: 'Hash Value',
                      hintText: 'Enter Surname',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.abc,
                        color: Colors.red,
                        size: 25,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Date Of Birth",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: InkWell(
                    onTap: () {
                      showDatePicker(
                              context: context,
                              initialDate: _dateTime,
                              firstDate: DateTime(1950),
                              lastDate: DateTime(2050))
                          .then((date) {
                        setState(() {
                          _dateTime = date!;
                          dateOfBirth = _dateTime.day.toString() +
                              "/" +
                              _dateTime.month.toString() +
                              "/" +
                              _dateTime.year.toString();
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(children: [
                        Icon(
                          Icons.calendar_month,
                          color: Colors.red,
                          size: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          _dateTime.day.toString() +
                              "/" +
                              _dateTime.month.toString() +
                              "/" +
                              _dateTime.year.toString(),
                          style: TextStyle(fontSize: 20),
                        )
                      ]),
                    ),
                  ),
                ),
                Text(
                  "Profile Image",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            color: kappLightDarkenColor,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () async {
                                      //ProfilePage.camera = true;
                                      File? file = await getPhoto(true);
                                      setState(() {
                                        _image = file;
                                      });

                                      setState(() {});
                                    },
                                    child: ListTile(
                                      leading: Text("Take photos"),
                                      trailing: Icon(Icons.camera_enhance),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      // ProfilePage.file = true;

                                      final results = FilePicker.platform
                                          .pickFiles(
                                              allowMultiple: false,
                                              type: FileType.custom,
                                              allowedExtensions: [
                                            'png',
                                            'jpg'
                                          ]).then((value) {
                                        setState(() {
                                          path = value?.files.single.path;
                                          fileName = value?.files.single.name;
                                        });
                                      });

                                      File? file = await getPhoto(false);
                                      setState(() {
                                        _image = file;
                                      });

                                      setState(() {});
                                    },
                                    child: ListTile(
                                      leading: Text("Choose photo"),
                                      trailing: Icon(Icons.folder),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      setState(() {
                                        _image = null;
                                      });

                                      setState(() {});
                                    },
                                    child: ListTile(
                                      leading: Text(
                                        "Remove photo",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      trailing: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 80.0,
                      backgroundImage: _image == null
                          ? AssetImage('assets/images/no-profile.png')
                          : FileImage(_image!) as ImageProvider,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 1,
            title: Text('Account'),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "E-mail",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        email = value;
                        isStep2ButtonActive(email, password, confirm_password);
                      });
                    },
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      hintText: 'Enter E-mail Address',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.red,
                        size: 25,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Password",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    onChanged: ((value) {
                      setState(() {
                        password = value;
                        isStep2ButtonActive(email, password, confirm_password);
                      });
                    }),
                    obscureText: showPassword == false ? true : false,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      //labelText: 'Hash Value',
                      hintText: 'Enter Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.red,
                        size: 25,
                      ),
                      suffixIcon: InkWell(
                          onTap: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                          child: Icon(Icons.remove_red_eye, color: Colors.red)),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Confirm Password",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        confirm_password = value;
                        isStep2ButtonActive(email, password, confirm_password);
                      });
                    },
                    obscureText: true,
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(0.0),
                      //labelText: 'Hash Value',
                      hintText: 'Confirm Password',
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400,
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 14.0,
                      ),
                      prefixIcon: Icon(
                        Icons.keyboard_control_sharp,
                        color: Colors.red,
                        size: 25,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.grey.shade400, width: 2),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      floatingLabelStyle: TextStyle(
                        color: Colors.red,
                        fontSize: 18.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 1.5),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ],
            )),
        Step(
            isActive: currentStep >= 2,
            title: Text('Overivew'),
            content: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          alignment: Alignment.center,
                          child: CircleAvatar(
                            radius: 90.0,
                            backgroundImage: _image == null
                                ? AssetImage('assets/images/no-profile.png')
                                : FileImage(_image!) as ImageProvider,
                            backgroundColor: Colors.transparent,
                          ),
                        ),
                        Text(
                          "Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(name)),
                        Text(
                          "Surname",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(surname)),
                        Text(
                          "Date of birth",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(dateOfBirth)),
                        Text(
                          "E-mail",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16),
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(vertical: 10),
                            child: Text(email)),
                      ]),
                )
              ],
            )),
        Step(
            isActive: currentStep >= 3,
            title: Text('Verification'),
            content: Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "We send a verification code to -email address-",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: VerificationCode(
                      textStyle:
                          TextStyle(fontSize: 20.0, color: Colors.red[900]),
                      keyboardType: TextInputType.number,
                      underlineColor: Colors
                          .red, // If this is null it will use primaryColor: Colors.red from Theme
                      length: 6,
                      cursorColor: Colors
                          .black, // If this is null it will default to the ambient
                      // clearAll is NOT required, you can delete it
                      // takes any widget, so you can implement your design
                      clearAll: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          'clear all',
                          style: TextStyle(
                              fontSize: 14.0,
                              decoration: TextDecoration.underline,
                              color: Colors.blue[700]),
                        ),
                      ),
                      onCompleted: (String value) async {
                        setState(() {
                          verificationCode = value;
                          verifyOTP(verificationCode);
                        });
                        if (isVerified) {
                          final User? currentUser = (await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                      email: email, password: password))
                              .user;
                          if (currentUser != null) {
                            await FirebaseFirestore.instance
                                .collection("Users")
                                .doc(currentUser.uid)
                                .set({
                              'uid': currentUser.uid,
                              'name': name,
                              'surname': surname,
                              'date_of_birth': dateOfBirth,
                              'image': fileName == null ? "" : fileName,
                              'email': email,
                              'network_image': ""
                            });

                            uploadFile(path, fileName, currentUser.uid)
                                .then((value) => print("Done"));

                            Userr? user =
                                await FirebaseAuthService().getUserData();

                            await FirebaseFirestore.instance
                                .collection('Users')
                                .doc(currentUser.uid)
                                .update({'network_image': user!.photoUrl});

                            setState(() {
                              Userr.sUid = currentUser.uid;

                              Userr.sdate_of_birth = dateOfBirth;
                              Userr.semail = email;
                              Userr.sname = name;
                              Userr.sphotoUrl = fileName;
                              Userr.ssurname = surname;
                            });
                          }
                          print("Sign Up user null geldi");
                        }
                      },
                      onEditing: (bool value) {
                        setState(() {
                          _onEditing = value;
                        });
                        if (!_onEditing) FocusScope.of(context).unfocus();
                      },
                    ),
                  )
                ])
              ],
            )),
        Step(
            isActive: currentStep >= 4,
            title: Text("Hash Value"),
            content: Column(
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "This is your hash value. You must to keep this to log in",
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                  ),
                ])
              ],
            )),
      ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: Column(
                    children: [
                      FadeAnimation(
                          1,
                          Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      FadeAnimation(
                          1.2,
                          Text(
                            "Create your account",
                            style: TextStyle(
                                fontSize: 15, color: Colors.grey[700]),
                          )),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: FadeAnimation(
                  2,
                  Stepper(
                    /* onStepTapped: (val) {
                      setState(() {
                        if (val != 4) {
                          currentStep = val;
                        }
                      });
                    },
                    */
                    physics: ClampingScrollPhysics(),
                    currentStep: currentStep,
                    type: StepperType.vertical,
                    steps: getSteps(),
                    controlsBuilder:
                        (BuildContext context, ControlsDetails details) {
                      return Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              onPressed: details.onStepContinue,
                              child: (() {
                                switch (currentStep) {
                                  case 0:
                                    return Text("Continue");

                                  case 1:
                                    return Text("Continue");

                                  case 2:
                                    return Text("Verify Email");

                                  case 3:
                                    return Text("Get Hash");

                                  case 4:
                                    return Text("Lets Chat");

                                  default:
                                }
                              }()),
                              /*currentStep != 3
                                  ? Text(
                                      currentStep == 2 ? 'Verify' : "Continue")
                                  : Text("Get Hash"),
                                  */
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          if (currentStep > 0 && currentStep != 4)
                            !isVerified
                                ? Expanded(
                                    child: ElevatedButton(
                                      onPressed: details.onStepCancel,
                                      child: Text(currentStep == 3
                                          ? 'Re-send'
                                          : 'Back'),
                                    ),
                                  )
                                : SizedBox()

                          //&& currentStep != 4
                        ],
                      );
                    },
                    onStepContinue: (() {
                      switch (currentStep) {
                        case 0:
                          return isStep1ButtonActive(dateOfBirth) == true
                              ? () {
                                  setState(() {
                                    currentStep += 1;
                                  });
                                }
                              : null;

                        case 1:
                          return isStep2ButtonActive(
                                      email, password, confirm_password) ==
                                  true
                              ? () {
                                  setState(() {
                                    currentStep += 1;
                                  });
                                }
                              : null;

                        case 2:
                          return () async {
                            sendOTP();
                            setState(() {
                              currentStep += 1;
                            });
                          };

                        case 3:
                          return isVerified
                              ? () {
                                  if (isVerified) {
                                    setState(() {
                                      currentStep += 1;
                                    });
                                  }
                                }
                              : null;

                        case 4:
                          return () {
                            setState(() {});
                            Navigator.pushNamed(context, HomePage.id);
                          };

                        default:
                      }
                    }()),

                    /*() async {
                      final lastStep = currentStep == getSteps().length - 1;

                      if (lastStep) {
                        // firebase

                      } else {
                        setState(() {
                          currentStep += 1;
                        });
                      }

                      if (currentStep == 3) {
                        sendOTP();
                      }
                    },*/
                    onStepCancel: () {
                      final firstStep = currentStep == 0;
                      if (firstStep) {
                      } else {
                        if (currentStep == 3) {
                          setState(() {
                            verificationCode = "";
                            isVerified = false;
                            sendOTP();
                          });
                        } else {
                          setState(() {
                            currentStep -= 1;
                          });
                        }
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
