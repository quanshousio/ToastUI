//
//  ToastView.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// A view that represents a toast, which is visually represented by a shadowed, rounded
/// rectangle shape with a thin blurred background fit to screen by default.
///
/// This view supports styling by using `toastViewStyle(_:)`. Layout of this view is demonstrated
/// in the figure below.
///
/// ```
/// +-----------------------------+
/// |                             |
/// |  <Background>               |
/// |                             |
/// |        +-----------+        |
/// |        |           |        |
/// |        | <Content> |        |
/// |        |           |        |
/// |        |           |        |
/// |        |  <Label>  |        |
/// |        +-----------+        |
/// |                             |
/// |                             |
/// |                             |
/// +-----------------------------+
/// ```
public struct ToastView<Background, Label, Content>: View
where Background: View, Label: View, Content: View {
  // MARK: Properties

  @Environment(\.toastViewStyle) private var style

  private var configuration: ToastViewStyleConfiguration

  #if os(iOS) || os(tvOS)
  private let backgroundView = VisualEffectView(
    blurStyle: .prominent,
    blurIntensity: 0.13
  )
  #endif

  #if os(macOS)
  private let backgroundView = VisualEffectView(
    material: .fullScreenUI,
    blendingMode: .behindWindow,
    state: .followsWindowActiveState
  )
  #endif

  /// The content and behavior of the view.
  public var body: some View {
    style.makeBody(configuration: configuration)
  }
}

// MARK: Initializers

public extension ToastView {
  /// Creates an empty `ToastView`.
  init()
  where Background == EmptyView, Label == EmptyView, Content == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView)
    )
  }

  /// Creates an empty `ToastView` with text label from a localized string.
  ///
  /// - Parameter titleKey: The key for the `ToastView`'s localized title.
  init(_ titleKey: LocalizedStringKey)
  where Background == EmptyView, Label == Text, Content == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView),
      label: AnyView(Text(titleKey))
    )
  }

  /// Creates an empty `ToastView` with text label from a string.
  ///
  /// - Parameter title: A string that describes the `ToastView`.
  @_disfavoredOverload
  init<S>(_ title: S)
  where S: StringProtocol, Background == EmptyView, Label == Text, Content == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView),
      label: AnyView(Text(title))
    )
  }
}

public extension ToastView {
  /// Creates a `ToastView` with custom `content` view and text label from a localized string.
  ///
  /// - Parameters:
  ///   - titleKey: The key used to look up the localized title for the label.
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  init(_ titleKey: LocalizedStringKey, @ViewBuilder content: () -> Content)
  where Background == EmptyView, Label == Text {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView),
      label: AnyView(Text(titleKey)),
      content: AnyView(content())
    )
  }

  /// Creates a `ToastView` with custom `content` view and text label from a string.
  ///
  /// - Parameters:
  ///   - title: A string that describes the text label.
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  @_disfavoredOverload
  init<S>(_ title: S, @ViewBuilder content: () -> Content)
  where S: StringProtocol, Background == EmptyView, Label == Text {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView),
      label: AnyView(Text(title)),
      content: AnyView(content())
    )
  }
}

public extension ToastView {
  /// Creates a `ToastView` with custom `content` and `background` views,
  /// and text label from a localized string.
  ///
  /// - Parameters:
  ///   - titleKey: The key used to look up the localized title for the label.
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  ///   - background: A view builder that creates a view for the background of `ToastView`.
  init(
    _ titleKey: LocalizedStringKey,
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == Text {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(background()),
      label: AnyView(Text(titleKey)),
      content: AnyView(content())
    )
  }

  /// Creates a `ToastView` with custom `content` and `background` views,
  /// and text label from a string.
  ///
  /// - Parameters:
  ///   - title: A string that describes the text label.
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  ///   - background: A view builder that creates a view for the background of `ToastView`.
  @_disfavoredOverload
  init<S>(
    _ title: S,
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where S: StringProtocol, Label == Text {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(background()),
      label: AnyView(Text(title)),
      content: AnyView(content())
    )
  }
}

public extension ToastView {
  /// Creates a `ToastView` with custom `content` view.
  ///
  /// - Parameter content: A view builder that creates a view for the content of `ToastView`.
  init(@ViewBuilder content: () -> Content)
  where Background == EmptyView, Label == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView),
      content: AnyView(content())
    )
  }
}

public extension ToastView {
  /// Creates a `ToastView` with custom `content` and `label` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  ///   - label: A view builder that creates a view for the label of `ToastView`.
  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label
  ) where Background == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(backgroundView),
      label: AnyView(label()),
      content: AnyView(content())
    )
  }

  /// Creates a `ToastView` with custom `content` and `background` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  ///   - background: A view builder that creates a view for the background of `ToastView`.
  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder background: () -> Background
  ) where Label == EmptyView {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(background()),
      content: AnyView(content())
    )
  }

  /// Creates a `ToastView` with custom `content`, `label` and `background` views.
  ///
  /// - Parameters:
  ///   - content: A view builder that creates a view for the content of `ToastView`.
  ///   - label: A view builder that creates a view for the label of `ToastView`.
  ///   - background: A view builder that creates a view for the background of `ToastView`.
  init(
    @ViewBuilder content: () -> Content,
    @ViewBuilder label: () -> Label,
    @ViewBuilder background: () -> Background
  ) {
    self.configuration = ToastViewStyleConfiguration(
      background: AnyView(background()),
      label: AnyView(label()),
      content: AnyView(content())
    )
  }
}
