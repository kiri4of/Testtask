
# Testtask


# TeskTask 

A simple iOS application built with **Swift** and **UIKit**, designed to fetch a list of users (with pagination), allow user registration (including a photo upload), and monitor network connectivity. This README guides you through configuration, dependencies, troubleshooting tips, and instructions to build the application.

---

## Table of Contents

1. [Configuration and Customization](#1-configuration-and-customization)
    - [1.1. API Endpoints](#11-api-endpoints)
    - [1.2. Pagination Settings](#12-pagination-settings)
    - [1.3. UI (Colors and Fonts)](#13-ui-colors-and-fonts)
    - [1.4. Image Assets](#14-image-assets)
    - [1.5. Adapted Dimension](#15-adapted-dimension)
2. [Dependencies and External Libraries](#2-dependencies-and-external-libraries)
    - [2.1. Swift Package Manager (SPM)](#21-swift-package-manager-spm)
    - [2.2. SnapKit](#22-snapskit)
    - [2.3. Alamofire](#23-alamofire)
    - [2.4. Network Framework](#24-network-framework)
    - [2.5. Custom Components](#25-custom-components)
3. [Troubleshooting and Common Issues](#3-troubleshooting-and-common-issues)
    - [3.1. Images Flicker or Reload](#31-images-flicker-or-reload)
    - [3.2. Offline / “No Internet” Screen](#32-offline--no-internet-screen)
    - [3.3. Pagination Stops](#33-pagination-stops)
    - [3.4. Registration Button Disabled](#34-registration-button-disabled)
    - [3.5. Token Issues](#35-token-issues)
4. [Build Instructions](#4-build-instructions)
    - [4.1. Prerequisites](#41-prerequisites)
    - [4.2. Steps](#42-steps)

---
## 1. Configuration and Customization 
### 1.1. API Endpoints
The app interacts with external APIs to fetch users, positions, and handle user registrations. You can configure the **base URL** and endpoints by modifying files like `MainEndpoint`, `SignUpEndpoint`, `TokenEndpoint`, and `PositionsEndpoint`. For example:

```swift
enum MainEndpoint {
    case getUsers(page: Int, count: Int)
    
    var baseURL: URL {
        URL(string: "https://frontend-test-assignment-api.abz.agency")!
    }
    
    // ... other properties for path, httpMethod, headers, etc.
}

``` 
### 1.2. Pagination Settings
To control how many users are fetched per API call, change the pageSize in your ViewModel (e.g., MainViewModel):

```swift
private let pageSize = 6 // Number of users per page
``` 

### 1.3. UI (Colors and Fonts)
Colors are defined in a utility struct (e.g., AppColors). Adjust them as you prefer:
```swift
struct AppColors {
    static let buttonBgColor = UIColor.systemBlue
    // ... other color definitions
}
```
Fonts are managed in a struct (e.g., AppFonts). Modify them as needed:
```swift

struct AppFonts {
    static let nunito18Regular  = UIFont(name: "Nunito-Regular", size: 18)!
    static let nunito18SemiBold = UIFont(name: "Nunito-SemiBold", size: 18)!
    // ... other font definitions
}
``` 
### 1.4. Image Assets
Ensure all necessary images (e.g., placeholders, background images, etc.) are added to your project’s Assets folder. Replace names like noNetworkBgImage or placeholderAvatar if you use different asset names. 
### 1.5. Adapted Dimension
If your project uses an adapted method for handling dimensions across different screen sizes, ensure it's correctly implemented. This method typically adjusts UI elements based on the device's screen size to maintain consistency.
```swift
func adapted(dimensionSize: CGFloat, to type: DimensionType) -> CGFloat {
    // Implementation for adapting dimensions
}
``` 
Ensure that DimensionType and related logic are properly defined and utilized throughout your UI setup.

## 2. Dependencies and External Libraries
### 2.1. Swift Package Manager (SPM) 
You added your dependencies via Swift Package Manager. If you need to add more libraries, go to File > Add Packages... in Xcode and provide the relevant GitHub URL. Some commonly used packages in this project include:
### 2.2. SnapKit
* Purpose: A concise Auto Layout DSL for iOS.
* Usage: Used for setting up UI constraints programmatically in a clean and readable manner. 
```swift
import SnapKit

headerView.snp.makeConstraints { make in
    make.top.equalTo(self.safeAreaLayoutGuide)
    make.leading.trailing.equalToSuperview()
    make.height.equalTo(adapted(dimensionSize: 56, to: dimension))
}
```
### 2.3. Alamofire
* Purpose: An elegant HTTP networking library for Swift.
* Usage: Utilized for handling network requests, simplifying API interactions compared to using URLSession directly.
```swift
import Alamofire

AF.request("https://api.example.com/getUsers", method: .get).response { response in
    // Handle response
}
``` 
### 2.4. Network Framework
* Purpose: Enables real-time network path monitoring.
* Usage: In SceneDelegate, used to detect connectivity changes and switch between the main screen and a “No Internet” screen.
```swift
import Network

private var monitor = NWPathMonitor()
monitor.start(queue: DispatchQueue.global(qos: .background))
``` 
### 2.5. Custom Components
* RadioButton: A selectable radio option for choosing a user position.
* TextFieldWithErrorView: Displays validation error messages below a UITextField.
* UploadButton: A button component for uploading photos and showing the file name.
These components are tailored to fit the app's design requirements and enhance user interaction.

## 3. Troubleshooting and Common Issues
### 3.1. Offline / “No Internet” Screen
* Cause: NWPathMonitor might briefly report no connection or get triggered at launch.
* Solution: Provide a neutral splash or loading view while the real connectivity state is determined; ensure monitor.start(queue:) is correctly invoked.
### 3.2. Pagination Stops
* Cause: currentPage might not increment, or isLoading never resets.
* Solution: Verify that upon each successful fetch, if the server returns exactly pageSize users, you increment currentPage. Also, unlock isLoading = false after finishing a network request.
### 3.3. Registration Button Disabled
* Cause: Form validation fails, or the user has not uploaded a required photo.
* Solution: Check the logic in updateSignUpButtonState(), ensuring it runs whenever the user changes text fields or uploads an image.
### 3.4. Token Issues
* Cause: The server requires a valid token for a single request (or within 40 minutes).
* Solution: Make sure you call fetchToken() before sign-up, then pass the token in the header. If your token is single-use, reacquire a new token each time.

## 4. Build Instructions
### 4.1. Prerequisites
* Xcode: Preferably version 14 or higher.
* Swift Package Manager (SPM): Built into Xcode. No need for CocoaPods.
### 4.2. Steps 
1. Clone the Repository

```terminal
git clone https://github.com/kiri4of/Testtask
cd Testtask 
```
2. Open in Xcode

* Double-click TestTask.xcodeproj.
* Ensure Swift Packages are resolved. If needed, go to File > Packages > Reset Package Caches.
3. Configure API Endpoints

* Modify or verify your endpoint files (MainEndpoint, SignUpEndpoint, PositionsEndpoint, etc.) to match your backend setup.
4. Build and Run

* Select a simulator or real device in Xcode.
* Press Run or use Cmd + R.
5. Testing

* Network Connectivity: Toggle network connectivity (Wi-Fi off/on or Airplane mode) to confirm the “No Internet” screen triggers.
* Pagination: Scroll to the bottom of the user list to confirm more users load (pagination).
* Registration: Attempt new user registration to confirm form validation and server interaction.
## 🚀 About Me
iOS developer from Kharkiv. 21 y.o.


## Feedback

If you have any feedback, please reach out to us at kiri4of@gmail.com


## Screenshots
* https://ibb.co/vJ41Jrw
* https://ibb.co/17WJXRH

