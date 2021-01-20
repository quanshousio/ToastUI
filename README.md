<h1 align="center">
  <img src="https://raw.githubusercontent.com/quanshousio/ToastUI/master/ToastUI.svg" alt="ToastUI logo" width="50%">
</h1>

<h3 align="center">
  A simple way to show toast in SwiftUI
</h3>

<p align="center">
  <strong><a href="https://quanshousio.github.io/ToastUI/">Documentation</a></strong>
  •
  <strong><a href="#getting-started">Example</a></strong>
  •
  <strong><a href="CHANGELOG.md">Change Log</a></strong>
</p>

<p align="center">
  <a href="#swift-package-manager">
    <img src="https://img.shields.io/badge/SwiftPM-compatible-informational" alt="Swift Package Manager">
  </a>
  <a href="#cocoapods">
    <img src="https://img.shields.io/cocoapods/v/ToastUI" alt="CocoaPods">
  </a>
  <a href="#requirements">
    <img src="https://img.shields.io/cocoapods/p/ToastUI" alt="Platform">
  </a>
  <a href="#license">
    <img src="https://img.shields.io/cocoapods/l/ToastUI" alt="License">
  </a>
</p>

<p align="center">
  <img src="https://user-images.githubusercontent.com/29722055/89260921-d4f74c00-d5f2-11ea-8a5d-31be17671139.gif" alt="demo" width="42%">
</p>

## Overview

`ToastUI` provides you a simple way to present toast, head-up display (HUD), custom alert, or any SwiftUI views on top of everything in SwiftUI.

