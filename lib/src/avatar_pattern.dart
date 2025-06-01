import 'dart:math';

import 'package:flutter/material.dart';

enum PatternType {
  squares,
  circles,
  triangles,
  lines,
  concentricCircles,
  diagonalStripes,
  checkerboard,
  random
}

class AvatarPattern {
  final PatternType type;
  final List<Color> colors;
  final int density; // Between 1 (sparse) and 5 (dense)
  final double scale; // Adjusts pattern size

  const AvatarPattern({
    this.type = PatternType.squares,
    this.colors = const [Colors.blue, Colors.lightBlue],
    this.density = 3,
    this.scale = 1.0,
  });

  factory AvatarPattern.random() {
    // Create a list of all pattern types except PatternType.random
    final availableTypes = PatternType.values.where((type) => type != PatternType.random).toList();

    // Shuffle the list and take the first item
    availableTypes.shuffle();
    final randomType = availableTypes.first;

    return AvatarPattern(
      type: randomType,
      colors: [
        Color.lerp(Colors.blue, Colors.red, Random().nextDouble())!,
        Color.lerp(Colors.green, Colors.yellow, Random().nextDouble())!,
      ],
      density: Random().nextInt(5) + 1,
      scale: Random().nextDouble() * 0.5 + 0.75,
    );
  }
}

class PatternPainter extends CustomPainter {
  final AvatarPattern? pattern;

  PatternPainter({this.pattern});

  @override
  void paint(Canvas canvas, Size size) {
    if (pattern == null) return;

    final paint = Paint();
    final effectivePattern = pattern ?? AvatarPattern.random();
    final colors = effectivePattern.colors;
    final density = effectivePattern.density;
    final scale = effectivePattern.scale;

    switch (effectivePattern.type) {
      case PatternType.squares:
        _drawSquares(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.circles:
        _drawCircles(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.triangles:
        _drawTriangles(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.lines:
        _drawLines(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.concentricCircles:
        _drawConcentricCircles(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.diagonalStripes:
        _drawDiagonalStripes(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.checkerboard:
        _drawCheckerboard(canvas, size, paint, colors, density, scale);
        break;
      case PatternType.random:
        PatternPainter(pattern: AvatarPattern.random())
            .paint(canvas, size);
        break;
    }
  }

  void _drawSquares(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final squareSize = size.width / (density + 2) * scale;
    final cols = (size.width / squareSize).ceil();
    final rows = (size.height / squareSize).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        paint.color = colors[(i + j) % colors.length];
        canvas.drawRect(
          Rect.fromLTWH(
            i * squareSize,
            j * squareSize,
            squareSize,
            squareSize,
          ),
          paint,
        );
      }
    }
  }

  void _drawCircles(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final radius = size.width / (density + 3) * scale;
    final cols = (size.width / (radius * 2)).ceil();
    final rows = (size.height / (radius * 2)).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        paint.color = colors[(i + j) % colors.length];
        canvas.drawCircle(
          Offset(
            i * radius * 2 + radius,
            j * radius * 2 + radius,
          ),
          radius,
          paint,
        );
      }
    }
  }

  void _drawTriangles(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final triangleSize = size.width / (density + 2) * scale;
    final cols = (size.width / triangleSize).ceil();
    final rows = (size.height / triangleSize).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        paint.color = colors[(i + j) % colors.length];

        final path = Path()
          ..moveTo(i * triangleSize, j * triangleSize)
          ..lineTo((i + 1) * triangleSize, j * triangleSize)
          ..lineTo(i * triangleSize, (j + 1) * triangleSize)
          ..close();

        canvas.drawPath(path, paint);
      }
    }
  }

  void _drawLines(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final lineSpacing = size.width / (density + 1) * scale;
    final lineCount = (size.width / lineSpacing).ceil();

    for (int i = 0; i < lineCount; i++) {
      paint.color = colors[i % colors.length];
      paint.strokeWidth = 2 * scale;

      canvas.drawLine(
        Offset(i * lineSpacing, 0),
        Offset(i * lineSpacing, size.height),
        paint,
      );
    }
  }

  void _drawConcentricCircles(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;
    final ringCount = density + 1;
    final ringWidth = maxRadius / ringCount * scale;

    for (int i = 0; i < ringCount; i++) {
      paint.color = colors[i % colors.length];
      canvas.drawCircle(
        center,
        maxRadius - i * ringWidth,
        paint,
      );
    }
  }

  void _drawDiagonalStripes(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final stripeWidth = size.width / (density + 2) * scale;
    final path = Path();
    var colorIndex = 0;

    for (double i = -size.height; i < size.width; i += stripeWidth) {
      paint.color = colors[colorIndex % colors.length];
      colorIndex++;

      path.reset();
      path.moveTo(i, 0);
      path.lineTo(i + size.height, size.height);
      path.lineTo(i + size.height - stripeWidth, size.height);
      path.lineTo(i - stripeWidth, 0);
      path.close();

      canvas.drawPath(path, paint);
    }
  }

  void _drawCheckerboard(Canvas canvas, Size size, Paint paint,
      List<Color> colors, int density, double scale) {
    final squareSize = size.width / (density + 3) * scale;
    final cols = (size.width / squareSize).ceil();
    final rows = (size.height / squareSize).ceil();

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        paint.color = colors[(i + j) % 2 == 0 ? 0 : colors.length > 1 ? 1 : 0];
        canvas.drawRect(
          Rect.fromLTWH(
            i * squareSize,
            j * squareSize,
            squareSize,
            squareSize,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}