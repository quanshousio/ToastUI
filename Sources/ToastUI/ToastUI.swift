//
//  ToastUI.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

public extension View {
  // MARK: Presenting Toast

  /// Presents a toast when the given boolean binding is true.
  ///
  /// - Parameters:
  ///   - isPresented: A binding to whether the toast should be shown.
  ///   - dismissAfter: An amount of time (in seconds) to dismiss the toast.
  ///   - onDismiss: A closure executed when the toast is dismissed.
  ///   - content: A closure returning the content of the toast.
  ///
  /// - Returns: A modified representation of this view.
  func toast<Content>(
    isPresented: Binding<Bool>,
    dismissAfter: Double? = nil,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View where Content: View {
    modifier(
      ToastViewIsPresentedModifier<Content>(
        isPresented: isPresented,
        dismissAfter: dismissAfter,
        onDismiss: onDismiss,
        content: content
      )
    )
  }

  /// Presents a toast when using the given item as a data source
  /// for toast's content.
  ///
  /// - Parameters:
  ///   - item: A binding to an optional source of truth for the toast.
  ///     When representing a non-`nil` item, the function uses `content` to
  ///     create a toast representation of the item.
  ///     If the identity changes, the function ignores the new item unless the
  ///     old item is dismissed. This behavior might changes in the future.
  ///   - dismissAfter: An amount of time (in seconds) to dismiss the toast.
  ///   - onDismiss: A closure executed when the toast is dismissed.
  ///   - content: A closure returning the content of the toast.
  ///
  /// - Returns: A modified representation of this view.
  func toast<Item, Content>(
    item: Binding<Item?>,
    dismissAfter: Double? = nil,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View where Item: Identifiable & Equatable, Content: View {
    modifier(
      ToastViewItemModifier<Item, Content>(
        item: item,
        dismissAfter: dismissAfter,
        onDismiss: onDismiss,
        content: content
      )
    )
  }
}

public extension View {
  // MARK: Styling Toast

  /// Sets the style for `ToastView` within this view.
  ///
  /// - Parameter style: The `ToastViewStyle` to use for this view.
  ///
  /// - Returns: A modified representation of this view.
  func toastViewStyle<Style>(_ style: Style) -> some View where Style: ToastViewStyle {
    environment(\.toastViewStyle, AnyToastViewStyle(style))
  }
}

public extension View {
  // MARK: Blur Effect

  #if os(iOS)
  /// Sets `UIVisualEffectView` as a background of this view.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the `UIBlurEffect`. Default value is `systemMaterial`.
  ///   - vibrancyStyle: Value of the `UIVibrancyEffectStyle`. Default value is `nil`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  ///
  /// - Returns: A modified representation of this view.
  func cocoaBlur(
    blurStyle: UIBlurEffect.Style = .systemMaterial,
    vibrancyStyle: UIVibrancyEffectStyle? = nil,
    blurIntensity: CGFloat? = 1.0
  ) -> some View {
    modifier(
      VisualEffectViewModifier(
        blurStyle: blurStyle,
        vibrancyStyle: vibrancyStyle,
        blurIntensity: blurIntensity
      )
    )
  }
  #endif

  #if os(tvOS)
  /// Sets `UIVisualEffectView` as a background of this view.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the `UIBlurEffect`. Default value is `regular`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  ///
  /// - Returns: A modified representation of this view.
  func cocoaBlur(
    blurStyle: UIBlurEffect.Style = .regular,
    blurIntensity: CGFloat? = 1.0
  ) -> some View {
    modifier(
      VisualEffectViewModifier(
        blurStyle: blurStyle,
        blurIntensity: blurIntensity
      )
    )
  }
  #endif

  #if os(macOS)
  /// Sets `NSVisualEffectView` as a background of this view.
  ///
  /// - Parameters:
  ///   - material: Material of the `NSVisualEffectView`. Default value is `fullScreenUI`.
  ///   - blendingMode: Blending mode of the `NSVisualEffectView`. Default value is `withinWindow`.
  ///   - state: State of the `NSVisualEffectView`. Default value is `followsWindowActiveState`.
  ///
  /// - Returns: A modified representation of this view.
  func cocoaBlur(
    material: NSVisualEffectView.Material = .fullScreenUI,
    blendingMode: NSVisualEffectView.BlendingMode = .withinWindow,
    state: NSVisualEffectView.State = .followsWindowActiveState
  ) -> some View {
    modifier(
      VisualEffectViewModifier(
        material: material,
        blendingMode: blendingMode,
        state: state
      )
    )
  }
  #endif
}
