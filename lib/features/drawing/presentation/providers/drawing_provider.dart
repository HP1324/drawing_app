import 'package:drawing_app/core/utils/file_saver_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'drawing_state.dart';
import '../../domain/entities/drawing_stroke.dart';
import 'dart:typed_data';

final drawingProvider = NotifierProvider<DrawingNotifier, DrawingState>(DrawingNotifier.new);

class DrawingNotifier extends Notifier<DrawingState> {
  @override
  DrawingState build() {
    return DrawingState();
  }

  final List<DrawingStroke> _undoneStrokes = [];

  void addPoint(Offset? point) {
    if (point != null) {
      state = state.copyWith(currentDrawingPoints: [...state.currentDrawingPoints, point]);
    } else {
      if (state.currentDrawingPoints.isNotEmpty) {
        state = state.copyWith(
          strokes: [
            ...state.strokes,
            DrawingStroke(
              points: List.from(state.currentDrawingPoints),
              color: state.color,
              strokeWidth: state.strokeWidth,
              opacity: state.opacity,
              blendMode: state.selectedTool == DrawingTool.eraser ? BlendMode.clear : state.blendMode,
            ),
          ],
          currentDrawingPoints: [],
        );
        _undoneStrokes.clear(); // Clear undone strokes when a new stroke is added
      }
    }
  }

  void setSelectedTool(DrawingTool tool) {
    state = state.copyWith(selectedTool: tool);
  }

  void clear() {
    state = state.copyWith(strokes: [], currentDrawingPoints: []);
    _undoneStrokes.clear();
  }

  void undo() {
    if (state.strokes.isNotEmpty) {
      final lastStroke = state.strokes.last;
      _undoneStrokes.add(lastStroke);
      state = state.copyWith(strokes: state.strokes.sublist(0, state.strokes.length - 1));
    }
  }

  void redo() {
    if (_undoneStrokes.isNotEmpty) {
      final lastUndoneStroke = _undoneStrokes.removeLast();
      state = state.copyWith(strokes: [...state.strokes, lastUndoneStroke]);
    }
  }

  void changeColor(Color color) {
    state = state.copyWith(color: color);
  }

  void changeStrokeWidth(double width) {
    state = state.copyWith(strokeWidth: width);
  }

  Future<String> saveDrawing(Uint8List bytes) async {
    return await FileSaverService.saveImage(bytes, 'drawing_${DateTime.now().millisecondsSinceEpoch}.png');
  }

  void updateOffset(Offset newOffset) {
    state = state.copyWith(offset: newOffset);
  }

  void updateScale(double newScale) {
    state = state.copyWith(scale: newScale);
  }

  void changeOpacity(double opacity) {
    state = state.copyWith(opacity: opacity);
  }

  void changeBlendMode(BlendMode blendMode) {
    state = state.copyWith(blendMode: blendMode);
  }
}