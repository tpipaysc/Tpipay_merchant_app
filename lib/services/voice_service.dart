import 'package:flutter_tts/flutter_tts.dart';

class VoiceService {
  // Use a static instance of FlutterTts to reuse the engine
  static final FlutterTts _tts = FlutterTts();

  static Future<void> speak(String message) async {
    // Basic setup for Indian accent
    await _tts.setLanguage("en-IN"); 
    await _tts.setPitch(1.0);
    await _tts.setSpeechRate(0.5); // Adjust speed for clarity
    await _tts.speak(message);
  }
}