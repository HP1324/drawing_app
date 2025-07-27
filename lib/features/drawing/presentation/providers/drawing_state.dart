import 'package:flutter/material.dart';
import '../../domain/entities/drawing_stroke.dart';

class DrawingState {
  final List<DrawingStroke> strokes;
  final Color color;
  final double strokeWidth;
  final Offset offset;
  final double scale;

  DrawingState({
    this.strokes = const [],
    this.color = Colors.black,
    this.strokeWidth = 5.0,
    this.offset = Offset.zero,
    this.scale = 1.0,
  });

  DrawingState copyWith({
    List<DrawingStroke>? strokes,
    Color? color,
    double? strokeWidth,
    Offset? offset,
    double? scale,
  }) {
    return DrawingState(
      strokes: strokes ?? this.strokes,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      offset: offset ?? this.offset,
      scale: scale ?? this.scale,
    );
  }
}
