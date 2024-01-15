# GTM mobile sample app

This project is an example to configure GTM (Google Tag Manager) on app. Also, is an example to log event to GA4 (Google Analytics 4)

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
- [Set up and install Tag Manager](https://support.google.com/tagmanager/answer/6103696?hl=en)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Perquisites

1. Please refer to this [link](https://support.google.com/tagmanager/answer/6103696?hl=en#zippy=%2Cwhat-is-a-tag) to set up 2 GTM container and relevant tags

- GTM container for Android ([Reference](https://developers.google.com/tag-platform/tag-manager/android/v5))
- GTM container for iOS ([Reference](https://developers.google.com/tag-platform/tag-manager/ios/v5))

2. Download the selected container version (GTM-XXXXXXXX.json) and place them under ```app/src/main/assets/containers/GTM-XXXXXX.json``` folder (android) and ```PROJECT_ROOT/container/GTM-XXXXXX.json```folder (iOS)

## Local development

To start developing locally, please follow the below steps

1. Clone the git repository and install the flutter packages.

    ```bash
    flutter pub get
    ```

2. Log into Firebase using your Google account with the below command. (It require to install the [Firebase CLI](https://firebase.google.com/docs/cli#setup_update_cli))

    ```bash
    firebase login 
    ```

3. Install the FlutterFire CLI with the following command.

    (You may need to add the path of Pub to your shells' config file. Please follow the response of the command to add the path.)

    ```bash
    dart pub global activate flutterfire_cli
    ```

4. Run the below command to configure the apps to connect to Firebase.

    ```bash
    flutterfire configure
    ```

    You may need to manually download the GoogleService-info.plist file from Firebase console. And put it in ios/Runner. Check the folder position in Xcode and rebuild it if needed.

5. Run the flutter application

    ```bash
    flutter run
    ```

    Or Open VS code to and use **Run and Debug** to run the application

## Enable Debug mode

### iOS

 Go Product -> Edit Scheme -> Run -> Arguments. Add 2 arguments ```-FIRAnalyticsDebugEnabled``` and ```-FIRDebugEnabled```

### Android

To enable Analytics debug mode on an Android device, execute the following commands: (You may need to install adb first)

```adb shell setprop debug.firebase.analytics.app com.example.gtm_mobile_sample_app```

This behavior persists until you explicitly disable debug mode by executing the following command:

```adb shell setprop debug.firebase.analytics.app .none.```

## References

- Flutter package - [firebase_analytics 10.8.0](https://pub.dev/packages/firebase_analytics/example)
- Debug view in Firebase - [Debug events](https://firebase.google.com/docs/analytics/debugview)
