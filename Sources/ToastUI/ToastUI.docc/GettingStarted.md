# Getting Started with ToastUI

Present a toast in SwiftUI in no time.

### Requirements

ToastUI supports iOS 14.0, tvOS 14.0, watchOS 7.0 and macOS 11.0 and later. ToastUI requires Xcode 14.0 and Swift 5.7 and later.

### Installation

ToastUI is available through [Swift Package Manager](https://swift.org/package-manager/).

@Image(source: "xcode-add-package.png", alt: "Xcode Add Package")

For app integration, add ToastUI to an existing Xcode project as a package dependency:

1. Navigate to your project settings. Find a new tab called "Package Dependencies". Click the "+" button to open the add package dialog.
2. Enter [https://github.com/quanshousio/ToastUI](https://github.com/quanshousio/ToastUI) into the "Search or Enter Package URL" text field. Xcode should set updating the package up to the next version option by default. Click the "Add Package" button to add the package.

For package integration, add the following line to the `dependencies` array in your `Package.swift`.

```swift
dependencies: [
  .package(url: "https://github.com/quanshousio/ToastUI.git", from: "3.0.0")
]
```

### Presenting a toast

@TabNavigator {
  @Tab("Progress Indicator") {
    Present an indeterminate progress indicator toast and dismiss it after 2 seconds:

    @Row {
      @Column(size: 2) {
        ```swift
        struct ContentView: View {
          @State private var presentingToast: Bool = false

          var body: some View {
            Button("Tap me") {
              presentingToast = true
            }
            .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
              ToastView("Loading...")
                .toastViewStyle(.indeterminate)
            }
          }
        }
        ```
      }
      
      @Column {
        @Image(source: "indeterminate-style.png", alt: "Indeterminate Toast View")
      }
    }
  }

  @Tab("Alert") {
    You can also present custom alerts:

    @Row {
      @Column(size: 2) {
        ```swift
        struct ContentView: View {
          @State private var presentingToast: Bool = false

          var body: some View {
            Button("Tap me") {
              presentingToast = true
            }
            .toast(isPresented: $presentingToast) {
              ToastView {
                VStack {
                  Text("You can create a custom alert with ToastView")
                    .multilineTextAlignment(.center)

                  Divider()

                  Button("OK") {
                    presentingToast = false
                  }
                }
              }
              .padding()
            }
          }
        }
        ```
      }

      @Column {
        @Image(source: "custom-toast-1.png", alt: "Custom Toast View 1")
      }
    }
  }

  @Tab("Banner") {
    You can also present any custom SwiftUI views of your choice:

    @Row {
      @Column(size: 2) {
        ```swift
        struct ContentView: View {
          @State private var presentingToast: Bool = false

          var body: some View {
            Button("Tap me") {
              presentingToast = true
            }
            .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
              print("Toast dismissed")
            } content: {
              VStack {
                Text("You can present any SwiftUI views")
                  .bold()
                  .foregroundColor(.white)
                  .padding()
                  .frame(maxWidth: .infinity)
                  .background(Color.accentColor)
                  .cornerRadius(8.0)
                  .shadow(radius: 4.0)
                Spacer()
              }
              .padding()
            }
            .toastDimmedBackground(false)
          }
        }
        ```
      }
        
      @Column {
        @Image(source: "custom-toast-2.png", alt: "Custom Toast View 2")
      }
    }
  }
}

### Documentation

ToastUI consists a helper script `toastui` in the root directory for building the documentation. For more information, check out `toastui help`.

[`jq`](https://github.com/stedolan/jq) is required for building and patching the package symbols. [`npm`](https://docs.npmjs.com/downloading-and-installing-node-js-and-npm/) is required for building and previewing the documentation archive.

To build and preview the documentation:

```shell
./toastui docc setup
./toastui docc preview
```
