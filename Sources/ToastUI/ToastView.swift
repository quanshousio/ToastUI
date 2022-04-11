//
//  ToastView.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// A view that represents a toast.
///
/// ``ToastView`` is visually represented as a rounded rectangle shape that contains your provided views.
/// The layout of ``ToastView`` consists of three different views: `Background`, `Label` and `Content`.
/// By default, it has an empty background with a fixed-size, center-aligned label and no content.
///
/// This view supports styling by using ``ToastView/toastViewStyle(_:)``.
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public struct ToastView<Background, Label, Content>: View
where Background: View, Label: View, Content: View {
  @Environment(\.toastViewStyle) private var style

  private var configuration: ToastViewStyleConfiguration

  /// The content and behavior of the view.
  public var body: some View {
    style.makeBody(configuration: configuration)
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, *)
public extension ToastView {
  /// Creates an empty ``ToastView``.
  init()
  where Background == EmptyView, Label == EmptyView, Content == EmptyView {
    configuration = ToastViewStyleConfiguration()
  }

  /// Creates an empty ``ToastView`` with text label from a string.
  ///
  /// - Parameter title: A string that describes the text label.
  @_disfavoredOverload
  init<S>(_ title: S)
  where S: StringProtocol, Background == EmptyView, Label == Text, Content == EmptyView {
    configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(title))
    )
  }

  /// Creates an empty ``ToastView`` with text label from a localized string.
  ///
  /// - Parameter titleKey: The key used to look up the localized title for the label.
  init(_ titleKey: LocalizedStringKey)
  where Background == EmptyView, Label == Text, Content == EmptyView {
    configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(titleKey))
    )
  }

  /// Creates a ``ToastView`` with custom `content` view and text label from a string.
  ///
  /// - Parameters:
  ///   - title: A string that describes the text label.
  ///   - content: A view builder that creates a view for the content.
  @_disfavoredOverload
  init<S>(_ title: S, @ViewBuilder content: () -> Content)
  where S: StringProtocol, Background == EmptyView, Label == Text {
    configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(title)),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` view and text label from a localized string.
  ///
  /// - Parameters:
  ///   - titleKey: The key used to look up the localized title for the label.
  ///   - content: A view builder that creates a view for the content.
  init(_ titleKey: LocalizedStringKey, @ViewBuilder content: () -> Content)
  where Background == EmptyView, Label == Text {
    configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(titleKey)),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` and `background` views,
  /// and text label from a string.
  ///
  /// - Parameters:
  ///   - title: A string that describes the text label.
  ///   - content: A view builder that creates a view for the content.
  ///   - background: A view builder that creates a view for the background.
  @_disfavoredOverload
  init<S>(
    _ title: S,
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where S: StringProtocol, Label == Text {
    configuration = ToastViewStyleConfiguration(
      background: .init(content: background()),
      label: .init(content: Text(title)),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` and `background` views,
  /// and text label from a localized string.
  ///
  /// - Parameters:
  ///   - titleKey: The key used to look up the localized title for the label.
  ///   - content: A view builder that creates a view for the content.
  ///   - background: A view builder that creates a view for the background.
  init(
    _ titleKey: LocalizedStringKey,
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == Text {
    configuration = ToastViewStyleConfiguration(
      background: .init(content: background()),
      label: .init(content: Text(titleKey)),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` view.
  ///
  /// - Parameter content: A view builder that creates a view for the content.
  init(@ViewBuilder content: () -> Content)
  where Background == EmptyView, Label == EmptyView {
    configuration = ToastViewStyleConfiguration(
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` and `background` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content.
  ///   - background: A view builder that creates a view for the background.
  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == EmptyView {
    configuration = ToastViewStyleConfiguration(
      background: .init(content: background()),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` and `label` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content.
  ///   - label: A view builder that creates a view for the label.
  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label
  ) where Background == EmptyView {
    configuration = ToastViewStyleConfiguration(
      label: .init(content: label()),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content`, `label` and `background` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content.
  ///   - label: A view builder that creates a view for the label.
  ///   - background: A view builder that creates a view for the background.
  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label,
    @ViewBuilder background: () -> Background
  ) {
    configuration = ToastViewStyleConfiguration(
      background: .init(content: background()),
      label: .init(content: label()),
      content: .init(content: content())
    )
  }
}

struct DefaultToastView<Background, Label, Content>: View
where Background: View, Label: View, Content: View {
  private var background: Background
  private var label: Label
  private var content: Content

  @ScaledMetric private var paddingSize: Double = 16
  @ScaledMetric private var cornerSize: Double = 9

  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label,
    @ViewBuilder background: () -> Background
  ) {
    self.background = background()
    self.label = label()
    self.content = content()
  }

  var body: some View {
    VStack(spacing: 8) {
      content

      label
        .fixedSize()
        .multilineTextAlignment(.center)
    }
    .padding(paddingSize)
    .background(Color.background)
    .cornerRadius(cornerSize)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(background)
  }
}

extension Color {
  static let background = {
    #if os(iOS)
    return Color(.secondarySystemBackground)
    #elseif os(tvOS)
    return Color(.darkGray)
    #elseif os(watchOS)
    return Color(.black)
    #elseif os(macOS)
    return Color(.windowBackgroundColor)
    #endif
  }()

  static let label = {
    #if os(iOS) || os(tvOS)
    return Color(.label)
    #elseif os(watchOS)
    return Color(.darkGray)
    #elseif os(macOS)
    return Color(.labelColor)
    #endif
  }()
}
