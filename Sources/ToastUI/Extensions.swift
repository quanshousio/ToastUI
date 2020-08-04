//
//  Extensions.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

extension View {
  /// Presents a toast when the given boolean binding is true.
  ///
  /// - Parameters:
  ///   - isPresented: A binding to whether the toast should be shown.
  ///   - dismissAfter: An amount of time (in seconds) to dismiss the toast.
  ///   - onDismiss: A closure executed when the toast is dismissed.
  ///   - content: A closure returning the content of the toast.
  public func toast<Content>(
    isPresented: Binding<Bool>,
    dismissAfter: Double? = nil,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View where Content: View {
    modifier(
      ToastViewIsPresentedModifier(
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
  ///   - onDismiss: A closure executed when the toast is dismissed.
  ///   - content: A closure returning the content of the toast.
  public func toast<Item, Content>(
    item: Binding<Item?>,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View where Item: Identifiable, Content: View {
    modifier(
      ToastViewItemModifier(
        item: item,
        onDismiss: onDismiss,
        content: content
      )
    )
  }
}

extension View {
  /// Sets the style for toast views in this view.
  ///
  /// - Parameter style: The toast view style to use for this view.
  public func toastViewStyle<Style>(_ style: Style) -> some View where Style: ToastViewStyle {
    environment(\.toastViewStyle, AnyToastViewStyle(style))
  }
}

#if os(iOS)
extension View {
  /// Applies a UIBlurEffect to this view.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the UIBlurEffect. Default value is `systemUltraThinMaterial`.
  ///   - vibrancyStyle: Style of the UIVibrancyEffect. Default value is `nil`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  public func cocoaBlur(
    blurStyle: UIBlurEffect.Style = .systemUltraThinMaterial,
    vibrancyStyle: UIVibrancyEffectStyle? = nil,
    blurIntensity: CGFloat? = 1.0
  ) -> some View {
    modifier(
      VisualEffectBlurViewModifier(
        blurStyle: blurStyle,
        vibrancyStyle: vibrancyStyle,
        blurIntensity: blurIntensity
      )
    )
  }
}
#endif

#if os(tvOS)
extension View {
  /// Applies a UIBlurEffect to this view.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the UIBlurEffect. Default value is `regular`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  public func cocoaBlur(
    blurStyle: UIBlurEffect.Style = .regular,
    blurIntensity: CGFloat? = 1.0
  ) -> some View {
    modifier(
      VisualEffectBlurViewModifier(
        blurStyle: blurStyle,
        blurIntensity: blurIntensity
      )
    )
  }
}
#endif
