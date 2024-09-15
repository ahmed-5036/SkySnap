# SkySnap - Flutter Weather App

SkySnap is a feature-rich weather app developed using Flutter. It provides users with accurate and up-to-date weather information for any location, thanks to its integration with the OpenWeather API. SkySnap is designed with scalability and maintainability in mind, leveraging the GetX package with MVC architecture for efficient state management and code organization.

## Features
- 🌤 **Real-time Weather Data**: Fetches current weather information using the OpenWeather API.
- 📍 **Location Tracking**: Uses Geolocator to provide localized weather data based on the user's current location.
- 📱 **Smooth User Interface**: Built with Flutter for a seamless and responsive user experience.
- 🚀 **Direct App Updates**: Integrates Shorebird to allow future patches and updates to be deployed directly to users' devices without requiring app store re-approval.

## Tech Stack
- **Flutter**: Cross-platform app development framework.
- **GetX**: State management and dependency injection, following the MVC architecture.
- **OpenWeather API**: Source for real-time weather data.
- **Geolocator**: Location tracking to provide weather data for the user's current location.
- **Shorebird**: Facilitates direct app updates and patches.

## Architecture
SkySnap is built using the **MVC (Model-View-Controller)** pattern with **GetX** to ensure a clean, organized, and maintainable codebase. This approach separates the user interface, business logic, and data handling, making it easier to manage and scale the app.
