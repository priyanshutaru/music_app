import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:just_audio/just_audio.dart';

class PlayerContorller extends GetxController {
  final audioquery = OnAudioQuery();
  final audioplayer = AudioPlayer();

  var playindex = 0.obs;
  var isplaying = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
  }

  playsong(String? uri,index) {
    playindex.value = index;
    try {
      audioplayer.setAudioSource(
      AudioSource.uri(
        Uri.parse(uri!),
      ),
    );
    audioplayer.play();
    isplaying(true);
      
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
