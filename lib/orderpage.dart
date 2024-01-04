import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class orderpage extends StatefulWidget {
  const orderpage({Key? key}) : super(key: key);

  @override
  State<orderpage> createState() => _orderpageState();
}

class _orderpageState extends State<orderpage> {

  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);


  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _razorpay.clear();
  }
  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("EROOR")));
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal,title: Text("Orders"),),
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("orders")
          .where("status", isEqualTo: "confirm")
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print("hello");
                },
                child: AnimationLimiter(
                  key: ValueKey("${snapshot.data!.docs.length}"),
                  child: AnimationConfiguration.staggeredList(
                    position: index,
                    child: ScaleAnimation(
                      duration: Duration(seconds: 1),
                      delay: Duration(seconds: 1),
                      child: Container(
                        height: 190,
                        width: double.infinity,
                        color: Colors.white70,
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print("buy");
                             // secret id -    uK4TFFOnrJoLP01kfXpR1qj2
                                // key id -    rzp_test_xa1mXDwOSn4nER


                                var options = {
                                  'key': 'rzp_test_xa1mXDwOSn4nER',
                                  'amount': 100*100, //in the smallest currency sub-unit.
                                  'name': 'Payment for dimaond.',
                                  'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
                                  'description': 'Buy Diamond',
                                  'timeout': 60, // in seconds
                                  'prefill': {
                                    'contact': '8401705381',
                                    'email': 'Rapgems@example.com'
                                  }
                                };
                                setState(() {
                                  _razorpay.open(options);
                                });



                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.teal.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(5)),
                                height: 120,
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.money)),
                                        Text(
                                          "${snapshot.data!.docs[index]['dmshape']},",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${snapshot.data!.docs[index]['carat']},",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${snapshot.data!.docs[index]['color']},",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          "${snapshot.data!.docs[index]['type']},",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text(
                                          "${snapshot.data!.docs[index]['measure']},",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Container(
                                          height: 20,
                                          width: 30,
                                          child: Center(
                                              child: Text(
                                                "GIA",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold),
                                              )),
                                          color: Colors.white,
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                            children: [
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Text('Tap To Buy',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold)),
                                              VerticalDivider(
                                                color: Colors.black,
                                                thickness: 1,
                                              ),
                                              Icon(Icons.image)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${snapshot.data!.docs[index]['image']}"),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "${snapshot.data!.docs[index]['companyname']} PVT.LTD",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                                SizedBox(
                                  width: 80,
                                ),
                                Text("\$/ct : "),
                                Text(
                                  "${snapshot.data!.docs[index]['rate']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                ),
                                Text(
                                  "${snapshot.data!.docs[index]['location']}",
                                  style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                                ),
                                SizedBox(
                                  width: 125,
                                ),
                                Text("Total : "),
                                Text(
                                  "${snapshot.data!.docs[index]['total']}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator(backgroundColor: Colors.teal));

      },
    ));
  }
}
