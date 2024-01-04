import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rapgemslite/homepage.dart';
import 'package:rapgemslite/registerpage.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class loginpage extends StatefulWidget {
  const loginpage({Key? key}) : super(key: key);

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool validate1 = false;
  bool validate2 = false;
  String nameerror = "";

  List diamond = ["Diamonds", "jewellery"];
  static const _iconTypes = <IconData>[
    Icons.diamond_outlined,
    Icons.ac_unit_rounded,
  ];

  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

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
                          "R A P G E M S.",
                          style: GoogleFonts.lato(
                            fontSize: 45,
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
                                  "Source & Sell",
                                  style: GoogleFonts.alegreyaSc(
                                    fontSize: 30,
                                    color: Colors.grey.shade300,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                Text(
                                  "DIAMONDS",
                                  style: GoogleFonts.alegreyaSc(
                                    fontSize: 25,
                                    color: Colors.grey.shade300,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 2,
                            child: Container(
                              child: ListView.builder(
                                itemCount: diamond.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    child: ListTile(
                                      focusColor: Colors.teal,
                                      trailing: Icon(_iconTypes[index]),
                                      title: Text(
                                        "${diamond[index]}",
                                        style: TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  );
                                },
                              ),
                              color: Colors.grey,
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.1),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 40,
                        ),
                        Text(
                          "Enter Email",
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
                            controller: email,
                            cursorColor: Color(0xfefae4b),
                            style: TextStyle(color: Colors.teal),
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfefae4b))),
                                suffixIcon: Icon(
                                  Icons.menu,
                                  color: Colors.teal,
                                ),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                errorText: validate1 ? nameerror : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusColor: Color(0xfefae4b)),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Enter Password",
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          TextField(
                            controller: password,
                            cursorColor: Color(0xfefae4b),
                            style: TextStyle(),
                            obscureText: true,
                            enableSuggestions: false,
                            autocorrect: false,
                            decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Color(0xfefae4b))),
                                suffixIcon: IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.remove_red_eye,color: Color(0xfefae4b),)),
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                errorText: validate2 ? nameerror : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RoundedLoadingButton(
                            color: Colors.teal,
                            duration: Duration(seconds: 1),
                            child: Text(' Log in !',
                                style: TextStyle(color: Colors.white)),
                            controller: _btnController,
                            resetAfterDuration: true,
                            animateOnTap: true,
                            successColor: Color(0xfefae4b),
                            onPressed: () async {
                              String Email = email.text.toString();
                              String Password = password.text.toString();
                              RegExp emailcheck = RegExp(
                                  r"^[a-zA-Z.a-zA-Z.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z]+\.[a-zA-Z]+");
                              setState(() async {
                                if (Email.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text("Enter Email")));
                                } else if (Password.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Enter Password")));
                                } else {
                                  try {
                                    final credential = await FirebaseAuth
                                        .instance
                                        .signInWithEmailAndPassword(
                                            email: Email, password: Password);

                                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                                      return homepage();
                                    },));
                                    // Get.off(homepage(),
                                    //     duration: Duration(seconds: 3),
                                    //     transition: Transition.leftToRight);
                                  } on FirebaseAuthException catch (e) {
                                    if (e.email == 'user-not-found') {
                                      print('No user found for that email.');
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "No user found for that email.")));
                                    } else if (e.phoneNumber ==
                                        'wrong-password') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text("wrong-password")));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "wrong-user or password")));
                                    }
                                  }
                                }
                              });
                            },
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context) {
                                        return registerpage();
                                      },
                                    ));
                                  },
                                  child: Text('Sign up',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.teal)),
                                ),
                                VerticalDivider(
                                  color: Colors.black,
                                  thickness: 1,
                                ),
                                Text('Forgot Password',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
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
}
//   Future<void> fetchdatatofirebase(String Email, String Password) async {
//
//
//
//   }
// }
