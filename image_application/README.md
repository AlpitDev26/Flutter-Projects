
# Flutter Image Display 

A simple Flutter application that showcases how to display images from both local assets and remote network URLs. The app includes examples of styling images with rounded corners and shadows, as well as implementing loading and error handling for network requests.


## Features

- Display images from local app assets (Image.asset).
- Display images from network URLs (Image.network).
- Apply advanced styling with BoxDecoration for a polished look (e.g., borderRadius and boxShadow).
- Implement a loading indicator while a network image is being fetched.
- Handle network errors gracefully with a user-friendly error message.
- Uses SingleChildScrollView for a responsive layout on various screen sizes.
## Prerequisites

- Flutter SDK installed on your machine.
- A code editor like VS Code or Android Studio.
## Getting Started

**1.** Clone this repository to your local machine.

**2.** Navigate to the project directory:

```bash
  cd image_application
```

**3.** Create the necessary assets folder and add your image:
```bash
mkdir -p assets/images
```

Place an image file named togepi.png inside the assets/images folder.

**4.** Update the ```pubspec.yaml``` file to include the asset path. Ensure the indentation is correct.

```bash
flutter:
  assets:
    - assets/images/togepi.png
```

**5.** Run the application from your terminal:

```bash
flutter run
```

## Screenshots

<img width="1280" height="2856" alt="flutter_01" src="https://github.com/user-attachments/assets/f8c4fc0e-2303-4523-9ed5-566dd25b8b15" />


