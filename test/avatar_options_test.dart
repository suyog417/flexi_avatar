import 'package:flexi_avatar/flexi_avatar.dart';
import 'package:flexi_avatar/src/avatar_shapes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvatarOptions', () {
    test('default constructor sets correct values', () {
      const options = AvatarOptions();
      expect(options.name, isNull);
      expect(options.imageUrl, isNull);
      expect(options.style, AvatarStyle.circle);
      expect(options.size, 48.0);
      expect(options.shape, isA<CircleShape>());
    });

    test('copyWith creates new instance with updated values', () {
      const original = AvatarOptions();
      final copied = original.copyWith(
        name: 'Test',
        size: 64.0,
        shape: const RoundedRectangleShape(16.0),
      );

      expect(copied.name, 'Test');
      expect(copied.size, 64.0);
      expect(copied.shape, isA<RoundedRectangleShape>());
      expect((copied.shape as RoundedRectangleShape).borderRadius, 16.0);

      // Verify unchanged values
      expect(copied.imageUrl, original.imageUrl);
      expect(copied.style, original.style);
    });

    test('equality works correctly', () {
      const options1 = AvatarOptions(name: 'A');
      const options2 = AvatarOptions(name: 'A');
      const options3 = AvatarOptions(name: 'B');

      expect(options1, equals(options2));
      expect(options1, isNot(equals(options3)));
    });
  });
}