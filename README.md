# Location Tracker

## Project Overview

The **Location Tracker** is a Flutter application designed to track user locations in real-time. It utilizes various services to manage user permissions, display maps, and handle user data effectively. The app is structured to facilitate easy navigation and maintainability.

## Project Structure

The project is organized into several key directories and files:

- **lib/**

  - **controllers/**: Contains the business logic of the application. Controllers manage the state and handle user interactions.
    - `global.dart`: Manages global state and user permissions.
    - `user_details.dart`: Handles user-specific data and todo lists.
  - **models/**: Defines the data structures used in the application.
    - `todo_model.dart`: Represents a todo item.
    - `user_model.dart`: Represents a user.
  - **routers/**: Manages the routing of the application.
    - `bindings.dart`: Defines the dependencies for different screens.
    - `router.dart`: Contains the routes for navigation.
  - **screens/**: Contains the UI components of the application.
    - `map_overview.dart`: Displays the map and user location.
    - `user_details.dart`: Shows user details and their todo list.
  - **services/**: Contains services for handling external functionalities.
    - `my_locator.dart`: Manages location services.
    - `my_permission.dart`: Handles permission requests.
  - **widgets/**: Contains reusable UI components.
    - `button/primary.dart`: Defines a primary button widget.
    - `card/todo_card.dart`: Displays a todo item.
    - `card/user_overview.dart`: Displays user information.

- **android/**: Contains Android-specific configurations and files.
- **ios/**: Contains iOS-specific configurations and files.
- **web/**: Contains web-specific configurations and files.
- **pubspec.yaml**: Defines the dependencies and metadata for the Flutter project.

## Architecture Overview

The architecture of the **Location Tracker** application follows the **Model-View-Controller (MVC)** pattern, which separates the application into three interconnected components:

1. **Model**:

   - Represents the data and business logic of the application.
   - In this project, models like `UserModel` and `TodoModel` define the structure of user and todo data, respectively.

2. **View**:

   - Represents the UI components of the application.
   - The `screens` directory contains various screens such as `UserDetailsScreen` and `MapOverviewScreen`, which are responsible for displaying data to the user and handling user interactions.

3. **Controller**:
   - Acts as an intermediary between the Model and the View.
   - Controllers like `UserDetailsController` and `GlobalController` manage the state of the application, handle user input, and update the view accordingly.

### Key Components

- **State Management**: The application uses the `GetX` package for state management, which allows for reactive programming and easy dependency injection.
- **Routing**: The `routers` directory manages navigation between different screens, ensuring a smooth user experience.
- **Services**: The `services` directory contains classes that handle external functionalities, such as location services and API calls.
- **Widgets**: The `widgets` directory contains reusable UI components that can be used across different screens, promoting code reusability and maintainability.

3. **Set Up Permissions**:

   - For **Android**, ensure that the necessary permissions are added in `android/app/src/main/AndroidManifest.xml`.
   - For **iOS**, ensure that the location permissions are defined in `ios/Runner/Info.plist`.

4. **Run the Application**:
   You can run the application on an emulator or a physical device:

   ```bash
   flutter clean && flutter pub get && flutter run --release

   ```

5. **Web Support**:
   If you want to run the application on the web, ensure you have the web environment set up and run:
   ```bash
   flutter run -d chrome
   ```

## Contributing

Contributions are welcome! Please feel free to submit a pull request or open an issue for any suggestions or improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
