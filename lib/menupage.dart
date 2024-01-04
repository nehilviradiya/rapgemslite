import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:hive_flutter/adapters.dart';

class menupage extends StatefulWidget {
  const menupage({Key? key}) : super(key: key);

  @override
  State<menupage> createState() => _menupageState();
}

class _menupageState extends State<menupage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder(
      valueListenable: Hive.box('favourite').listenable(),
      builder: (context, box, child) {
        return StreamBuilder<QuerySnapshot>(
          stream:
              FirebaseFirestore.instance.collection("favourite").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final isfavourite = box.get(index) != null;
                  return AnimationLimiter(
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
                                onTap: () {},
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
                                              onPressed: () {
                                                setState(() async {
                                                  ScaffoldMessenger.of(context)
                                                      .clearSnackBars();
                                                  String deleteid =
                                                      "${snapshot.data!.docs[index]['id']}";
                                                  await FirebaseFirestore.instance
                                                      .collection("favourite")
                                                      .doc(deleteid)
                                                      .delete();

                                                  if (isfavourite) {
                                                    await box.delete(index);
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                        Colors.teal,
                                                        content: Text(
                                                          "Remove successfully",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white),
                                                        )));
                                                  } else {
                                                    final firestore =
                                                    FirebaseFirestore.instance
                                                        .collection(
                                                        "favourite");

                                                    String insertid =
                                                        "${snapshot.data!.docs[index]['id']}";
                                                    firestore.doc(insertid).set({
                                                      "id": insertid,
                                                      "companyname":
                                                      "${snapshot.data!.docs[index]['companyname']}",
                                                      "location":
                                                      "${snapshot.data!.docs[index]['location']}",
                                                      "dmshape":
                                                      "${snapshot.data!.docs[index]['dmshape']}",
                                                      "color":
                                                      "${snapshot.data!.docs[index]['color']}",
                                                      "measure":
                                                      "${snapshot.data!.docs[index]['measure']}",
                                                      "carat":
                                                      "${snapshot.data!.docs[index]['carat']}",
                                                      "type":
                                                      "${snapshot.data!.docs[index]['type']}",
                                                      "rate":
                                                      "${snapshot.data!.docs[index]['rate']}",
                                                      "total":
                                                      "${snapshot.data!.docs[index]['total']}",
                                                      "image":
                                                      "${snapshot.data!.docs[index]['image']}",
                                                    });

                                                    await box.put(index,
                                                        "${snapshot.data!.docs[index]['dmshape']}");
                                                    ScaffoldMessenger.of(context)
                                                        .showSnackBar(SnackBar(
                                                        backgroundColor:
                                                        Colors.blue,
                                                        content: Text(
                                                            "Added successfully")));
                                                  }
                                                });
                                              },
                                              icon: Icon(isfavourite
                                                  ? Icons.favorite
                                                  : Icons.favorite_border)),
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
                                                Text('Tap To View',
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
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
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 12),
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
                  );
                },
              );
            }
            else
              {

              }
            return Center(child: CircularProgressIndicator(backgroundColor: Colors.teal));
          },
        );
      },
    ));
  }
}
