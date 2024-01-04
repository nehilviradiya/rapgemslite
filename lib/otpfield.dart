import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:lottie/lottie.dart';
import 'package:pinput/pinput.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rapgemslite/homepage.dart';
import 'package:rapgemslite/registerpage.dart';





class MyVerify extends StatefulWidget {
  const MyVerify({Key? key}) : super(key: key);

  @override
  State<MyVerify> createState() => _MyVerifyState();
}

class _MyVerifyState extends State<MyVerify> {

  final FirebaseAuth auth = FirebaseAuth.instance;
  String name = registerpage.firstnameee;
  String imgurl = "";


  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    var code="";

    return Scaffold(

      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.black,
          ),
        ),
        elevation: 0,

      ),
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset("lottie/otp1.json"),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone without getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Pinput(
                length: 6,
                // defaultPinTheme: defaultPinTheme,
                // focusedPinTheme: focusedPinTheme,
                // submittedPinTheme: submittedPinTheme,

                showCursor: true,
                onCompleted: (pin) => print(pin),
                onChanged: (value) {
                  code=value;
                },
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {


                      try{
                        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: registerpage.verify, smsCode: code);

                        // Sign the user in (or link) with the credential
                        await auth.signInWithCredential(credential);

                        sendDetailToFirebase(registerpage.email, registerpage.password)
                            .then((value) {
                          Get.off(homepage(),
                              duration: Duration(seconds: 3),
                              transition: Transition.leftToRight);
                        });

                        final ref = FirebaseStorage.instance
                            .ref()
                            .child('userimage')
                            .child(
                            "user${registerpage.email}${Random().nextInt(2000)}.jpg");
                        await ref.putFile(File(registerpage.nextimgurl));
                        imgurl = await ref.getDownloadURL();

                        final firestore = FirebaseFirestore.instance
                            .collection("users");
                        String id =
                            "data${Random().nextInt(500)}${DateTime.now().millisecond}";
                        firestore
                            .doc(id)
                            .set({
                          "id": id,
                          "firstname": "${registerpage.firstnameee}",
                          "contact": "${registerpage.mobilenumber}",
                          "email": "${registerpage.email}",
                          "password": "${registerpage.password}",
                          "userimage": "${registerpage.nextimgurl}"
                        })
                            .onError((error, stackTrace) => {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                              content: Text("Not store")))
                        });


                        // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                        //   return homepage();
                        // },));

                      }
                      catch(e){

                      }


                    },
                    child: Text("Verify Phone Number")),
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          'phone',
                          (route) => false,
                        );
                      },
                      child: Text(
                        "Edit Phone Number ?",
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendDetailToFirebase(String Email, String Password) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: Email,
        password: Password,
      );

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
