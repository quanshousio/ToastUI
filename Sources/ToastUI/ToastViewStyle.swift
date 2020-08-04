//
//  ToastViewStyle.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// The properties of a `ToastView` instance.
public struct ToastViewStyleConfiguration {
  /// Content of the `ToastView`.
  let content: AnyView?
  
  /// A label describes the `ToastView`.
  let label: Text?
}

/// A type that applies standard interaction behavior to all `ToastView`s
/// within a view hierarchy.
///
/// To configure the current `ToastView` style for a view hiearchy, use the
/// ``View/toastViewStyle(_:)`` modifier.
public protocol ToastViewStyle {
  associatedtype Body: View

  /// Creates a view representing the body of a `ToastView`.
  ///
  /// - Parameter configuration: The properties of the `ToastView` being
  ///   created.
  func makeBody(configuration: Configuration) -> Body

  /// A type alias for the properties of a `ToastView` instance.
  typealias Configuration = ToastViewStyleConfiguration
}

internal extension ToastViewStyle {
  func eraseToAnyView(configuration: Configuration) -> AnyView {
    AnyView(makeBody(configuration: configuration))
  }
}

/// A type-erased `ToastViewStyle`.
public struct AnyToastViewStyle: ToastViewStyle {
  private let _makeBody: (Configuration) -> AnyView

  init<Style: ToastViewStyle>(_ style: Style) {
    self._makeBody = style.eraseToAnyView
  }

  public func makeBody(configuration: Configuration) -> AnyView {
    _makeBody(configuration)
  }
}
