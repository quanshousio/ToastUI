//
//  ToastView.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// A view that represents a toast, which is visually represented by a shadowed, rounded
/// rectangle shape with an opaque background.
public struct ToastView<Content>: View where Content: View {
  // MARK: Properties

  @Environment(\.toastViewStyle) private var style: AnyToastViewStyle

  private var content: Content?
  private var label: Text?

  /// The content and behavior of the view.
  public var body: some View {
    style.makeBody(configuration: ToastViewStyleConfiguration(content: AnyView(content), label: label))
  }
}

// MARK: Initializers

extension ToastView where Content == EmptyView {
  /// Creates an empty `ToastView`.
  public init() {}
}

extension ToastView {
  /// Creates a `ToastView` with provided `content`.
  ///
  /// - Parameter content: A view builder that creates a view for the content of `ToastView`.
  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }
}

extension ToastView {
  /// Creates an empty `ToastView` with title from a localized string.
  ///
  /// - Parameter titleKey: The key for the `ToastView`'s localized title.
  public init(_ titleKey: LocalizedStringKey) {
    self.label = Text(titleKey)
  }

  /// Creates a `ToastView` with custom `content` and title from a localized string.
  ///
  /// - Parameters:
  ///   - titleKey: The key for the `ToastView`'s localized title.
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  public init(_ titleKey: LocalizedStringKey, @ViewBuilder content: () -> Content) {
    self.label = Text(titleKey)
    self.content = content()
  }
}

extension ToastView {
  /// Creates an empty `ToastView` with title from a string.
  ///
  /// - Parameter title: A string that describes the `ToastView`.
  public init<S>(_ title: S) where Content == EmptyView, S: StringProtocol {
    self.label = !title.isEmpty ? Text(title) : nil
  }

  /// Creates a `ToastView` with provided `content` and title from a string.
  ///
  /// - Parameters:
  ///   - title: A string that describes the `ToastView`.
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  public init<S>(_ title: S, @ViewBuilder content: () -> Content) where S: StringProtocol {
    self.label = !title.isEmpty ? Text(title) : nil
    self.content = content()
  }
}
