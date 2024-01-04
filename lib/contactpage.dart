import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class contactpage extends StatefulWidget {
  const contactpage({Key? key}) : super(key: key);

  @override
  State<contactpage> createState() => _contactpageState();
}

class _contactpageState extends State<contactpage> {
  final RoundedLoadingButtonController _btnController =
      RoundedLoadingButtonController();

  TextEditingController name =TextEditingController();
  TextEditingController query =TextEditingController();
  TextEditingController email =TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffB0B9BF),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("Contact Us",
                style: GoogleFonts.alegreyaSc(
                  fontSize: 25,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                )),
            Container(margin: EdgeInsets.only(right: 15,left: 15),
              child: TextField(
                controller: name,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Enter your name",

                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(margin: EdgeInsets.only(right: 15,left: 15),
              child: TextField(
                controller: email,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Enter your Email",
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 15,left: 15),
              child: TextFormField(
                controller: query,
                maxLines: 3,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    hintText: "Enter your Query",
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            RoundedLoadingButton(
              color: Colors.teal,
              duration: Duration(seconds: 1),
              child: Text(' Submit !', style: TextStyle(color: Colors.white)),
              controller: _btnController,
              resetAfterDuration: true,
              successColor: Colors.blue,
              onPressed: () {

                if(name.text.isEmpty)
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Enter Name")));
                  }
                else if(email.text.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Enter Email")));
                }
                else if(query.text.isEmpty)
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill The Query")));
                }
                else
                  {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Thanks For the Contact")));
                  }


              },
            ),
            Row(
              children: [
                Expanded(
                    child: Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      Text("Our Main Office",
                          style: GoogleFonts.alegreyaSc(
                            fontSize: 15,
                            color: Colors.indigoAccent,
                            fontWeight: FontWeight.w700,
                          )),
                      Text(
                          "Diamond Bourse DREAM City, near International Exhibition ,Surat",
                          softWrap: true,
                          style: GoogleFonts.alegreyaSc(
                            fontSize: 10,
                            color: Colors.indigoAccent,

                          ))
                    ],
                  ),
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: InkWell(onTap: () async {
                      await  FlutterPhoneDirectCaller.callNumber('+91 8401705481');
                    },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Icon(
                              Icons.phone,
                              color: Colors.blue,
                            ),
                            Text("Tap to call",
                                style: GoogleFonts.alegreyaSc(
                                  fontSize: 15,
                                  color: Colors.indigoAccent,
                                  fontWeight: FontWeight.w700,
                                )),
                            Text(
                                "+91 8401705481",
                                softWrap: true,
                                style: GoogleFonts.alegreyaSc(
                                  fontSize: 10,
                                  color: Colors.indigoAccent,

                                ))
                          ],
                        ),
                      ),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
