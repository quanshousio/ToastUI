# Change Log

All notable changes to this project will be documented in this file. `ToastUI` adheres to [Semantic Versioning](https://semver.org/).

#### 3.x Releases

* `3.0.x` Releases - [3.0.0](#300)

#### 2.x Releases

* `2.0.x` Releases - [2.0.0](#200)

#### 1.x Releases

* `1.3.0` Releases - [1.3.0](#130) | [1.3.1](#131) | [1.3.2](#132)
* `1.2.x` Releases - [1.2.0](#120) | [1.2.1](#121)
* `1.1.x` Releases - [1.1.0](#110) | [1.1.1](#111)
* `1.0.x` Releases - [1.0.0](#100) | [1.0.1](#101) | [1.0.2](#102)

---

## [3.0.0](https://github.com/quanshousio/ToastUI/releases/tag/3.0.0)

Released on 2022-04-11.

#### Changed

* Minimum required version for Swift is 5.5.
* Visual changes:
  * ToastUI shows a dimmed background when presenting a toast instead of a blurred background. This replicates the behavior of a normal `UIAlertController`.
  * Multi-line text alignment for `Label` of `DefaultToastViewStyle` is center-aligned.
* API changes:
  * `IndefiniteProgressToastViewStyle` is renamed to `IndeterminateProgressToastViewStyle`.
  * `DefiniteProgressToastViewStyle` is renamed to `DeterminateProgressToastViewStyle`.
  * `ErrorToastViewStyle` is renamed to `FailureToastViewStyle`.
  * `InfoToastViewStyle` is renamed to `InformationToastViewStyle`.
  * `AnyToastViewStyle` is marked as private.
  * `ToastViewStyleConfiguration` properties are refactored to use a generic type instead of `AnyView`.
  * `VisualEffectView` and `cocoaBlur` modifier are removed. Use `blur` or `background` with [`Material`](https://developer.apple.com/documentation/swiftui/material) on iOS 15.0+ modifiers if possible.
* Toast presentation and dismissal mechanisms are redesigned:
  * On iOS and tvOS, toast is presented in a separate window instead of the view controller where it is called.
  * On macOS, toast is presented in the same window where it is called instead of a separate sheet.
  * On watchOS, toast is presented using the built-in `sheet` modifier due to the limitation of WatchKit APIs.
  * The new mechanism should be more robust against failures and warns the user appropriately if a failure occurs.
* [DocC](https://developer.apple.com/documentation/docc) replaces Jazzy as the new tool for generating documentation.
* Support for CocoaPods dependency manager is removed. Use Swift Package Manager instead.
* Default git branch is renamed to `main`.

#### Added

* Support for watchOS. Minimum required version for watchOS is 7.0
* Static property/function for all built-in styles to leverage the new static member lookup functionality.
* `toastDimmedBackground` modifier for enabling or disabling the dimmed background.
* `IconToastViewStyle` style for showing a toast with an icon and a headline text label.

#### Updated

* `ToastUISample` is reorganized and include new examples.
* GitHub actions are streamlined and updated ([#25](https://github.com/quanshousio/ToastUI/issues/25)).

#### Fixed

* ToastUI fails to present the toast when there is a presented view controller ([#21](https://github.com/quanshousio/ToastUI/issues/21) and [#24](https://github.com/quanshousio/ToastUI/issues/24)).
* Compiler warning for missing the metatype in `EnvironmentValues.toastViewStyle` ([#26](https://github.com/quanshousio/ToastUI/issues/26)).


---

## [2.0.0](https://github.com/quanshousio/ToastUI/releases/tag/2.0.0)

Released on 2021-01-20.

#### Changed

* Minimum required version for iOS and tvOS is 14.0.

#### Added

* Support for macOS. Minimum required version for macOS is 11.0.

#### Updated

* Use the new SwiftUI `App` life cycle.
* Use built-in `onChange` modifier and `@ScaledMetric` property wrapper.
* `OnChangeModifier` and `ScaledMetricProperty` have been removed.
* Reorganize the `ToastUISample` project.

---

## [1.3.2](https://github.com/quanshousio/ToastUI/releases/tag/1.3.2)

Released on 2021-01-13.

#### Updated

* Minor changes to GitHub actions.
* Make access control level to be more concise.

## [1.3.1](https://github.com/quanshousio/ToastUI/releases/tag/1.3.1)

Released on 2020-11-15.

#### Updated

* Minor changes to GitHub actions.
* Minor code reformatting.
* `CocoaBlurModifierExample` in `ToastUISample` has been removed.

## [1.3.0](https://github.com/quanshousio/ToastUI/releases/tag/1.3.0)

Released on 2020-11-14.

#### Changed

* `ToastView` initializer with `ToastViewStyleConfiguration` has been removed.
* Multi-line text alignment for `Label` of some built-in `ToastViewStyle`s are center-aligned.

#### Added

* `dismissAfter` handle for `ToastViewItemModifier`.

#### Updated

* New example of `ToastViewStyle` and minor refactoring on `ToastUISample`.
* GitHub actions for pushing to CocoaPods trunk and minor changes to GitHub actions.

---

## [1.2.1](https://github.com/quanshousio/ToastUI/releases/tag/1.2.1)

Released on 2020-10-09.

#### Updated

* Minor changes to GitHub actions.

#### Fixed

* `ToastUI` logo failed to load on CocoaPods.

## [1.2.0](https://github.com/quanshousio/ToastUI/releases/tag/1.2.0)

Released on 2020-10-09.

#### Changed

* `cocoaBlur` modifier adds `VisualEffectView` using `background` modifier instead of using `ZStack`.
* Default `UIBlurEffectStyle` for blurred background of `ToastView` is `.prominent` for both iOS and tvOS.

#### Added

* New logo for `ToastUI`.
* Support for custom background in `ToastView`.

#### Updated

* `ToastViewPreferenceKey` has been removed. Presenting toast is now handled by using `onChange` modifier.
* Utilize Swift 5.3 functionalities.
* Documentation and README.

#### Fixed

* Incorrect `keyWindow` is used in callbacks when there are multiple foreground active scenes.
* `ToastViewPreferenceKey` tried to update multiple times per frame is thrown in some cases.

---

## [1.1.1](https://github.com/quanshousio/ToastUI/releases/tag/1.1.1)

Released on 2020-10-05.

#### Updated

* Minor code formatting and SwiftLint rules.

#### Fixed

* Use Xcode 12 explicitly on GitHub virtual environment.

## [1.1.0](https://github.com/quanshousio/ToastUI/releases/tag/1.1.0)

Released on 2020-10-05.

#### Changed

* Minimum required version for Swift is 5.3.

#### Added

* SwiftLint to enforce Swift conventions.

#### Updated

* Minor code formatting, GitHub actions and filename changes.
* Remove redundant unit tests.

#### Fixed

* Memory leak due to improper asynchronous usage of `UIViewPropertyAnimator` in `VisualEffectView`.

---

## [1.0.2](https://github.com/quanshousio/ToastUI/releases/tag/1.0.2)

Released on 2020-08-16.

#### Changed

* Rename `VisualEffectBlur` to `VisualEffectView`.

#### Added

* GitHub actions for building package and documentation.

#### Updated

* Documentation and README.

#### Fixed

* Typos and formatting in ToastUISample.
* Exception occurred when property animator is not properly released ([#6](https://github.com/quanshousio/ToastUI/issues/6)).

## [1.0.1](https://github.com/quanshousio/ToastUI/releases/tag/1.0.1)

Released on 2020-08-13.

#### Added

* GitHub issue and pull request templates.

#### Fixed

* Content view is not properly laid out when boolean binding is triggered in `onAppear` ([#2](https://github.com/quanshousio/ToastUI/issues/2)).

## [1.0.0](https://github.com/quanshousio/ToastUI/releases/tag/1.0.0)

Released on 2020-08-04.

#### Added

* Initial release of `ToastUI`.
