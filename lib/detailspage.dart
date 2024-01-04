import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:rapgemslite/showdiamond.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:url_launcher/url_launcher.dart';

class detailspage extends StatefulWidget {
  var alldata;

  detailspage(this.alldata);



  @override
  State<detailspage> createState() => _detailspageState();
}

class _detailspageState extends State<detailspage> {
  final RoundedLoadingButtonController _btnController =
  RoundedLoadingButtonController();
  final List<Widget> images = [
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("img/gold-diamond-ring-min.jpg"),
              fit: BoxFit.fill)),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("img/img1.jpg"), fit: BoxFit.fill)),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("img/img2.jpg"), fit: BoxFit.fill)),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("img/img3.jpg"), fit: BoxFit.fill)),
    ),
  ];

  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
         title: Text("Details of : ${widget.alldata![0]['dmshape']}"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              CarouselSlider(
                  items: images,
                  options: CarouselOptions(
                    height: 200,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                    enlargeFactor: 0.3,
                    scrollDirection: Axis.horizontal,
                  )),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("10k+ bought in past month",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Pay Only for this order with Gopinath Gems",
                      style: TextStyle(
                          color: Colors.teal,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
              Container(
                height: 190,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.teal, width: 5)),
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(onTap: () async {
                      await FlutterPhoneDirectCaller.callNumber("8401705481");
                    },
                      child: Container(
                        height: 30,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.call,
                              color: Colors.white,
                            ),
                            InkWell(onTap: ()  {

                            },
                              child: Text(
                                "Call",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Shape : ${widget.alldata![0]['dmshape']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Carat :${widget.alldata![0]['carat']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Color : ${widget.alldata![0]['color']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "location :${widget.alldata![0]['location']}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 3)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Lightning Deal",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 30,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.teal,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Great Freedom",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Free Delivery Order With in 7 hrs 38min.",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                  ],
                ),
              ),
              Container(
                height: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 3)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "-40%",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "₹ ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${widget.alldata![0]['total']}",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "M.R.P .:",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "₹ ",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                        Text(
                          "${widget.alldata![0]['rate']}",
                          style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "Inclusive of all taxes",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              SwipeButton.expand(
                thumb: Icon(
                  Icons.double_arrow_rounded,
                  color: Colors.white,
                ),
                child: Text(
                  "Swipe to Buy",
                  style: TextStyle(
                    color: Colors.teal,
                  ),
                ),
                activeThumbColor: Colors.teal,
                activeTrackColor: Colors.grey.shade300,
                onSwipe: () async {

                  final firestore =
                  FirebaseFirestore.instance.collection("orders");

                  String id =
                      "order${Random().nextInt(500)}${DateTime
                      .now()
                      .millisecond}";

                  firestore.doc(id).set({
                    "id": id,
                    "status":"pending",
                    "companyname": "${widget.alldata![0]['companyname']}",
                    "dmshape": "${widget.alldata![0]['dmshape']}",
                    "color": "${widget.alldata![0]['color']}",
                    "carat": "${widget.alldata![0]['carat']}",
                    "measure": "${widget.alldata![0]['measure']}",
                    "rate": "${widget.alldata![0]['rate']}",
                    "total": "${widget.alldata![0]['total']}",
                    "location": "${widget.alldata![0]['location']}",
                    "type": " ${widget.alldata![0]['type']}",
                   "image": "${widget.alldata![0]['image']}",
                  }).then((value) => (value) {

                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Your order is pending please wait")));
                },
              ).marginOnly(left: 15,right: 15,bottom: 10),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
