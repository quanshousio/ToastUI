//
//  DefaultToastViewStyle.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// A concrete, type-erased ``ToastViewStyle``.
struct AnyToastViewStyle: ToastViewStyle {
  private let _makeBody: (Configuration) -> AnyView

  /// Creates a ``AnyToastViewStyle``.
  init<Style>(_ style: Style) where Style: ToastViewStyle {
    _makeBody = { configuration in
      AnyView(style.makeBody(configuration: configuration))
    }
  }

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  func makeBody(configuration: Configuration) -> some View {
    _makeBody(configuration)
  }
}

/// The default style of ``ToastView``.
///
/// Use this style to customize ``ToastView``.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct DefaultToastViewStyle: ToastViewStyle {
  /// Creates a ``DefaultToastViewStyle``.
  public init() {}

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    DefaultToastView {
      configuration.content
    } label: {
      configuration.label
    } background: {
      configuration.background
    }
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle where Self == DefaultToastViewStyle {
  /// The default style of ``ToastView``.
  ///
  /// Use this style to customize ``ToastView``.
  static var `default`: Self {
    .init()
  }
}

/// A ``ToastView`` represents as an indeterminate circular progress indicator,
/// also informally known as a spinner.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct IndeterminateProgressToastViewStyle: ToastViewStyle {
  /// Creates an ``IndeterminateProgressToastViewStyle``.
  public init() {}

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IndeterminateProgressToastView(configuration: configuration)
  }

  struct IndeterminateProgressToastView: View {
    let configuration: Configuration

    @ScaledMetric private var iconSize: Double = 36
    @ScaledMetric private var strokeSize: Double = 3

    @State private var animating: Bool = false

    var body: some View {
      DefaultToastView {
        Circle()
          .trim(from: 0.02, to: 0.98)
          .stroke(
            AngularGradient(
              gradient: Gradient(colors: [.background, .label]),
              center: .center,
              startAngle: .degrees(0),
              endAngle: .degrees(360)
            ),
            style: StrokeStyle(lineWidth: strokeSize, lineCap: .round, lineJoin: .round)
          )
          .frame(width: iconSize, height: iconSize)
          .rotationEffect(.degrees(-90))
          .rotationEffect(.degrees(animating ? 360 : 0))
          .animation(.linear(duration: 1.0).repeatForever(autoreverses: false), value: animating)
          .onAppear {
            // fix #2
            DispatchQueue.main.async {
              animating = true
            }
          }
      } label: {
        configuration.label
          .font(.headline)
          .foregroundColor(.secondary)
      } background: {
        configuration.background
      }
    }
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle where Self == IndeterminateProgressToastViewStyle {
  /// A ``ToastView`` represents as an indeterminate circular progress indicator,
  /// also informally known as a spinner.
  static var indeterminate: Self {
    .init()
  }
}

/// A ``ToastView`` represents as a determinate circular progress indicator.
/// This style is visually similar to the ``IndeterminateProgressToastViewStyle``,
/// but shows determinate progress instead.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct DeterminateProgressToastViewStyle<Value>: ToastViewStyle
where Value: BinaryFloatingPoint {
  @Binding private var value: Value
  @Binding private var total: Value

  /// Creates a ``DeterminateProgressToastViewStyle``.
  ///
  /// - Parameters:
  ///   - value: The completed amount of the task, ranging from `0.0` to `total`.
  ///   - total: The fully completed amount of the task, meaning the task is completed if
  ///            `value` equals `total`. Default value is `1.0`.
  public init(value: Binding<Value>, total: Binding<Value> = .constant(1.0)) {
    _value = value
    _total = total
  }

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    DeterminateProgressToastView(configuration: configuration, value: $value, total: $total)
  }

  struct DeterminateProgressToastView: View {
    let configuration: Configuration
    @Binding var value: Value
    @Binding var total: Value

    @ScaledMetric private var iconSize: Double = 36
    @ScaledMetric private var strokeSize: Double = 3

    @State private var isAnimating: Bool = false

    var body: some View {
      DefaultToastView {
        Circle()
          .trim(from: 0, to: Double(value / total))
          .stroke(
            AngularGradient(
              gradient: Gradient(colors: [.secondary]),
              center: .center,
              startAngle: .degrees(0),
              endAngle: .degrees(360)
            ),
            style: StrokeStyle(lineWidth: strokeSize, lineCap: .round, lineJoin: .round)
          )
          .frame(width: iconSize, height: iconSize)
          .rotationEffect(.degrees(-90))
          .animation(.linear, value: value)
      } label: {
        configuration.label
          .font(.headline)
          .foregroundColor(.secondary)
      } background: {
        configuration.background
      }
    }
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle {
  /// A ``ToastView`` represents as a determinate circular progress indicator.
  /// This style is similar to the ``IndeterminateProgressToastViewStyle``,
  /// but shows determinate progress instead.
  ///
  /// - Parameters:
  ///   - value: The completed amount of the task, ranging from `0.0` to `total`.
  ///   - total: The fully completed amount of the task, meaning the task is completed if
  ///            `value` equals `total`. Default value is `1.0`.
  static func determinate<Value>(
    value: Binding<Value>,
    total: Binding<Value> = .constant(1.0)
  ) -> Self where Value: BinaryFloatingPoint, Self == DeterminateProgressToastViewStyle<Value> {
    .init(value: value, total: total)
  }
}

/// A ``ToastView`` represents as a toast consists of an icon and a headline text label.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct IconToastViewStyle<Content>: ToastViewStyle where Content: View {
  private var content: Content

  /// Creates an ``IconToastViewStyle``.
  ///
  /// - Parameters:
  ///   - content: The content of the icon.
  public init(content: () -> Content) {
    self.content = content()
  }

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IconToastView(configuration: configuration, content: content)
  }

  struct IconToastView: View {
    let configuration: Configuration
    let content: Content

    @ScaledMetric private var iconSize: Double = 36

    var body: some View {
      DefaultToastView {
        content
          .font(.largeTitle)
      } label: {
        configuration.label
          .font(.headline)
          .foregroundColor(.secondary)
      } background: {
        configuration.background
      }
    }
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle {
  /// A ``ToastView`` represents as a toast consists of an icon and a headline text label.
  ///
  /// - Parameters:
  ///   - content: The content of the icon.
  static func icon<Content>(content: () -> Content) -> Self
  where Self == IconToastViewStyle<Content> {
    .init(content: content)
  }
}

/// A ``ToastView`` represents as a success toast.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct SuccessToastViewStyle: ToastViewStyle {
  /// Creates a ``SuccessToastViewStyle``.
  public init() {}

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IconToastViewStyle {
      Image(systemName: "checkmark.circle.fill")
        .foregroundColor(.green)
    }
    .makeBody(configuration: configuration)
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle where Self == SuccessToastViewStyle {
  /// A ``ToastView`` represents as a success toast.
  static var success: Self {
    .init()
  }
}

/// A ``ToastView`` represents as a failure toast.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct FailureToastViewStyle: ToastViewStyle {
  /// Creates a ``FailureToastViewStyle``.
  public init() {}

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IconToastViewStyle {
      Image(systemName: "xmark.circle.fill")
        .foregroundColor(.red)
    }
    .makeBody(configuration: configuration)
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle where Self == FailureToastViewStyle {
  /// A ``ToastView`` represents as a failure toast.
  static var failure: Self {
    .init()
  }
}

/// A ``ToastView`` represents as a warning toast.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct WarningToastViewStyle: ToastViewStyle {
  /// Creates a ``WarningToastViewStyle``.
  public init() {}

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IconToastViewStyle {
      Image(systemName: "exclamationmark.triangle.fill")
        .foregroundColor(.yellow)
    }
    .makeBody(configuration: configuration)
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle where Self == WarningToastViewStyle {
  /// A ``ToastView`` represents as a warning toast.
  static var warning: Self {
    .init()
  }
}

/// A ``ToastView`` represents as an information toast.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct InformationToastViewStyle: ToastViewStyle {
  /// Creates an ``InformationToastViewStyle``.
  public init() {}

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IconToastViewStyle {
      Image(systemName: "info.circle.fill")
        .foregroundColor(.blue)
    }
    .makeBody(configuration: configuration)
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastViewStyle where Self == InformationToastViewStyle {
  /// A ``ToastView`` represents as an information toast.
  static var information: Self {
    .init()
  }
}
