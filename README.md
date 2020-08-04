# ToastUI

[![SwiftPM compatible](https://img.shields.io/badge/SwiftPM-compatible-informational)](#swift-package-manager)
[![CocoaPods compatible](https://img.shields.io/cocoapods/v/ToastUI)](#cocoapods)
[![Platform](https://img.shields.io/cocoapods/p/ToastUI)](#requirements)
[![License](https://img.shields.io/cocoapods/l/ToastUI)](#license)

`ToastUI` provides you a simple way to present toast, head-up display (HUD), custom alert, or any SwiftUI views on top of everything in SwiftUI.

<img src="https://user-images.githubusercontent.com/29722055/89260921-d4f74c00-d5f2-11ea-8a5d-31be17671139.gif"/>

## Getting started

Here is a example to present an indefinite progress indicator HUD and dismiss it after 2 seconds.

<img src="https://user-images.githubusercontent.com/29722055/89260980-e4769500-d5f2-11ea-9f1f-7368ce738fd4.gif"/>

``` swift
struct ContentView: View {
    @State private var presentingToast: Bool = false

    var body: some View {
        Button(action: {
            self.presentingToast = true
        }) {
            Text("Tap me")
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8.0)
        }
        .toast(isPresented: $presentingToast, dismissAfter: 2.0, onDismiss: {
            print("Toast dismissed")
        }) {
            ToastView("Loading...")
                .toastViewStyle(IndefiniteProgressToastViewStyle())
        }
    }
}
```

You can also present custom alerts or any SwiftUI views of your choice.

<img src="https://user-images.githubusercontent.com/29722055/89261021-f6583800-d5f2-11ea-9354-8d67ba5cdad6.gif"/>

``` swift
struct ContentView: View {
    @State private var presentingToast: Bool = false

    var body: some View {
        Button(action: {
            self.presentingToast = true
        }) {
            Text("Tap me")
                .bold()
                .foregroundColor(.white)
                .padding()
                .background(Color.accentColor)
                .cornerRadius(8.0)
        }
        .toast(isPresented: $presentingToast) {
            ToastView {
                VStack {
                    Text("Hello from ToastUI")
                        .padding(.bottom)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        self.presentingToast = true
                    }) {
                        Text("OK")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.horizontal)
                            .padding(.vertical, 12)
                            .background(Color.accentColor)
                            .cornerRadius(8.0)
                    }
                }
            }
        }
    }
}
```

Have a look at the `ToastUISample` project for more examples and also check out the [Documentation](#documentation) below.

## Requirements

* iOS 13.0+ | tvOS 13.0+
* Xcode 11.0+ | Swift 5.1+

## Installation

#### Swift Package Manager

`ToastUI` is available through [Swift Package Manager](https://swift.org/package-manager/).

For app integration, add `ToastUI` to an existing Xcode project as a package dependency:

1. From the **File** menu, select **Swift Packages > Add Package Dependency...**
2. Enter https://github.com/quanshousio/ToastUI into the package repository URL text field.
3. Xcode should choose updates package up to the next version option by default.

For package integration, add the following line to the `dependencies` parameter in your `Package.swift`.

```swift
dependencies: [
    .package(url: "https://github.com/quanshousio/ToastUI.git", from: "1.0.0")
]
```

#### CocoaPods

`ToastUI` is available through [CocoaPods](https://cocoapods.org). To install it, add the following line to your `Podfile` :

``` ruby
pod 'ToastUI'
```

## Documentation

#### Toasting

`ToastUI` supports presenting any SwiftUI views from anywhere. You just need to add `toast()` view modifier and provide your views to the `content` closure, much like using `alert()` or `sheet()` .

``` swift
.toast(isPresented: $presentingToast) {
    ToastView {
        // your SwiftUI views here
    }
}
```

`ToastView` is just a rounded rectangle shape that represents the background of your provided views and blurs underneath views. You can remove it and provide your views directly.

``` swift
.toast(isPresented: $presentingToast) {
    // your SwiftUI views here
}
```

There are two types of `toast()` view modifier:

* `toast(isPresented:dismissAfter:onDismiss:content:)` – presents a toast when the given boolean binding is true.
* `toast(item:onDismiss:content:)` – presents a toast using the given item as a data source for the toast's content.

#### Styling

`ToastUI` supports seven different `ToastView` styles out-of-the-box. You have to use `ToastView` and set the style accordingly by using `toastViewStyle(_:)` modifier.

* `DefaultProgressToastViewStyle()` – shows an empty toast if user does not provide anything. `ToastView` uses this style by default.
* `IndefiniteProgressToastViewStyle()` – shows an indefinite circular progress indicator.
* `DefiniteProgressToastViewStyle(value:total:)` – shows a definite circular progress indicator from 0 to 100%.
* `SuccessToastViewStyle()` – shows a success toast.
* `ErrorToastViewStyle()` – shows an error toast.
* `WarningToastViewStyle()` - shows a warning toast.
* `InfoToastViewStyle()` – shows an information toast.

`ToastUI` also includes a `UIVisualEffectView` wrapper through `cocoaBlur()` view modifier, which is more flexible than [ `blur(radius:opaque:)` ](https://developer.apple.com/documentation/swiftui/view/blur(radius:opaque:)) included in SwiftUI.

#### Swift 5.3+

If you are using Xcode 12.0+/Swift 5.3+, the syntax will be much cleaner thanks to support of [multiple trailing closures](https://github.com/apple/swift-evolution/blob/master/proposals/0279-multiple-trailing-closures.md) and [implicit `self` in `@escaping` closures](https://github.com/apple/swift-evolution/blob/master/proposals/0269-implicit-self-explicit-capture.md).

``` swift
Button {
    presentingToast = true
} label: {
    Text("Tap me")
}
.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
    print("Toast dismissed")
} content: {
    ToastView("Loading...")
        .toastViewStyle(IndefiniteProgressToastViewStyle())
}
```

## Contributing

All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

## Author
Quan Tran ([@quanshousio](https://quanshousio.com))

## Acknowledgements

* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) - original design of the circular progress HUD.
* [ScaledMetricOniOS13](https://gist.github.com/apptekstudios/e5f282a67beaa85dc725d1d98ec74191) - `@ScaledMetric` property wrapper for iOS 13.
* [Fruta](https://developer.apple.com/documentation/app_clips/fruta_building_a_feature-rich_app_with_swiftui) - `UIVisualEffectView` wrapper for SwiftUI written by Apple.

## License

`ToastUI` is available under the MIT license. See the LICENSE file for more info.
