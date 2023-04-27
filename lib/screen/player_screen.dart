// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:music_app/const/colors.dart';
import 'package:music_app/controller/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:get/get.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerContorller>();

    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(),
      body: Obx(
        () => Column(
          children: [
            Obx(
              () => Expanded(
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  margin: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    shape: BoxShape.circle,
                  ),
                  child: QueryArtworkWidget(
                    id: data[controller.playindex.value].id,
                    type: ArtworkType.AUDIO,
                    artworkWidth: double.infinity,
                    artworkHeight: double.infinity,
                    nullArtworkWidget: Icon(
                      Icons.music_note,
                      size: 50,
                    ),
                  ),
                ),
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
                      data[controller.playindex.value].displayNameWOExt,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      data[controller.playindex.value].artist.toString(),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.w400),
                    ),
                    Obx(
                      () => Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              controller.position.value,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Slider(
                                  thumbColor: Colors.green,
                                  //inactiveColor: bgdarkercolor,
                                  activeColor: Colors.deepPurple,
                                  min:
                                      Duration(seconds: 0).inSeconds.toDouble(),
                                  max: controller.max.value,
                                  value: controller.value.value,
                                  onChanged: (newValue) {
                                    controller.chnageDurationToSeconds(
                                        newValue.toInt());
                                    newValue = newValue;
                                  }),
                            ),
                            Text(
                              controller.duration.value,
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            controller.playsong(
                                data[controller.playindex.value - 1].uri,
                                controller.playindex.value - 1);
                          },
                          child: Icon(
                            Icons.skip_previous,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        Obx(
                          () => CircleAvatar(
                            backgroundColor: Colors.purple[300],
                            radius: 40,
                            child: Transform.scale(
                              scale: 1,
                              child: InkWell(
                                onTap: () {
                                  if (controller.isplaying.value) {
                                    controller.audioplayer.pause();
                                    controller.isplaying(false);
                                  } else {
                                    controller.audioplayer.play();
                                    controller.isplaying(true);
                                  }
                                },
                                child: Icon(
                                  controller.isplaying.value
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 80,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   width: 20,
                        // ),
                        InkWell(
                          onTap: () {
                            controller.playsong(
                                data[controller.playindex.value + 1].uri,
                                controller.playindex.value + 1);
                          },
                          child: Icon(
                            Icons.skip_next,
                            size: 50,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
