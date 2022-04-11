# Sample code for ToastUI

Expressive examples from ToastUISample.

## Overview

ToastUISample project provides you with numerous detailed examples of how to use ToastUI. ToastUISample requires iOS 14.0, tvOS 14.0 and macOS 11.0. watchOS target is currently not available, but the usage still applies.

Examples are split into two parts. Basic examples will guide you on the essential functionalities of ToastUI:

* Presenting a toast using built-in ``ToastViewStyle`` with ``ToastView/toastViewStyle(_:)``.
* Presenting a toast using ``ToastView`` with a custom `Content`.
* Presenting a toast using `ToastView` with a custom `Background`.

Advanced examples demonstrate the powerful ability and flexibility that ToastUI provides:

* Presenting toasts consecutively by leveraging `onDismiss` handler.
* Presenting a toast using custom ``ToastViewStyle``.
* Presenting a custom alert using normal SwiftUI views.
* Presenting different toasts using ``ToastView/toast(item:dismissAfter:onDismiss:content:)`` modifier.
