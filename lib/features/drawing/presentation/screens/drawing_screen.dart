import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:drawing_app/features/drawing/presentation/providers/drawing_provider.dart';
import '../widgets/canvas_widget.dart';
import '../widgets/tool_bar_widget.dart';

class DrawingScreen extends ConsumerWidget {
  const DrawingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey repaintBoundaryKey = GlobalKey();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Drawing App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
              ui.Image image = await boundary.toImage();
              ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
              if (byteData != null) {
                final path = await ref.read(drawingProvider.notifier).saveDrawing(byteData.buffer.asUint8List());
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Drawing saved to: $path')),
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: RepaintBoundary(
              key: repaintBoundaryKey,
              child: const CanvasWidget(),
            ),
          ),
          const ToolBarWidget(),
        ],
      ),
    );
  }
}