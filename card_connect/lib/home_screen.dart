import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Card Connect"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.orangeAccent,
          ),
          width: double.infinity,
          height: 350,
          // color: Colors.blueGrey.shade600,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 7.0, top: 5),
                child: Row(
                  spacing: 3,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.call, size: 17, fontWeight: FontWeight.bold),
                    Text("+91 8080494014"),
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      radius: 50,
                      // width: 100,
                      // height: 100,
                      child: Image.asset('assets/avatar2.png'),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 5),
                        child: Row(
                          spacing: 3,
                          children: [
                            Icon(Icons.person, size: 20),
                            Text(
                              "Alpit Gadhave",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 5),
                        child: Row(
                          spacing: 3,
                          children: [
                            Icon(Icons.work_rounded, size: 20),
                            Text(
                              "Flutter Developer",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0, top: 5),
                        child: Row(
                          spacing: 3,
                          // mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Icon(Icons.location_city, size: 20),
                            Text(
                              "Pune",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 386,
                      height: 2,
                      color: Colors.black,
                      // padding: EdgeInsets.all(8),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  // crossAxisAlignment: CrossAxisAlignment.,
                  children: [
                    Column(
                      children: [
                        Icon(Icons.web, size: 20,),
                        Text("www.techtownsol.com")
                      ],
                    ),
                    Column(
                      children: [
                        Icon(Icons.mail, size: 20,),
                        Text("alpitprogadhave6596@gmail.com")
                      ],
                    )
                  ],
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      width: 386,
                      height: 2,
                      color: Colors.black,
                      // padding: EdgeInsets.all(8),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(child: Text("Hey Folks! This is Alpit Gadhave, I am newly starting the Flutter Development and I gained the some experinced in UI designing in Flutter."),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: Container(
                    //     width: 380,
                    //     child: Text("Hey Folks! This is Alpit Gadhave, I am newly starting the Flutter Development and I gained the some experinced in UI designing in Flutter."),
                    //   ),
                    // )
                    // Text("Hey Folks! This is Alpit Gadhave, I am newly starting the Flutter Development and I gained the some experinced in UI designing in Flutter.")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
