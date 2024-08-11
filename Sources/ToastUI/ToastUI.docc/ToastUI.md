# ``ToastUI``

A simple way to show toast in SwiftUI.

@Metadata {
  @Available(iOS, introduced: "14.0")
  @Available(macOS, introduced: "11.0")
  @Available(tvOS, introduced: "14.0")
  @Available(watchOS, introduced: "7.0")
}

## Overview

ToastUI provides you a simple way to present toast, head-up display (HUD), custom alert, or any SwiftUI views on top of everything in SwiftUI.

## Essentials

@Links(visualStyle: detailedGrid) {
  - <doc:GettingStarted>
  - <doc:About>
  - <doc:ToastUISample>
  - <doc:ToastView>
}

## Topics

### Articles

- <doc:GettingStarted>
- <doc:About>
- <doc:ToastUISample>

### Presenting

- ``ToastView/toast(isPresented:dismissAfter:onDismiss:content:)``
- ``ToastView/toast(item:dismissAfter:onDismiss:content:)``

### Modifiers

- ``ToastView/toastViewStyle(_:)``
- ``ToastView/toastDimmedBackground(_:)``

### Styles

- ``ToastViewStyle``
- ``DefaultToastViewStyle``
- ``IndeterminateProgressToastViewStyle``
- ``DeterminateProgressToastViewStyle``
- ``IconToastViewStyle``
- ``SuccessToastViewStyle``
- ``FailureToastViewStyle``
- ``WarningToastViewStyle``
- ``InformationToastViewStyle``

### Views

- ``ToastView``
