import 'package:anything/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyApp build succeed', (WidgetTester tester) async {
    tester.pumpWidget(MyApp());
  });
}
