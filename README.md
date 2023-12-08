# Flutter Basic Weather Application

This weather app built using flutter,openweather and used firebase for user authentication

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## About Application

Development of a weather application using the Flutter framework,In this application user can get real time weather information.This app offers users the option to receive weather updates for their current location or explore weather conditions in different cities around the world also users can search city for real time weather application. 

The application provides up-to-date information on temperature, humidity, wind speed, and other relevant metrics for the user's selected location.

The application utilizes APIs to fetch current weather data, forecasts, and other relevant information from reliable weather services.

## Key Features

- Automatically Gets Weather Information using Device real-time location
- User can get weather information for any city by searching the city 

## ScreenShots

<details>
    <summary>see screenshots</summary>
    <img src="https://github.com/devendra-official/weather-application/blob/master/assets/screenshots/screenshot1.jpg" width=300>
    <img src="https://github.com/devendra-official/weather-application/blob/master/assets/screenshots/screenshot2.jpg" width=300>
    <img src="https://github.com/devendra-official/weather-application/blob/master/assets/screenshots/screenshot3.jpg" width=300>
    <img src="https://github.com/devendra-official/weather-application/blob/master/assets/screenshots/screenshot4.jpg" width=300>
</details>

## API and Firebase

- API used for real time weather information and Reverse geo-coding ==> [https://openweathermap.org/](https://openweathermap.org/)   [Free Version]
- Firebase Authentication for user authentication ==> [https://firebase.google.com/](https://firebase.google.com/)

## RUN THIS CODE

1. create flutter application
2. Replace `lib/` folder and `pubspec.yaml`
3. Copy assets folder to your flutter app root folder
4. Install packages

    ```bash
    flutter pub get
    ```
5. Get your [OPENWEATHER API KEY](https://home.openweathermap.org/api_keys)
6. create .env file in your flutter_project root folder
7. copy and paste in `.env` file

    ```
    OPENWEATHER_KEY = YOURAPIKEY
    ```
8. Make sure you set the compileSdkVersion in your "android/app/build.gradle" file to 33:
    ```
    android {
        compileSdkVersion 33
        ...
    }
    ```
9. Add this line in your `android/app/src/main/AndroidManifest.xml` as direct Children of `<manifest>`

    ```xml
    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
    <uses-permission android:name="android.permission.ACCESS_BACKGROUND_LOCATION" />
    ```
10. connct your app to firebase, [Documentation](https://firebase.google.com/docs/flutter/setup?platform=android)
11. Run this in your flutter project folder

    ```bash
    flutter run
    ```
