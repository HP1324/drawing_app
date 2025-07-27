# Drawing App Plan

## Project Structure

The project will follow the clean architecture principles using the Riverpod framework for state management. The folder structure will be as follows:

```
/
|-- .github/
|   |-- workflows/
|       |-- main.yml
|-- .idea/
|-- android/
|-- build/
|-- lib/
|   |-- main.dart
|   |-- core/
|   |   |-- constants/
|   |   |-- utils/
|   |   |-- di/
|   |-- features/
|   |   |-- drawing/
|   |   |   |-- data/
|   |   |   |   |-- datasources/
|   |   |   |   |   |-- drawing_local_data_source.dart
|   |   |   |   |-- models/
|   |   |   |   |   |-- drawing_model.dart
|   |   |   |   |-- repositories/
|   |   |   |       |-- drawing_repository_impl.dart
|   |   |   |-- domain/
|   |   |   |   |-- entities/
|   |   |   |   |   |-- drawing.dart
|   |   |   |   |-- repositories/
|   |   |   |   |   |-- drawing_repository.dart
|   |   |   |   |-- usecases/
|   |   |   |       |-- get_drawings.dart
|   |   |   |       |-- save_drawing.dart
|   |   |-- presentation/
|   |       |-- providers/
|   |       |   |-- drawing_provider.dart
|   |       |-- screens/
|   |       |   |-- drawing_screen.dart
|   |       |-- widgets/
|   |           |-- canvas_widget.dart
|   |           |-- color_picker_widget.dart
|   |           |-- tool_bar_widget.dart
|-- test/
|-- .gitignore
|-- pubspec.yaml
|-- README.md
```

## Features

-   **Drawing Canvas:** A canvas where users can draw freely.
-   **Multiple Brush Sizes:** Ability to change the size of the drawing brush.
-   **Color Palette:** A color picker to select different colors for the brush.
-   **Undo/Redo:** Undo and redo functionality for the drawing actions.
-   **Eraser:** An eraser tool to remove parts of the drawing.
-   **Save/Export:** Save the drawing as an image file (e.g., PNG, JPEG).
-   **Pan and Zoom:** Pan and zoom the canvas.
-   **Clear Canvas:** A button to clear the entire canvas.

## Theming

-   **Light and Dark Mode:** The app will support both light and dark themes.
-   **Customizable Theme:** Users can customize the theme colors.

## Cloud Deployment

-   **Google Cloud Run:** The application will be deployed as a containerized application on Google Cloud Run.
-   **CI/CD:** A CI/CD pipeline will be set up using GitHub Actions to automatically build and deploy the application on every push to the `main` branch.

## Folder Structure Creation

I will now create the folder structure as outlined above.
