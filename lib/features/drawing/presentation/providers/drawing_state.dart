import 'package:flutter/material.dart';
import '../../domain/entities/drawing_stroke.dart';

enum DrawingTool {
  pen,
  eraser,
}

class DrawingState {
  final List<DrawingStroke> strokes;
  final List<Offset> currentDrawingPoints;
  final Color color;
  final double strokeWidth;
  final double opacity;
  final BlendMode blendMode;
  final Offset offset;
  final double scale;
  final DrawingTool selectedTool;
  final Color backgroundColor;

  DrawingState({
    this.strokes = const [],
    this.currentDrawingPoints = const [],
    this.color = Colors.black,
    this.strokeWidth = 5.0,
    this.opacity = 1.0,
    this.blendMode = BlendMode.srcOver,
    this.offset = Offset.zero,
    this.scale = 1.0,
    this.selectedTool = DrawingTool.pen,
    this.backgroundColor = Colors.white,
  });

  DrawingState copyWith({
    List<DrawingStroke>? strokes,
    List<Offset>? currentDrawingPoints,
    Color? color,
    double? strokeWidth,
    double? opacity,
    BlendMode? blendMode,
    Offset? offset,
    double? scale,
    DrawingTool? selectedTool,
    Color? backgroundColor,
  }) {
    return DrawingState(
      strokes: strokes ?? this.strokes,
      currentDrawingPoints: currentDrawingPoints ?? this.currentDrawingPoints,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      opacity: opacity ?? this.opacity,
      blendMode: blendMode ?? this.blendMode,
      offset: offset ?? this.offset,
      scale: scale ?? this.scale,
      selectedTool: selectedTool ?? this.selectedTool,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}
