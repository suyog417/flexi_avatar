import 'dart:math';

import 'package:flutter/material.dart';

abstract class AvatarShape {
  const AvatarShape();

  Path getPath(Size size);
}

class CircleShape extends AvatarShape {
  const CircleShape();

  @override
  Path getPath(Size size) {
    return Path()..addOval(Rect.fromCircle(
      center: Offset(size.width/2, size.height/2),
      radius: size.width/2,
    ));
  }
}

class RoundedRectangleShape extends AvatarShape {
  final double borderRadius;

  const RoundedRectangleShape([this.borderRadius = 8.0]);

  @override
  Path getPath(Size size) {
    return Path()..addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(borderRadius),
    ));
  }
}

class TriangleShape extends AvatarShape {
  const TriangleShape();

  @override
  Path getPath(Size size) {
    return Path()
      ..moveTo(size.width/2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }
}

class StarShape extends AvatarShape {
  final int points;

  const StarShape([this.points = 5]);

  @override
  Path getPath(Size size) {
    final path = Path();
    final center = Offset(size.width/2, size.height/2);
    final radius = size.width/2;
    final innerRadius = radius * 0.4;

    final angle = (2 * pi) / points;
    final halfAngle = angle / 2;

    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );

    for (int i = 1; i <= points; i++) {
      path.lineTo(
        center.dx + innerRadius * cos(angle * i - halfAngle),
        center.dy + innerRadius * sin(angle * i - halfAngle),
      );
      path.lineTo(
        center.dx + radius * cos(angle * i),
        center.dy + radius * sin(angle * i),
      );
    }

    path.close();
    return path;
  }
}