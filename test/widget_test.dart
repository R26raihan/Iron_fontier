import 'package:flutter_test/flutter_test.dart';
import 'package:firstgame/main.dart';

void main() {
  testWidgets('App initialization smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const IronFrontierApp());
    expect(find.text('DEPLOY MISSION'), findsOneWidget);
    expect(find.text('2D RUN-AND-GUN OUTPOST ASSAULT'), findsOneWidget);
  });
}
