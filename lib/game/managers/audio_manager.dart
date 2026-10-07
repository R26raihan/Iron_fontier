class AudioManager {
  static final AudioManager instance = AudioManager._internal();
  AudioManager._internal();

  bool isBgmEnabled = true;
  bool isSfxEnabled = true;

  Future<void> init() async {
    // Audio preloading placeholder
  }

  void playSfx(String sfxName) {
    if (!isSfxEnabled) return;
    // flame_audio SFX play placeholder
  }

  void playBgm(String bgmName) {
    if (!isBgmEnabled) return;
    // flame_audio BGM play placeholder
  }

  void stopBgm() {
    // flame_audio BGM stop placeholder
  }
}
