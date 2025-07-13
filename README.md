# intern_project

## Project Title & Description

This project appears to be a mobile application built with Flutter, potentially related to real estate ("immobilier" in French). It incorporates features like user authentication, property details, mapping, and chat functionality. The project uses a variety of assets including images, icons, and 3D models.

## Key Features & Benefits

Based on the file structure, potential features include:

*   **User Authentication:** Sign-in, sign-up, password reset (using OTP verification).
*   **Property Listing & Details:** Display of property details, possibly with 360-degree view.
*   **Interactive Map:** Integration of maps for property location.
*   **Chat Functionality:** Real-time communication between users.
*   **Favorite Properties:** Ability to save favorite properties.
*   **User Profiles:** Profile management and settings.
*   **Cross-Platform Compatibility:** Built with Flutter, targeting Android, iOS, Web, macOS, Linux, and Windows.

## Prerequisites & Dependencies

To run and develop this project, you'll need the following:

*   **Flutter SDK:**  Ensure you have Flutter installed and configured correctly. You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
*   **Dart SDK:** Dart comes bundled with Flutter, so no separate installation is required.
*   **Android SDK:**  Required for Android development.  Install via Android Studio.
*   **Xcode:**  Required for iOS development on macOS.
*   **Firebase:**  The project appears to use Firebase for authentication and potentially other services.  You'll need a Firebase project set up and the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files configured.
*   **IDE:** Recommended IDEs include VS Code with the Flutter extension or Android Studio.

## Installation & Setup Instructions

1.  **Clone the Repository:**

    ```bash
    git clone https://github.com/aziz-belloumi/intern_project.git
    cd intern_project
    ```

2.  **Install Dependencies:**

    ```bash
    flutter pub get
    ```

3.  **Firebase Configuration:**

    *   **Android:** Place the `google-services.json` file in the `android/app/` directory.
    *   **iOS:** Place the `GoogleService-Info.plist` file in the `ios/Runner/` directory.
    *   Ensure Firebase is correctly configured in your Flutter project by following the Firebase setup instructions for Flutter.

4.  **Run the Application:**

    Choose the target platform (Android, iOS, Web, etc.) and run the application.

    ```bash
    flutter run
    ```

## Usage Examples & API Documentation (if applicable)

Unfortunately, the project lacks explicit API documentation within this README. However, reviewing the code in `lib/` directory is crucial. The most relevant parts are:

*   `lib/features/authServices/`: This directory handles the Authentication part with Sign-in, Sign-up and Password resetting.
*   `lib/services/`: This directory handles the services used in the application, such as location services.
*   `lib/views/`: This directory contains the views of the application, with login, signup and welcome pages.

## Configuration Options

The project's configuration options are primarily within the code itself and the Firebase console:

*   **Firebase Settings:** Configure Firebase project settings (authentication methods, database rules, etc.) in the Firebase console.
*   **`lib/firebase_options.dart`:** Contains Firebase configuration data.
*   **`lib/constants/`:**  This directory contains constants used throughout the application, such as `app_colors.dart`, `app_links.dart`, and `app_styles.dart`. Modify these files to customize the application's appearance and links.
*   **`android/app/build.gradle` and `ios/Runner/Info.plist`:** Configure application-specific settings like bundle identifier, app name, and permissions.

## Contributing Guidelines

1.  Fork the repository.
2.  Create a new branch for your feature or bug fix.
3.  Make your changes and commit them with clear, concise messages.
4.  Submit a pull request to the `main` branch.

Please ensure your code follows the existing code style and includes appropriate tests.

## License Information

License information is currently unspecified. To add a license, consider one of the following:

*   **MIT License:** A permissive license that allows others to use, modify, and distribute your code.
*   **Apache 2.0 License:** Another popular permissive license.
*   **GNU GPLv3:** A copyleft license that requires derivative works to also be licensed under GPLv3.

To add a license, include a `LICENSE` file at the root of the repository with the full license text and update this section.

Example (for MIT License):

```
MIT License

Copyright (c) [Year] [Your Name]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## Acknowledgments (if relevant)

*   Flutter team for providing the framework.
*   Firebase team for providing the backend services.