* [Getting started](#getting-started)
* [Requirements](#requirements)
* [Installation](#installation)
* [Documentation](#documentation)
* [Contributing](#contributing)
* [Author](#author)
* [Acknowledgements](#acknowledgements)
* [License](#license)

## Getting started

Here is an example to present an indefinite progress indicator HUD and dismiss it after 2 seconds.

<img src="https://user-images.githubusercontent.com/29722055/89260980-e4769500-d5f2-11ea-9f1f-7368ce738fd4.gif"/>

``` swift
struct ContentView: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    Button {
      presentingToast = true
    } label: {
      Text("Tap me")
        .bold()
        .foregroundColor(.white)
        .padding()
        .background(Color.accentColor)
        .cornerRadius(8.0)
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      print("Toast dismissed")
    } content: {
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
    Button {
      presentingToast = true
    } label: {
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

          Button {
            presentingToast = false
          } label: {
            Text("OK")
              .bold()
              .foregroundColor(.white)
              .padding(.horizontal)
              .padding(.vertical, 12.0)
              .background(Color.accentColor)
              .cornerRadius(8.0)
          }
        }
      }
    }
  }
}
```

Have a look at the [ `ToastUISample` ](ToastUISample) project for more examples and also check out the [Documentation](#documentation) below.

## Requirements

* iOS 14.0+ | tvOS 14.0+ | macOS 11.0+
* Xcode 12.0+ | Swift 5.3+

## Installation

#### Swift Package Manager

`ToastUI` is available through [Swift Package Manager](https://swift.org/package-manager/).

For app integration, add `ToastUI` to an existing Xcode project as a package dependency:

1. From the **File** menu, select **Swift Packages > Add Package Dependency...**
2. Enter https://github.com/quanshousio/ToastUI into the package repository URL text field.
3. Xcode should choose updates package up to the next version option by default.

For package integration, add the following line to the `dependencies` parameter in your `Package.swift` .

``` swift
dependencies: [
  .package(url: "https://github.com/quanshousio/ToastUI.git", from: "2.0.0")
]
```

#### CocoaPods

`ToastUI` is available through [CocoaPods](https://cocoapods.org). To install it, add the following line to your `Podfile` :

``` ruby
pod 'ToastUI'
```

## Documentation

For more detailed documentation, please see **[here](https://quanshousio.github.io/ToastUI/)**.

#### Presenting

`ToastUI` supports presenting any SwiftUI views from anywhere. You just need to add `toast()` view modifier and provide your views, much like using `alert()` or `sheet()` .

``` swift
.toast(isPresented: $presentingToast) {
  // your SwiftUI views here
}
```

There are two types of `toast()` view modifier. For more usage information, check out the [examples](ToastUISample).

* `toast(isPresented:dismissAfter:onDismiss:content:)` – presents a toast when the given boolean binding is true.
* `toast(item:dismissAfter:onDismiss:content:)` – presents a toast using the given item as a data source for the toast's content.

#### ToastView

`ToastUI` comes with `ToastView` , which visually represented as a rounded rectangle shape that contains your provided views and has a default thin blurred background.

``` swift
.toast(isPresented: $presentingToast) {
  ToastView("Hello from ToastUI")
}
```

Layout of `ToastView` is demonstrated in this figure below.

``` swift
+-----------------------------+
|                             |
|  <Background>               |
|                             |
|        +-----------+        |
|        |           |        |
|        | <Content> |        |
|        |           |        |
|        |           |        |
|        |  <Label>  |        |
|        +-----------+        |
|                             |
|                             |
|                             |
+-----------------------------+

ToastView(<Label>) {
  <Content>
} background: {
  <Background>
}
```

`ToastView` with custom content views and custom background views.

``` swift
.toast(isPresented: $presentingToast) {
  ToastView("Saved!") {
    // custom content views
    Image(systemName: "arrow.down.doc.fill")
      .font(.system(size: 48))
      .foregroundColor(.green)
      .padding()
  } background: {
    // custom background views
    Color.green.opacity(0.1)
  }
}
```

`ToastView` using [built-in styles](#styling) and without background.

``` swift
.toast(isPresented: $presentingToast) {
  ToastView("Loading...") {
    // EmptyView()
  } background: {
    // EmptyView()
  }
  .toastViewStyle(IndefiniteProgressToastViewStyle())
}
```

#### Styling

`ToastUI` supports seven different `ToastViewStyle` s out-of-the-box. You have to use `ToastView` and set the style accordingly by using `toastViewStyle(_:)` modifier. All styles have native support for dynamic type for accessbility.

* `DefaultProgressToastViewStyle()` – shows an empty toast if user does not provide anything. `ToastView` uses this style by default.
* `IndefiniteProgressToastViewStyle()` – shows an indefinite circular progress indicator.
* `DefiniteProgressToastViewStyle(value:total:)` – shows a definite circular progress indicator from 0 to 100%.
* `SuccessToastViewStyle()` – shows a success toast.
* `ErrorToastViewStyle()` – shows an error toast.
* `WarningToastViewStyle()` - shows a warning toast.
* `InfoToastViewStyle()` – shows an information toast.

`ToastUI` includes a `UI/NSVisualEffectView` wrapper through `cocoaBlur()` view modifier, which is more flexible than existing [ `blur(radius:opaque:)` ](https://developer.apple.com/documentation/swiftui/view/blur(radius:opaque:)) in SwiftUI.

* `cocoaBlur(blurStyle:vibrancyStyle:blurIntensity:)` - for iOS.
* `cocoaBlur(blurStyle:blurIntensity:)` - for tvOS.
* `cocoaBlur(material:blendingMode:state:)` - for macOS.

## Contributing

All issue reports, feature requests, pull requests and GitHub stars are welcomed and much appreciated.

## Author

Quan Tran ([@quanshousio](https://quanshousio.com))

## Acknowledgements

* [Fruta](https://developer.apple.com/documentation/app_clips/fruta_building_a_feature-rich_app_with_swiftui) - `UI/NSVisualEffectView` wrapper for SwiftUI by Apple.
* [Label](https://fivestars.blog/swiftui/label.html) - an informative article about SwiftUI `Label` and style erasers by Five Stars.
* [SVProgressHUD](https://github.com/SVProgressHUD/SVProgressHUD) - original design of the circular progress HUD by Sam Vermette and Tobias Tiemerding.
* [SwiftUI Custom Styling](https://swiftui-lab.com/custom-styling) - an informative article about SwiftUI custom styling by The SwiftUI Lab.

## License

`ToastUI` is available under the MIT license. See the [LICENSE](LICENSE) file for more info.
