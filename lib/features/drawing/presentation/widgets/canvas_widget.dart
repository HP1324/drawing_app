import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drawing_app/features/drawing/presentation/providers/drawing_provider.dart';
import '../providers/drawing_state.dart';

class CanvasWidget extends ConsumerWidget {
  const CanvasWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingState = ref.watch(drawingProvider);

    return InteractiveViewer(
      panEnabled: true,
      scaleEnabled: true,
      minScale: 0.5,
      maxScale: 5.0,
      onInteractionUpdate: (details) {
        ref.read(drawingProvider.notifier).updateOffset(details.focalPoint - details.localFocalPoint);
        ref.read(drawingProvider.notifier).updateScale(details.scale);
      },
      child: MouseRegion(
        cursor: drawingState.selectedTool == DrawingTool.pen ? SystemMouseCursors.precise : SystemMouseCursors.forbidden,
        child: GestureDetector(
          onPanUpdate: (details) {
            final RenderBox renderBox = context.findRenderObject() as RenderBox;
            final Offset localPosition = renderBox.globalToLocal(details.globalPosition);
            ref.read(drawingProvider.notifier).addPoint((localPosition - drawingState.offset) / drawingState.scale);
          },
          onPanEnd: (details) {
            ref.read(drawingProvider.notifier).addPoint(null);
          },
          child: CustomPaint(
            painter: DrawingPainter(drawingState),
            child: Container(),
          ),
        ),
      ),
    );
  }
}

class DrawingPainter extends CustomPainter {
  final DrawingState drawingState;

  DrawingPainter(this.drawingState);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Offset.zero & size, Paint()..color = drawingState.backgroundColor);

    for (final stroke in drawingState.strokes) {
      final paint = Paint()
        ..color = stroke.color.withOpacity(stroke.opacity)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = stroke.strokeWidth / drawingState.scale
        ..blendMode = stroke.blendMode;

      for (int i = 0; i < stroke.points.length - 1; i++) {
        canvas.drawLine(
          stroke.points[i] * drawingState.scale + drawingState.offset,
          stroke.points[i + 1] * drawingState.scale + drawingState.offset,
          paint,
        );
      }
    }

    // Draw the current drawing points
    final currentPaint = Paint()
      ..color = drawingState.color.withOpacity(drawingState.opacity)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = drawingState.strokeWidth / drawingState.scale
      ..blendMode = drawingState.selectedTool == DrawingTool.eraser ? BlendMode.clear : drawingState.blendMode;

    for (int i = 0; i < drawingState.currentDrawingPoints.length - 1; i++) {
      canvas.drawLine(
        drawingState.currentDrawingPoints[i] * drawingState.scale + drawingState.offset,
        drawingState.currentDrawingPoints[i + 1] * drawingState.scale + drawingState.offset,
        currentPaint,
      );
    }
  }

  @override
  bool shouldRepaint(DrawingPainter oldDelegate) => true;
}
