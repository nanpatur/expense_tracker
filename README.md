
# Expense Tracker App

A Flutter application designed to help users track their daily expenses.

## Table of Contents

-   [Features](#features)
-   [Getting Started](#getting-started)
-   [Installation](#installation)
-   [Project Structure](#project-structure)
-   [Technologies Used](#technologies-used)
-   [Dependencies](#dependencies)
-   [Screenshots](#screenshots)

## Features

-   Add and categorize expenses
-   Generate financial reports

## Getting Started

To get a local copy of the project up and running, follow these steps.

### Prerequisites

-   Flutter SDK
-   Android Studio or Visual Studio Code (with Flutter and Dart plugins)
-   A device/emulator to run the app

### Installation

1.  Clone the repo:
   
    `git clone https://github.com/worldwide-global-tech-development/learn-flutter--expense-tracker.git` 
    
3.  Navigate to the project directory:
   
    `cd learn-flutter--expense-tracker` 
    
5.  Install dependencies:
   
    `flutter pub get` 
    
7.  Run the app:
   
    `flutter run` 
    

## Project Structure

## Project Structure
```markdown
lib/
├── bloc/               # Business logic components for managing app states
├── database/           # Database-related files (SQLite, database helper)
├── interceptors/       # HTTP interceptors for network requests
├── i10n/               # Localization files for supporting multiple languages
├── models/             # Data models representing app entities (e.g., expenses, users)
├── network/            # Network-related files for handling API requests
├── resources/          # Static resources and repositories
├── screens/            # UI screens for various parts of the app
├── services/           # Business logic and services (e.g., authentication, data fetching)
├── widgets/            # Reusable UI components
│   ├── atoms/          # Basic building blocks of the UI
│   ├── molecules/      # Components made of atoms
│   ├── organisms/      # Complex UI components made of molecules
│   └── templates/      # Page-level UI layouts
└── main.dart
```

## Technologies Used

-   **Flutter**: UI framework
-   **Dart**: Programming language
-   **Firebase**: For authentication and cloud storage
-   **SQLite**: Local storage for offline support

## Dependencies

Here are the key dependencies used in the project:

-   `flutter_secure_storage`: For securely storing sensitive data like tokens.
-   `google_fonts`: To integrate Google Fonts into the app for custom fonts.
-   `sqflite`: To handle SQLite databases for offline storage.
-   `path`: Provides common functions to manipulate file paths.
-   `rxdart`: A reactive programming library for managing streams in Dart.
-   `dio`: A powerful HTTP client for handling advanced requests like interceptors.
-   `date_time_format`: A package to format dates and times in various patterns.
-   `intl`: Provides internationalization and localization support.
-   `flutter_dotenv`: To manage environment variables in Flutter apps.
-   `flutter_localizations`: To enable localization for different languages in the app.

### Dev Dependencies

-   `flutter_test`: For running tests on your Flutter app.

## Screenshots

(Include screenshots of the app here to showcase the UI)
