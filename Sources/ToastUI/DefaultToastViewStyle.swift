//
//  DefaultToastViewStyle.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

#if os(iOS)
private let backgroundColor = Color(.secondarySystemBackground)
#endif

#if os(tvOS)
private let backgroundColor = Color(.darkGray)
#endif

/// The default `ToastViewStyle`.
///
/// You have to use this style in order to make customized `ToastView`.
public struct DefaultToastViewStyle: ToastViewStyle {
  /// Creates a default `ToastViewStyle`.
  public init() {}

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    DefaultToastView(
      background: configuration.background,
      label: configuration.label,
      content: configuration.content
    )
  }

  internal struct DefaultToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 16
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    let background: AnyView?
    let label: AnyView?
    let content: AnyView?

    var body: some View {
      VStack {
        content
        label
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}

/// A `ToastView` that visually represents as an indefinite circular progress
/// indicator, also informally known as a spinner.
public struct IndefiniteProgressToastViewStyle: ToastViewStyle {
  /// Creates a indefinite progress `ToastViewStyle`.
  public init() {}

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    IndefiniteProgressToastView(background: configuration.background, label: configuration.label)
  }

  internal struct IndefiniteProgressToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var iconSize: CGFloat = 36
    @ScaledMetricProperty(relativeTo: .headline) private var strokeSize: CGFloat = 3
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 20
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    @State private var isAnimating: Bool = false

    let background: AnyView?
    let label: AnyView?

    var body: some View {
      VStack {
        Circle()
          .trim(from: 0.02, to: 0.98)
          .stroke(
            AngularGradient(
              gradient: Gradient(colors: [backgroundColor, Color(.label)]),
              center: .center,
              startAngle: .degrees(0),
              endAngle: .degrees(360)
            ),
            style: StrokeStyle(lineWidth: strokeSize, lineCap: .round, lineJoin: .round)
          )
          .frame(width: iconSize, height: iconSize)
          .rotationEffect(.degrees(-90))
          .rotationEffect(isAnimating ? .degrees(360) : .degrees(0))
          .animation(
            isAnimating
              ? Animation.linear(duration: 1.0).repeatForever(autoreverses: false)
              : nil
          )
          .onAppear { isAnimating = true }
          .onDisappear { isAnimating = false }

        label
          .font(.headline)
          .foregroundColor(.secondary)
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}

/// A `ToastView` that visually represents as a definite circular progress
/// indicator. This style is similar to the `IndefiniteProgressToastViewStyle`,
/// but show determinate progress instead.
public struct DefiniteProgressToastViewStyle<Value>: ToastViewStyle
where Value: BinaryFloatingPoint
{
  @Binding private var value: Value
  @Binding private var total: Value

  /// Creates a definite progress `ToastViewStyle`.
  ///
  /// - Parameters:
  ///   - value: The currently completed amount of the task, ranging from `0.0` to `total`.
  ///   - total: The fully completed amount of the task, meaning the task is completed if
  ///            `value` equals `total`. Default value is `1.0`.
  public init(value: Binding<Value>, total: Binding<Value> = .constant(1.0)) {
    _value = value
    _total = total
  }

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    DefiniteProgressToastView(
      background: configuration.background,
      label: configuration.label,
      value: $value,
      total: $total
    )
  }

  internal struct DefiniteProgressToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var iconSize: CGFloat = 36
    @ScaledMetricProperty(relativeTo: .headline) private var strokeSize: CGFloat = 3
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 20
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    @State private var isAnimating: Bool = false

    let background: AnyView?
    let label: AnyView?

    @Binding var value: Value
    @Binding var total: Value

    var body: some View {
      VStack {
        Circle()
          .trim(from: 0, to: CGFloat(value / total))
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
          .animation(.linear)

        label
          .font(.headline)
          .foregroundColor(.secondary)
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}

/// A `ToastView` that visually represents as a success toast.
public struct SuccessToastViewStyle: ToastViewStyle {
  /// Creates a success `ToastViewStyle`.
  public init() {}

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    SuccessToastView(background: configuration.background, label: configuration.label)
  }

  internal struct SuccessToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var iconSize: CGFloat = 32
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 20
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    let background: AnyView?
    let label: AnyView?

    var body: some View {
      VStack {
        Image(systemName: "checkmark.circle.fill")
          .resizable()
          .frame(width: iconSize, height: iconSize)
          .foregroundColor(.green)

        label
          .font(.headline)
          .foregroundColor(.secondary)
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}

/// A `ToastView` that visually represents as an error toast.
public struct ErrorToastViewStyle: ToastViewStyle {
  /// Creates an error `ToastViewStyle`.
  public init() {}

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    FailureToastView(background: configuration.background, label: configuration.label)
  }

  internal struct FailureToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var iconSize: CGFloat = 32
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 20
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    let background: AnyView?
    let label: AnyView?

    var body: some View {
      VStack {
        Image(systemName: "xmark.circle.fill")
          .resizable()
          .frame(width: iconSize, height: iconSize)
          .foregroundColor(.red)

        label
          .font(.headline)
          .foregroundColor(.secondary)
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}

/// A `ToastView` that visually represents as a warning toast.
public struct WarningToastViewStyle: ToastViewStyle {
  /// Creates a warning `ToastViewStyle`.
  public init() {}

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    WarningToastView(background: configuration.background, label: configuration.label)
  }

  internal struct WarningToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var iconSize: CGFloat = 32
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 20
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    let background: AnyView?
    let label: AnyView?

    var body: some View {
      VStack {
        Image(systemName: "exclamationmark.triangle.fill")
          .resizable()
          .frame(width: iconSize, height: iconSize)
          .foregroundColor(.yellow)

        label
          .font(.headline)
          .foregroundColor(.secondary)
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}

/// A `ToastView` that visually represents as an information toast.
public struct InfoToastViewStyle: ToastViewStyle {
  /// Creates an information`ToastViewStyle`.
  public init() {}

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> some View {
    InfoToastView(background: configuration.background, label: configuration.label)
  }

  internal struct InfoToastView: View {
    @ScaledMetricProperty(relativeTo: .headline) private var iconSize: CGFloat = 32
    @ScaledMetricProperty(relativeTo: .headline) private var paddingSize: CGFloat = 20
    @ScaledMetricProperty(relativeTo: .headline) private var cornerSize: CGFloat = 9

    let background: AnyView?
    let label: AnyView?

    var body: some View {
      VStack {
        Image(systemName: "info.circle.fill")
          .resizable()
          .frame(width: iconSize, height: iconSize)
          .foregroundColor(.blue)

        label
          .font(.headline)
          .foregroundColor(.secondary)
      }
      .padding(paddingSize)
      .background(backgroundColor)
      .cornerRadius(cornerSize)
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(background.edgesIgnoringSafeArea(.all))
    }
  }
}
