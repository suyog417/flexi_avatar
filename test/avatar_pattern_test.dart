import 'package:flexi_avatar/flexi_avatar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AvatarPattern', () {
    test('random() generates valid pattern', () {
      final pattern = AvatarPattern.random();

      expect(pattern.type, isNotNull);
      expect(pattern.colors, hasLength(2));
      expect(pattern.density, inInclusiveRange(1, 5));
      expect(pattern.scale, inInclusiveRange(0.75, 1.25));
    });

    test('PatternPainter paints without errors', () {
      final patterns = PatternType.values
          .where((type) => type != PatternType.random)
          .map((type) => AvatarPattern(type: type))
          .toList();

      for (final pattern in patterns) {
        final painter = PatternPainter(pattern: pattern);
        expect(
              () => painter.paint(MockCanvas(), const Size(100, 100)),
          returnsNormally,
        );
      }
    });
  });
}

class MockCanvas implements Canvas {
  @override
  void noSuchMethod(Invocation invocation) {
    // No-op for testing
  }
}