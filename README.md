# Pokémon App

A SwiftUI application that offers a sleek and interactive way to browse, search, and view detailed information about Pokémon. The app is built with a clean MVVM (Model-View-ViewModel) architecture to ensure organized and maintainable code.

## Features

- **Coordinator Pattern with Navigation Stack**: The app uses a navigation stack and the coordinator pattern to manage screen transitions effectively, keeping the navigation logic modular and maintainable.
- **Custom Networking Layer**: A custom-built networking layer is implemented to handle API requests, ensuring reliability, scalability, and ease of testing.
- **Browse Pokémon**: Explore a wide range of Pokémon with detailed stats and images.
- **Search Functionality**: Quickly find specific Pokémon by their name or attributes.
- **Detailed Information**: Access comprehensive details about each Pokémon, including type, stats, and abilities.
- **Smooth Performance**: Optimized for fast loading and seamless user experience.
- **Clean UI**: A visually pleasing and user-friendly interface designed using SwiftUI.

## Architecture

This project incorporates the **MVVM (Model-View-ViewModel)** architecture pattern, along with a **Navigation Stack** and the **Coordinator Pattern** for managing screen transitions and maintaining a clean separation of concerns in navigation logic.

- **Model**: Represents the data retrieved from APIs or local storage.
- **View**: Handles the UI components and user interactions.
- **ViewModel**: Acts as a bridge between the Model and the View, managing the app's logic and data flow.
- **Coordinator Pattern**: Ensures that navigation logic is delegated to dedicated coordinators, making the codebase more modular and easier to maintain.

## Technology Stack

- **Language**: Swift
- **Framework**: SwiftUI
- **Design Pattern**: MVVM, Coordinator Pattern
- **Networking**: Custom Networking Layer
- **Tools**: Xcode, Git

## Getting Started

Follow the steps below to set up and run the Pokémon app on your local machine:

### Prerequisites

- macOS with the latest version of Xcode installed.
- Basic knowledge of Swift and SwiftUI.

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/abdallah-7698/Pokemon.git
   ```
2. Open the project in Xcode:
   ```bash
   cd Pokemon
   open Pokemon.xcodeproj
   ```
3. Build and run the project on the simulator or a physical device.

## Contribution

Contributions are welcome! If you'd like to contribute to the project, please follow these steps:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
   ```bash
   git checkout -b feature-name
   ```
3. Commit your changes and push them to your fork:
   ```bash
   git commit -m "Description of changes"
   git push origin feature-name
   ```
4. Create a pull request to merge your changes into the main repository.

## License

This project is currently unlicensed. Please contact the repository owner for more details.

## Acknowledgments

- Special thanks to all contributors and the open-source community for their inspiration and support.

---

[View on GitHub](https://github.com/abdallah-7698/Pokemon)
