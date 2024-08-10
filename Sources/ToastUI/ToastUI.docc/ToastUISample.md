# Sample code for ToastUI

Demonstrative examples from ToastUISample.

@Metadata {
  @PageKind(sampleCode)
  @CallToAction(url: "https://github.com/quanshousio/ToastUI/archive/refs/heads/main.zip", purpose: download)
  @Available(iOS, introduced: "14.0")
  @Available(macOS, introduced: "11.0")
  @Available(tvOS, introduced: "14.0")
  @Available(Xcode, introduced: "14.0")
}

## Overview

ToastUISample project provides you with numerous detailed examples of how to use ToastUI. watchOS target is not available, but usage still applies.

Examples are split into two parts. Basic examples will guide you on the essential functionalities of ToastUI:

* Presenting a toast using built-in ``ToastViewStyle`` with ``ToastView/toastViewStyle(_:)``.
* Presenting a toast using ``ToastView`` with a custom `Content`.
* Presenting a toast using ``ToastView`` with a custom `Background`.

Advanced examples demonstrate the powerful ability and flexibility that ToastUI provides:

* Presenting toasts consecutively by leveraging `onDismiss` handler.
* Presenting a toast using custom ``ToastViewStyle``.
* Presenting a custom alert using normal SwiftUI views.
* Presenting different toasts using ``ToastView/toast(item:dismissAfter:onDismiss:content:)`` modifier.
