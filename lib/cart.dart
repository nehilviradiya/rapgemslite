import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class cart extends StatefulWidget {
  const cart({Key? key}) : super(key: key);

  @override
  State<cart> createState() => _cartState();
}

class _cartState extends State<cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection("diamonds").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
               return ListView.builder(
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return Card(
                      color: Colors.white60,
                      margin: EdgeInsets.all(15),
                      child: Container(
                          height: 70,
                          width: double.infinity,
                          margin: EdgeInsets.all(10),
                          child: Expanded(
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                "${snapshot.data!.docs[index]['image']}"),
                                            fit: BoxFit.fill)),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    color: Colors.teal.withOpacity(0.2),
                                    child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          children: [
                                            SizedBox(width: 30,),
                                            Icon(Icons.account_balance),
                                            SizedBox(width: 28,),

                                            Text(
                                              " : ${snapshot.data!.docs[index]['companyname']}.PVT LTD",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            )
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            SizedBox(width: 30,),
                                            Icon(Icons.location_on),
                                            SizedBox(width: 28,),
                                            Text(
                                              " : ${snapshot.data!.docs[index]['location']}",
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
                                )
                              ],
                            ),
                          )));
                },
              );
            }
            else
              {

              }
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.teal));



          },
        ),
      ),
    );
  }
}
