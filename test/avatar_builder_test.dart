import 'package:flexi_avatar/flexi_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FlexiAvatar', () {
    testWidgets('renders initials avatar correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlexiAvatar(
            options: const AvatarOptions(name: 'JD'),
          ),
        ),
      );

      expect(find.text('JD'), findsOneWidget);
    });

    testWidgets('renders image avatar correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlexiAvatar(
            options: const AvatarOptions(
              imageUrl: 'https://example.com/avatar.jpg',
            ),
          ),
        ),
      );

      expect(find.byType(Image), findsOneWidget);
    });

    testWidgets('shows loading indicator when image is loading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: FlexiAvatar(
            options: const AvatarOptions(
              imageUrl: 'https://example.com/avatar.jpg',
              loadingIndicator: CircularProgressIndicator(),
            ),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('animates between states', (tester) async {
      final widget = MaterialApp(
        home: StatefulBuilder(
          builder: (context, setState) {
            return Column(
              children: [
                FlexiAvatar(
                  options: AvatarOptions(
                    name: 'A',
                    animationDuration: const Duration(milliseconds: 200),
                  ),
                ),
                TextButton(
                  onPressed: () => setState(() {}),
                  child: const Text('Change'),
                ),
              ],
            );
          },
        ),
      );

      await tester.pumpWidget(widget);
      await tester.tap(find.text('Change'));
      await tester.pump(); // Start animation
      await tester.pump(const Duration(milliseconds: 100)); // Middle of animation

      expect(find.byType(FadeTransition), findsOneWidget);
    });
  });
}