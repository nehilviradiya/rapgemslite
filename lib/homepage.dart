import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:rapgemslite/contactpage.dart';
import 'package:rapgemslite/loginpage.dart';
import 'package:rapgemslite/rapchat.dart';

import 'package:rapgemslite/showdiamond.dart';
import 'package:shrink_sidemenu/shrink_sidemenu.dart';

import 'cart.dart';

import 'menupage.dart';
import 'orderpage.dart';

class homepage extends StatefulWidget {
  const homepage({Key? key}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  int page = 0;
  List<Widget> ll = [showdiamond(), cart(), menupage()];
  final ImagePicker _picker = ImagePicker();
  String img = "";
  FirebaseDatabase database = FirebaseDatabase.instance;

  final GlobalKey<SideMenuState> sideMenuKey = GlobalKey<SideMenuState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: AdvancedDrawer(
      backdropColor: Colors.white,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      // openScale: 1.0,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 0.0,
        //   ),
        // ],
        borderRadius: const BorderRadius.all(Radius.circular(16)),
      ),
      child: Scaffold(
        body: ll[page],
        bottomNavigationBar: CurvedNavigationBar(
          backgroundColor:  Colors.teal,
          items: <Widget>[
            Column(
              children: [
                Icon(Icons.diamond_outlined, size: 30,color: Colors.teal,),
                Text("Diamonds",style: TextStyle(fontSize: 10),)
              ],
            ),
            Column(
              children: [
                Icon(Icons.flood_rounded, size: 30,color:Colors.teal,),
                Text("Company",style: TextStyle(fontSize: 10),)
              ],
            ),
            Column(
              children: [
                Icon(Icons.handshake_outlined, size: 30,color: Colors.teal,),
                Text("Favourite",style: TextStyle(fontSize: 10),)
              ],
            ),
          ],
          onTap: (index) {
            setState(() {
              page = index;
            });
            //Handle button tap
          },
        ),
        appBar: AppBar(
          elevation: 5,
          centerTitle: true,
          titleSpacing: 5,
          backgroundColor: Colors.teal,
          leading: IconButton(
            onPressed: _handleMenuButtonPressed,
            icon: ValueListenableBuilder<AdvancedDrawerValue>(
              valueListenable: _advancedDrawerController,
              builder: (_, value, __) {
                return AnimatedSwitcher(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    value.visible ? Icons.clear : Icons.menu,
                    key: ValueKey<bool>(value.visible),
                  ),
                );
              },
            ),
          ),
          actions: [],
        ),
      ),
      drawer: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              height: 270,
              color: Colors.teal,
              child: Column(
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 200,
                        width: 200,
                        child: Lottie.asset("lottie/animation_ljzjl62p.json"),
                      )
                    ],
                  ),

                  SizedBox(height: 10,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Gopinath Gems",
                        style: GoogleFonts.alegreyaSc(
                          fontSize: 30,
                          color: Colors.white70,
                          fontWeight: FontWeight.w700,
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
            ListTileTheme(
              textColor: Colors.white,
              iconColor: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return rapchat();
                      },));

                    },
                    leading: Icon(Icons.chat, color: Colors.black),
                    title: Text(
                      'Rapchat',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 3,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {
                      _advancedDrawerController.hideDrawer();
                    },
                    leading: Icon(Icons.diamond_outlined, color: Colors.black),
                    title:
                        Text('Diamonds', style: TextStyle(color: Colors.black)),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 3,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return orderpage();
                        },
                      ));
                    },
                    leading: Icon(Icons.handshake, color: Colors.black),
                    title:
                    Text('Your Orders', style: TextStyle(color: Colors.black)),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 3,
                    thickness: 2,
                  ),


                  ListTile(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return contactpage();
                        },
                      ));
                    },
                    leading: Icon(Icons.handshake, color: Colors.black),
                    title:
                        Text('Contact', style: TextStyle(color: Colors.black)),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 3,
                    thickness: 2,
                  ),
                  ListTile(
                    onTap: () async {
                      await FirebaseAuth.instance.signOut().then((value) {
                        Get.off(loginpage(),
                            duration: Duration(seconds: 3),
                            transition: Transition.leftToRight);
                      });
                    },
                    leading: Icon(Icons.logout, color: Colors.black),
                    title:
                        Text('Log Out', style: TextStyle(color: Colors.black)),
                  ),
                  Divider(
                    color: Colors.teal,
                    height: 3,
                    thickness: 2,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    ));
  }
}

final _advancedDrawerController = AdvancedDrawerController();

void _handleMenuButtonPressed() {
  // NOTICE: Manage Advanced Drawer state through the Controller.
  // _advancedDrawerController.value = AdvancedDrawerValue.visible();
  _advancedDrawerController.showDrawer();
}
