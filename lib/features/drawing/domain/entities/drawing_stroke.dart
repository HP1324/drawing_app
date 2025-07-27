import 'package:flutter/material.dart';

class DrawingStroke {
  final List<Offset> points;
  final Color color;
  final double strokeWidth;

  DrawingStroke({
    required this.points,
    required this.color,
    required this.strokeWidth,
  });
}
