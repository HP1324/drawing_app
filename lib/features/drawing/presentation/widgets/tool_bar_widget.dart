import 'dart:ui';
import 'package:drawing_app/features/drawing/presentation/providers/drawing_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:drawing_app/features/drawing/presentation/providers/drawing_provider.dart';
import 'package:drawing_app/core/constants/theme_provider.dart';

class ToolBarWidget extends ConsumerWidget {
  const ToolBarWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final drawingState = ref.watch(drawingProvider);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16.0),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
        IconButton(
          icon: const Icon(Icons.undo),
          onPressed: () {
            ref.read(drawingProvider.notifier).undo();
          },
        ),
        IconButton(
          icon: const Icon(Icons.redo),
          onPressed: () {
            ref.read(drawingProvider.notifier).redo();
          },
        ),
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            ref.read(drawingProvider.notifier).clear();
          },
        ),
        IconButton(
          icon: const Icon(Icons.color_lens),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pick a color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: drawingState.color,
                      onColorChanged: (color) {
                        ref.read(drawingProvider.notifier).changeColor(color);
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
        Slider(
          value: drawingState.strokeWidth,
          min: 1.0,
          max: 20.0,
          onChanged: (value) {
            ref.read(drawingProvider.notifier).changeStrokeWidth(value);
          },
        ),
        Slider(
          value: drawingState.opacity,
          min: 0.0,
          max: 1.0,
          onChanged: (value) {
            ref.read(drawingProvider.notifier).changeOpacity(value);
          },
        ),
        DropdownButton<BlendMode>(
          value: drawingState.blendMode,
          onChanged: (BlendMode? newValue) {
            if (newValue != null) {
              ref.read(drawingProvider.notifier).changeBlendMode(newValue);
            }
          },
          items: BlendMode.values.map((BlendMode blendMode) {
            return DropdownMenuItem<BlendMode>(
              value: blendMode,
              child: Text(blendMode.toString().split('.').last),
            );
          }).toList(),
        ),
        ToggleButtons(
          isSelected: [
            drawingState.selectedTool == DrawingTool.pen,
            drawingState.selectedTool == DrawingTool.eraser,
          ],
          onPressed: (int index) {
            if (index == 0) {
              ref.read(drawingProvider.notifier).setSelectedTool(DrawingTool.pen);
              ref.read(drawingProvider.notifier).changeColor(Colors.black); // Reset color to black for pen
            } else {
              ref.read(drawingProvider.notifier).setSelectedTool(DrawingTool.eraser);
            }
          },
          children: const [
            Tooltip(message: 'Pen', child: Icon(Icons.edit)),
            Tooltip(message: 'Eraser', child: Icon(Icons.square_outlined)),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: () async {
            // This will be handled in drawing_screen.dart
          },
        ),
        IconButton(
          icon: const Icon(Icons.brightness_6),
          onPressed: () {
            ref.read(themeProvider.notifier).toggleTheme();
          },
        ),
        IconButton(
          icon: const Icon(Icons.palette),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Pick a primary color!'),
                  content: SingleChildScrollView(
                    child: ColorPicker(
                      pickerColor: ref.watch(themeProvider).primaryColor,
                      onColorChanged: (color) {
                        ref.read(themeProvider.notifier).changePrimaryColor(color);
                      },
                    ),
                  ),
                  actions: <Widget>[
                    TextButton(
                      child: const Text('Got it'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            );
          },
        ),
      ],
    ),
  ),
),
    );
  }
}

