//
//  ToastViewStyle.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// The properties of a `ToastView` instance.
public struct ToastViewStyleConfiguration {
  /// A type-erased view describes the background of `ToastView`.
  public var background: AnyView?

  /// A type-erased view describes the label of `ToastView`.
  public var label: AnyView?

  /// A type-erased view describes the content of `ToastView`.
  public var content: AnyView?
}

/// A type that applies standard interaction behavior to all `ToastView`s
/// within a view hierarchy.
///
/// To configure the current `ToastView` style for a view hiearchy, use the
/// `View.toastViewStyle(_:)` modifier.
public protocol ToastViewStyle {
  /// A view that represents the body of a `ToastView`.
  associatedtype Body: View

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  func makeBody(configuration: Configuration) -> Body

  /// A type alias for the properties of a `ToastView` instance.
  typealias Configuration = ToastViewStyleConfiguration
}

extension ToastViewStyle {
  internal func eraseToAnyView(configuration: Configuration) -> AnyView {
    AnyView(makeBody(configuration: configuration))
  }
}

/// A concrete, type-erased `ToastViewStyle`.
public struct AnyToastViewStyle: ToastViewStyle {
  private let _makeBody: (Configuration) -> AnyView

  /// Creates a concrete, type-erased `ToastViewStyle`.
  public init<Style>(_ style: Style) where Style: ToastViewStyle {
    self._makeBody = style.eraseToAnyView
  }

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being created.
  public func makeBody(configuration: Configuration) -> AnyView {
    _makeBody(configuration)
  }
}
