//
//  ToastViewStyle.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// A type that applies standard interaction behavior to all ``ToastView``
/// views within a view hierarchy.
///
/// To configure the current ``ToastViewStyle`` for a view hiearchy, use the
/// ``ToastView/toastViewStyle(_:)`` modifier.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public protocol ToastViewStyle {
  /// A view that represents the body of a ``ToastView``.
  associatedtype Body: View

  /// A type alias for the properties of a ``ToastView`` instance.
  typealias Configuration = ToastViewStyleConfiguration

  /// Creates a view representing the body of a ``ToastView``.
  ///
  /// - Parameter configuration: The properties of the ``ToastView`` being created.
  func makeBody(configuration: Configuration) -> Body
}

/// The properties of a ``ToastView``.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ToastViewStyleConfiguration {
  /// A type-erased background of a ``ToastView``.
  public struct Background: View {
    init<Content>(content: Content) where Content: View {
      body = AnyView(content)
    }

    /// The body of this view.
    public var body: AnyView
  }

  /// A type-erased label of a ``ToastView``.
  public struct Label: View {
    init<Content>(content: Content) where Content: View {
      body = AnyView(content)
    }

    /// The body of this view.
    public var body: AnyView
  }

  /// A type-erased content of a ``ToastView``.
  public struct Content: View {
    init<Content>(content: Content) where Content: View {
      body = AnyView(content)
    }

    /// The body of this view.
    public var body: AnyView
  }

  /// A view describes the background of a ``ToastView``.
  public var background: Background?

  /// A view describes the label of a ``ToastView``.
  public var label: Label?

  /// A view describes the content of a ``ToastView``.
  public var content: Content?
}
