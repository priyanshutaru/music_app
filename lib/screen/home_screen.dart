// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:get/get.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:music_app/screen/player_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var controller = Get.put(PlayerContorller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: bgdarkercolor,
        leading: Icon(
          Icons.sort,
        ),
        title: Text("Beast"),
        actions: [
          Icon(
            Icons.search,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          ),
        ],
      ),
      body: FutureBuilder<List<SongModel>>(
        future: controller.audioquery.querySongs(
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
          orderType: OrderType.ASC_OR_SMALLER,
          sortType: null,
        ),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No Song Found In Your Device",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            );
          } else {
            // print(snapshot.data);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      margin: EdgeInsets.only(bottom: 4),
                      child: Obx(
                        () => ListTile(
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          leading: QueryArtworkWidget(
                            id: snapshot.data![index].id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: Icon(
                              Icons.music_note,
                              color: Colors.white,
                            ),
                          ),
                          title: Text(
                            snapshot.data![index].displayNameWOExt,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          subtitle: Text(
                            "${snapshot.data![index].artist}",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                          trailing: CircleAvatar(
                            child: controller.playindex.value == index &&
                                    controller.isplaying.value
                                ? Icon(
                                    Icons.pause_circle,
                                    size: 20,
                                    color: Colors.white,
                                  )
                                : Icon(Icons.play_arrow),
                          ),
                          onTap: () {
                            Get.to(() => Player(
                                  data: snapshot.data!,  
                                ));
                            controller.playsong(
                                snapshot.data![index].uri, index);
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
