import 'package:drawing_app/core/constants/theme_provider.dart';
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

    return Row(
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
        IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            ref.read(drawingProvider.notifier).changeColor(Colors.black);
          },
        ),
        IconButton(
          icon: const Icon(Icons.square_outlined),
          onPressed: () {
            ref.read(drawingProvider.notifier).erase();
          },
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
    );
  }
}

