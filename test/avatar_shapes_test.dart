import 'package:flexi_avatar/flexi_avatar.dart';
import 'package:flexi_avatar/src/avatar_shapes.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvatarShapes', () {
    test('CircleShape creates correct path', () {
      const shape = CircleShape();
      final path = shape.getPath(const Size(100, 100));

      expect(path.getBounds(), const Rect.fromLTWH(0, 0, 100, 100));
      // Verify it's a circle by checking control points
      expect(path.contains(const Offset(50, 0)), isTrue);
      expect(path.contains(const Offset(50, 100)), isTrue);
    });

    test('RoundedRectangleShape creates correct path', () {
      const shape = RoundedRectangleShape(16.0);
      final path = shape.getPath(const Size(100, 100));

      expect(path.getBounds(), const Rect.fromLTWH(0, 0, 100, 100));
      // Check corners are rounded
      expect(path.contains(const Offset(0, 0)), isFalse);
      expect(path.contains(const Offset(8, 8)), isTrue);
    });

    test('StarShape creates correct path', () {
      const shape = StarShape(5);
      final path = shape.getPath(const Size(100, 100));

      expect(path.getBounds(), const Rect.fromLTWH(0, 0, 100, 100));
      // Check center point is included
      expect(path.contains(const Offset(50, 50)), isTrue);
    });

    test('Custom shapes work correctly', () {
      final customShape = _CustomTestShape();
      final path = customShape.getPath(const Size(100, 100));

      expect(path.getBounds(), const Rect.fromLTWH(0, 0, 100, 100));
    });
  });
}

class _CustomTestShape extends AvatarShape {
  @override
  Path getPath(Size size) {
    return Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width/2, size.height)
      ..close();
  }
}