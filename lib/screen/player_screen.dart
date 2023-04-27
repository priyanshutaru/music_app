// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.all(12),
              decoration:
                  BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
              //color: Colors.yellow,
              // child: Center(
              //   child: Icon(
              //     Icons.music_note,
              //     //size: 40,
              //   ),
              // ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
                color: Colors.white,
              ),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Song Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Artist Name",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "0:0",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                        Expanded(
                          child: Slider(
                              thumbColor: Colors.green,
                              //inactiveColor: bgdarkercolor,
                              activeColor: Colors.deepPurple,
                              value: 0.0,
                              onChanged: (newValue) {}),
                        ),
                        Text(
                          "0:0",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.skip_previous,
                        size: 50,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.purple[300],
                        radius: 40,
                        child: Transform.scale(
                          scale: 1,
                          child: Icon(
                            Icons.play_arrow,
                            size: 80,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.skip_next,
                        size: 50,
                        color: Colors.black,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
