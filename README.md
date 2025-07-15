# ECom - A Flutter App for Evaluation 

This application uses dummyjson API for Authentication, Session Persistence, Products Listing and Product Fetching, the swift method channel is in the profile section as per requirements

## Features

- **Product Listing**: Browse products fetched from a mock API
- **Product Details**: View detailed information, specifications, and user reviews
- **User Authentication**: Secure login using dummyjson 
- **Favorites**: Mark and manage favorite products
- **Device Information**: Native Swift integration to display device details
- **Persistent Sessions**: Maintain user authentication state

## 📋 Requirements

- **Xcode**: Version 16 or above
- **Flutter**: Version 3.32.5 or above
- **iOS**: iOS 13.0 or later
- **Android**: Android API level 22 or above

## 🛠️ Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/HamzaZahid29/ecom.git
   cd immersive-commerce-app
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **iOS Setup**
   ```bash
   cd ios
   pod install
   cd ..
   ```

4. **Run the application**
   ```bash
   flutter run
   ```

##  Test Accounts

Use these pre-configured test accounts to explore the application:

| Username | Password |
|----------|----------|
| emilys | emilyspass |
| michaelw | michaelwpass |
| sophiab | sophiabpass |
| jamesd | jamesdjamesd |

> **Note**: More test accounts are available at [https://dummyjson.com/users](https://dummyjson.com/users)

##  Architecture

The application follows a **Feature First Clean MVC with Modular approach**, ensuring scalability and maintainability.

### Project Structure

```
lib/
├── core/                           # Core utilities and shared components
│   ├── constants/                  # App-wide constants
│   ├── method-channels/            # Native platform integration
│   ├── network/                    # API clients and network utilities
│   ├── providers/                  # Global state providers
│   ├── router/                     # Navigation and routing
│   ├── services/                   # Utility services
│   ├── theme/                      # App theming and styles
│   └── widgets/                    # Reusable UI components
├── features/                       # Feature-based modules
│   ├── auth/                       # Authentication feature
│   ├── details/                    # Product details feature
│   ├── device-info/                # Device information feature
│   ├── favourites/                 # Favorites management
│   ├── listings/                   # Product listings
│   └── profile/                    # User profile management
├── globals.dart                    # Global configurations
└── main.dart                       # Application entry point
```

### Key Architecture Components

- **Models**: Data structures for API responses and app state
- **Providers**: State management using Riverpod
- **Repositories**: Data access layer for API calls
- **Pages**: Screen implementations
- **Widgets**: Reusable UI components

## 🔧 Technologies Used

- **Flutter**: Cross-platform mobile development
- **Provider**: State management
- **Swift**: Native iOS integration via Method Channels
- **DIO**: API communication
- **SharedPreferences**: Local data persistence

##  Complete Flow Explanation

1. When you will launch the app the the first screen you will see is the products screen here all products are being fetched from dummy api and the like state is being managed locally.
2. When you will tap on profile icon you will be navigated to login screen if you are not authenticated.
3. After login you will be directed to products page now if you tap on profile icon you can see user's profile details.
4. You can logout from here as well as navigate to the swift method channel device info screen.
5. In the device info screen device base information is being brought through a method channel named as com.example.ecom/device_info
6. same for android.
7. The product detail screen is displayed when tapped on product took inspiration from Ali express
