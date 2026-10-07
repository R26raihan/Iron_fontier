import 'dart:convert';
import 'package:flutter/services.dart';

/// Animation manifest metadata structure
class AnimationManifest {
  final String id;
  final String file;
  final double frameWidth;
  final double frameHeight;
  final int frameCount;
  final double fps;
  final bool loop;
  final String anchor;

  AnimationManifest({
    required this.id,
    required this.file,
    required this.frameWidth,
    required this.frameHeight,
    required this.frameCount,
    required this.fps,
    required this.loop,
    required this.anchor,
  });

  factory AnimationManifest.fromJson(Map<String, dynamic> json) {
    return AnimationManifest(
      id: json['id'] as String,
      file: json['file'] as String,
      frameWidth: (json['frameWidth'] as num).toDouble(),
      frameHeight: (json['frameHeight'] as num).toDouble(),
      frameCount: json['frameCount'] as int,
      fps: (json['fps'] as num).toDouble(),
      loop: json['loop'] as bool? ?? true,
      anchor: json['anchor'] as String? ?? 'bottomCenter',
    );
  }

  static Future<Map<String, AnimationManifest>> loadManifestMap(String path) async {
    final jsonStr = await rootBundle.loadString(path);
    final List<dynamic> data = json.decode(jsonStr);
    final map = <String, AnimationManifest>{};
    for (final item in data) {
      final manifest = AnimationManifest.fromJson(item as Map<String, dynamic>);
      map[manifest.id] = manifest;
    }
    return map;
  }
}
