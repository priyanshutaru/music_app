import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class PlayerContorller extends GetxController {
  final audioquery = OnAudioQuery();
  final audioplayer = AudioPlayer();

  var playindex = 0.obs;
  var isplaying = false.obs;

  var duration = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  updatePosition() {
    audioplayer.durationStream.listen((p) {
      duration.value = p.toString().split(".")[0];
      max.value = p!.inSeconds.toDouble();
    });
    audioplayer.positionStream.listen((d) {
      position.value = d.toString().split(".")[0];
      value.value = d.inSeconds.toDouble();
    });
  }


  chnageDurationToSeconds(seconds){
    var duration = Duration(seconds: seconds);
    audioplayer.seek(duration);
  }

  playsong(String? uri, index) {
    playindex.value = index;
    try {
      audioplayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
      );
      audioplayer.play();

      isplaying(true);
      updatePosition();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  checkPermission() async {
    var perm = await Permission.storage.request();

    if (perm.isGranted) {
    } else {
      checkPermission();
    }
  }
}
