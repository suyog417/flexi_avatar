import 'package:flexi_avatar/flexi_avatar.dart';
import 'package:flexi_avatar/src/avatar_shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('End-to-end tests', () {
    testWidgets('Complete avatar lifecycle', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(
        MaterialApp(
          home: FlexiAvatar(
            options: const AvatarOptions(
              name: 'Test',
              shape: StarShape(5),
              animationDuration: Duration(milliseconds: 100),
            ),
          ),
        ),
      );

      // Verify initial state
      expect(find.text('Test'), findsOneWidget);

      // Test animation
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(FadeTransition), findsOneWidget);

      // Test shape clipping
      expect(find.byType(ClipPath), findsOneWidget);
    });

    testWidgets('Image loading and error states', (tester) async {
      final widget = MaterialApp(
        home: FlexiAvatar(
          options: const AvatarOptions(
            imageUrl: 'https://invalid.url',
            name: 'Fallback',
          ),
        ),
      );

      await tester.pumpWidget(widget);

      // Initial loading state
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      // Wait for image to fail loading
      await tester.pumpAndSettle();

      // Verify fallback to initials
      expect(find.text('Fallback'), findsOneWidget);
    });
  });
}