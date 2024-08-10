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
@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
public struct ToastView<Background, Label, Content>: View
  where Background: View, Label: View, Content: View {
  @Environment(\.toastViewStyle) private var style

  private var configuration: ToastViewStyleConfiguration

  /// The content and behavior of the view.
  public var body: some View {
    style.makeBody(configuration: configuration)
  }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
extension ToastView {
  /// Creates an empty ``ToastView``.
  public init()
    where Background == EmptyView, Label == EmptyView, Content == EmptyView {
    self.configuration = ToastViewStyleConfiguration()
  }

  /// Creates an empty ``ToastView`` with text label from a string.
  ///
  /// - Parameter title: A string that describes the text label.
  @_disfavoredOverload
  public init(_ title: some StringProtocol)
    where Background == EmptyView, Label == Text, Content == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(title))
    )
  }

  /// Creates an empty ``ToastView`` with text label from a localized string.
  ///
  /// - Parameter titleKey: The key used to look up the localized title for the label.
  public init(_ titleKey: LocalizedStringKey)
    where Background == EmptyView, Label == Text, Content == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(titleKey))
    )
  }

  /// Creates a ``ToastView`` with custom `content` view and text label from a string.
  ///
  /// - Parameters:
  ///   - title: A string that describes the text label.
  ///   - content: A view builder that creates a view for the content.
  @_disfavoredOverload
  public init(_ title: some StringProtocol, @ViewBuilder content: () -> Content)
    where Background == EmptyView, Label == Text {
    self.configuration = ToastViewStyleConfiguration(
      label: .init(content: Text(title)),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` view and text label from a localized string.
  ///
  /// - Parameters:
  ///   - titleKey: The key used to look up the localized title for the label.
  ///   - content: A view builder that creates a view for the content.
  public init(_ titleKey: LocalizedStringKey, @ViewBuilder content: () -> Content)
    where Background == EmptyView, Label == Text {
    self.configuration = ToastViewStyleConfiguration(
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
  public init(
    _ title: some StringProtocol,
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == Text {
    self.configuration = ToastViewStyleConfiguration(
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
  public init(
    _ titleKey: LocalizedStringKey,
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == Text {
    self.configuration = ToastViewStyleConfiguration(
      background: .init(content: background()),
      label: .init(content: Text(titleKey)),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` view.
  ///
  /// - Parameter content: A view builder that creates a view for the content.
  public init(@ViewBuilder content: () -> Content)
    where Background == EmptyView, Label == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` and `background` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content.
  ///   - background: A view builder that creates a view for the background.
  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: .init(content: background()),
      content: .init(content: content())
    )
  }

  /// Creates a ``ToastView`` with custom `content` and `label` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content.
  ///   - label: A view builder that creates a view for the label.
  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label
  ) where Background == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
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
  public init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label,
    @ViewBuilder background: () -> Background
  ) {
    self.configuration = ToastViewStyleConfiguration(
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

  @ScaledMetric private var paddingSize = 16.0
  @ScaledMetric private var cornerSize = 9.0

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
    #if os(iOS) || os(visionOS)
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
    #if os(iOS) || os(tvOS) || os(visionOS)
    return Color(.label)
    #elseif os(watchOS)
    return Color(.darkGray)
    #elseif os(macOS)
    return Color(.labelColor)
    #endif
  }()
}
