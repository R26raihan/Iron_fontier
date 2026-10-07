import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:firstgame/ui/screens/game_screen.dart';

Future<void> _capture(WidgetTester tester, String path) async {
  final boundary =
      tester.renderObject(find.byType(RepaintBoundary).first)
          as RenderRepaintBoundary;
  final image = await boundary.toImage(pixelRatio: 2.0);
  final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
  await File(path).writeAsBytes(bytes!.buffer.asUint8List());
}

void main() {
  testWidgets('capture game screen', (tester) async {
    await tester.binding.setSurfaceSize(const Size(1280, 720));
    tester.view.physicalSize = const Size(1280, 720);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: RepaintBoundary(child: GameScreen()),
      ),
    );

    // Let assets load and the physics settle the player onto the ground.
    for (var i = 0; i < 90; i++) {
      await tester.pump(const Duration(milliseconds: 16));
    }

    await _capture(
      tester,
      '/private/tmp/claude-501/-Users-raihansetiawan-firstgame/b4294478-522e-455b-85cb-4365dfce4a89/scratchpad/widgettest_game_screen.png',
    );
  });
}
