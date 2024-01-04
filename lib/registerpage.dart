import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rapgemslite/loginpage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'otpfield.dart';

class registerpage extends StatefulWidget {
  const registerpage({Key? key}) : super(key: key);

  static String verify="";
  static String firstnameee = "";
  static String mobilenumber = "";
  static String email = "";
  static String password = "";
  static String nextimgurl = "";



  @override
  State<registerpage> createState() => _registerpageState();
}

class _registerpageState extends State<registerpage> {
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  TextEditingController name = TextEditingController();
  String imgurl = "";
  TextEditingController phoneno = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  String img = "";
  final ImagePicker _picker = ImagePicker();

  bool fname = false;
  bool fphoneno = false;
  bool femail = false;
  bool fpassword = false;

  String msg1 = "";
  String msg2 = "";
  String msg3 = "";
  String msg4 = "";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.3,
                  decoration: BoxDecoration(color: Colors.teal),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 30),
                            child: Text(
                              "BECOME A MEMBER",
                              style: GoogleFonts.lato(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "*FOR JEWELERS AND MEMBERS",
                                      style: GoogleFonts.alegreyaSc(
                                        fontSize: 20,
                                        color: Colors.grey.shade300,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "OF THE DIAMOND TRADE ONLY*",
                                      style: GoogleFonts.alegreyaSc(
                                        fontSize: 17,
                                        color: Colors.grey.shade300,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                              onTap: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);

                                setState(() {
                                  img = image!.path;
                                });
                              },
                              child: img.isEmpty
                                  ? CircleAvatar(
                                backgroundColor:
                                Colors.blueAccent.withOpacity(0.4),
                                radius: 40,
                                child: Icon(
                                  Icons.account_circle_outlined,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              )
                                  : CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                Colors.blueAccent.withOpacity(0.4),
                                backgroundImage: FileImage(File(img)),
                              )),
                        ],
                      ).marginOnly(bottom: 10)
                    ],
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            SizedBox(
                              width: 40,
                            ),
                            Text(
                              "Enter First Name",
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextField(
                                controller: name,
                                cursorColor: Color(0xfefae4b),
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xfefae4b))),
                                    errorText: fname ? msg1 : null,
                                    suffixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xfefae4b),
                                    ),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Mobile Number",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              TextField(

                                cursorColor: Color(0xfefae4b),
                                controller: phoneno,
                                style: TextStyle(),
                                enableSuggestions: false,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xfefae4b))),
                                    errorText: fphoneno ? msg2 : null,
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.phone,
                                          color: Color(0xfefae4b),
                                        )),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "E-mail",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              TextField(
                                cursorColor: Color(0xfefae4b),
                                controller: email,
                                style: TextStyle(),
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xfefae4b))),
                                    errorText: femail ? msg3 : null,
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.email,
                                          color: Color(0xfefae4b),
                                        )),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                        fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              TextField(
                                cursorColor: Color(0xfefae4b),
                                controller: password,
                                style: TextStyle(),
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Color(0xfefae4b))),
                                    errorText: fpassword ? msg4 : null,
                                    suffixIcon: IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                          Icons.remove_red_eye,
                                          color: Color(0xfefae4b),
                                        )),
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              RoundedLoadingButton(
                                color: Colors.teal,
                                duration: Duration(seconds: 1),
                                child: Text(' Register !',
                                    style: TextStyle(color: Colors.white)),
                                controller: _btnController,
                                resetAfterDuration: true,
                                successColor: Color(0xfefae4b),
                                onPressed: () async {

                                  String fnamee = name.text.toString();
                                  String Email = email.text.toString();
                                  String Password = password.text.toString();
                                  String phone = phoneno.text.toString();





                                  RegExp emailValid =
                                  RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

                                  fname = false;
                                  fphoneno = false;
                                  femail = false;
                                  fpassword = false;

                                  setState(() async {
                                    if (name.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Enter Name")));
                                    }

                                    else if (phoneno.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("Enter Phone no")));
                                    }
                                    else if (phoneno.text.length != 13) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("Phone no must be 10 digit")));
                                    }

                                    else if (email.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Enter Email")));
                                    }
                                    else if (!emailValid.hasMatch(email.text)) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Enter Valid Email")));
                                    }
                                    else if (password.text.isEmpty) {
                                      ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                              content: Text("Enter password")));
                                    } else {


                                      sendDetailToFirebase(Email, Password)
                                          .then((value) {
                                        email.clear();
                                        password.clear();
                                      });

                                      final ref = FirebaseStorage.instance
                                          .ref()
                                          .child('userimage')
                                          .child(
                                          "user${email.text}${Random().nextInt(2000)}.jpg");
                                      await ref.putFile(File(img));
                                      imgurl = await ref.getDownloadURL();

                                      final firestore = FirebaseFirestore.instance
                                          .collection("users");
                                      String id =
                                          "data${Random().nextInt(500)}${DateTime.now().millisecond}";
                                      firestore
                                          .doc(id)
                                          .set({
                                        "id": id,
                                        "firstname": "${name.text}",
                                        "contact": "${phoneno.text}",
                                        "email": "${email.text}",
                                        "password": "${password.text}",
                                        "userimage": "${imgurl}"
                                      })
                                          .onError((error, stackTrace) => {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                            content: Text("Not store")))
                                      });


                                      // await FirebaseAuth.instance.verifyPhoneNumber(
                                      //   phoneNumber: phone,
                                      //   verificationCompleted: (PhoneAuthCredential credential) {},
                                      //
                                      //   verificationFailed: (FirebaseAuthException e) {
                                      //
                                      //     ScaffoldMessenger.of(context).showSnackBar(
                                      //         SnackBar(content: Text("OTP Not sent")));
                                      //   },
                                      //   codeSent: (String verificationId, int? resendToken) {
                                      //
                                      //     registerpage.verify = verificationId;
                                      //     registerpage.firstnameee = fnamee;
                                      //     registerpage.email = Email;
                                      //     registerpage.mobilenumber = phone;
                                      //     registerpage.password = Password;
                                      //     registerpage.nextimgurl = img;
                                      //     ScaffoldMessenger.of(context).showSnackBar(
                                      //         SnackBar(content: Text("OTP sent successfully")));
                                      //     Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      //       return MyVerify();
                                      //     },));
                                      //   },
                                      //
                                      //   codeAutoRetrievalTimeout: (String verificationId) {},
                                      //
                                      // );



                                    }
                                  });
                                },
                              ),
                              TextButton(
                                  onPressed: () {
                                    Get.off(MyVerify(),
                                        duration: Duration(seconds: 2),
                                        transition: Transition.rightToLeft);
                                  },
                                  child: Text(
                                    "Click Here To Log-in",
                                    style: TextStyle(color: Colors.black),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Future<void> sendDetailToFirebase(String Email, String Password) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );
      Get.off(loginpage(),
          duration: Duration(seconds: 3), transition: Transition.leftToRight);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("REGISTER SUCCESFULLY"),
        // behavior: SnackBarBehavior.floating,
        // margin: EdgeInsets.only(bottom: 450, right: 100, left: 100),
        // elevation: 50,

        duration: Duration(seconds: 3),
      ));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Center(
              child: Text(
                "PASSEORD IS TOO WEAK",
                style: TextStyle(fontSize: 15),
              )),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.only(bottom: 450, right: 100, left: 100),

          duration: Duration(seconds: 2),
          // animation: Animation.fromValueListenable(CurvedAnimation(
          //     parent: kAlwaysCompleteAnimation,
          //     curve: Curves.easeInOutCubicEmphasized)),
        ));
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email already exist")));
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Center(
            child: Text(
              "EMAIL NOT VALID",
              style: TextStyle(fontSize: 15),
            )),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 450, right: 100, left: 100),
        elevation: 50,
        duration: Duration(seconds: 2),
      ));
    }
  }
}
