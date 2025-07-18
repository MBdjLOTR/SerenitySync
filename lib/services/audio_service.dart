// lib/services/audio_service.dart
import 'package:audioplayers/audioplayers.dart';

class AudioService {
  static final AudioService _instance = AudioService._internal();
  factory AudioService() => _instance;

  late final AudioPlayer _player;

  AudioService._internal() {
    _player = AudioPlayer();
  }

  Future<void> play() async {
    try {
      await _player.setReleaseMode(ReleaseMode.loop);
      await _player.setSource(AssetSource('audio/rain.mp3'));
      await _player.resume();
    } catch (e) {
      ('Audio play error: $e');
    }
  }

  Future<void> stop() async {
    try {
      await _player.stop();
    } catch (e) {
      ('Audio stop error: $e');
    }
  }
}
