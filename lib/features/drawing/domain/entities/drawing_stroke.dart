import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;
  final double opacity;
  final BlendMode blendMode;

  DrawingStroke({
    required this.points,
    required this.color,
    required this.strokeWidth,
    this.opacity = 1.0,
    this.blendMode = BlendMode.srcOver,
  });
}
