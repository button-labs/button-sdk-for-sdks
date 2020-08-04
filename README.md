# Embedding the Button SDK in your SDK

This repository contains an example of how to transparently include the Button SDK in your own SDK that is distributed to customers as a closed-source product.

## iOS
![Button On-Device Personalization@2x](https://user-images.githubusercontent.com/1068437/89589263-4dd4ee80-d813-11ea-8e7a-04609d7e4a0d.png)
The iOS example contains a PartnerApp and an example SDK (called `YourSDK`) that includes the current publicly-available version of the Button iOS SDK and compiles it into the xcframework which is included in the PartnerApp.

* All Button functionality works
* No methods of Button exposed
* YourSDK DSYMs include Button SDK symbols
* Supports iOS 9+

In the example, `YourSDK` is linked to `PartnerApp` as a project dependency. You can also try out integrating a pre-compiled `YourSDK` build using Carthage.

Build the `YourSDK` framework with Carthage

```
➜ carthage build --no-skip-current
```

Unlink the `YourSDK` framework in the project, and replace it with one generated at `./Carthage/Build/iOS/YourSDK.framework`


## Android
![Button On-Device Personalization@2x (2)](https://user-images.githubusercontent.com/1068437/89589240-401f6900-d813-11ea-98ac-cc6a70fcd7af.png)

The Android example contains a PartnerApp and an example SDK (called `YourSDK`) that includes the current publicly-available version of the Button Android SDK and includes it in the YourSDK package as a dependency, which is the included in the PartnerApp

* All Button functionality works
* No methods of Button exposed
* Supports Android Lollipop+


## Running the Examples

To run either project, you'll need your Button `applicationId`, which you can get from the [Button Dashboard](https://app.usebutton.com).

In the example, `YourSDK` uses a configuration flag to determine whether to enable the Button SDK. You'll see the Button initialization output in the console when Button is enabled.
