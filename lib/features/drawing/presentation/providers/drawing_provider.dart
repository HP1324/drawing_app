import 'package:drawing_app/core/utils/file_saver_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'drawing_state.dart';
import '../../domain/entities/drawing_stroke.dart';
import 'dart:typed_data';

final drawingProvider = StateNotifierProvider<DrawingNotifier, DrawingState>((ref) {
  return DrawingNotifier();
});

class DrawingNotifier extends StateNotifier<DrawingState> {
  DrawingNotifier() : super(DrawingState());

  List<Offset> _currentPoints = [];
  final List<DrawingStroke> _undoneStrokes = [];

  void addPoint(Offset? point) {
    if (point != null) {
      _currentPoints.add(point);
    } else {
      if (_currentPoints.isNotEmpty) {
        state = state.copyWith(strokes: [...state.strokes, DrawingStroke(points: List.from(_currentPoints), color: state.color, strokeWidth: state.strokeWidth)]);
        _currentPoints = [];
        _undoneStrokes.clear(); // Clear undone strokes when a new stroke is added
      }
    }
  }

  void clear() {
    state = state.copyWith(strokes: []);
    _currentPoints = [];
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

  void erase() {
    state = state.copyWith(color: Colors.white);
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
}