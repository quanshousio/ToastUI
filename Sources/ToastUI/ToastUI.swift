//
//  ToastUI.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7.0, visionOS 1.0, *)
public extension View {
  /// Presents a toast when the given binding to a Boolean value is true.
  ///
  /// - Parameters:
  ///   - isPresented: A binding to whether the toast should be shown.
  ///   - dismissAfter: An amount of time (in seconds) to dismiss the toast.
  ///   - onDismiss: A closure to execute when the toast is dismissed.
  ///   - content: A closure that returns the content of the toast.
  func toast<Content>(
    isPresented: Binding<Bool>,
    dismissAfter: Double? = nil,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping () -> Content
  ) -> some View where Content: View {
    #if os(iOS) || os(tvOS) || os(visionOS)
    background(
      ToastViewIsPresentedBridge(
        isPresented: isPresented,
        dismissAfter: dismissAfter,
        onDismiss: onDismiss,
        content: content
      )
      .frame(width: 0, height: 0)
      .disabled(true)
    )
    #elseif os(macOS) || os(watchOS)
    sheet(isPresented: isPresented, onDismiss: onDismiss, content: content)
    #endif
  }

  /// Presents a toast when using the given item as a data source
  /// for the toast's content.
  ///
  /// - Parameters:
  ///   - item: A binding to an optional source of truth for the toast.
  ///     When representing a non-nil item, the function uses `content` to
  ///     create a toast representation of the item.
  ///     If the identity changes, the function ignores the new item unless the
  ///     old item is dismissed.
  ///   - dismissAfter: An amount of time (in seconds) to dismiss the toast.
  ///   - onDismiss: A closure to execute when the toast is dismissed.
  ///   - content: A closure that returns the content of the toast.
  func toast<Item, Content>(
    item: Binding<Item?>,
    dismissAfter: Double? = nil,
    onDismiss: (() -> Void)? = nil,
    @ViewBuilder content: @escaping (Item) -> Content
  ) -> some View where Item: Identifiable, Content: View {
    #if os(iOS) || os(tvOS) || os(visionOS)
    background(
      ToastViewItemBridge(
        item: item,
        dismissAfter: dismissAfter,
        onDismiss: onDismiss,
        content: content
      )
      .frame(width: 0, height: 0)
      .disabled(true)
    )
    #elseif os(macOS) || os(watchOS)
    sheet(item: item, onDismiss: onDismiss, content: content)
    #endif
  }

  /// Sets the style for ``ToastView`` within this view.
  ///
  /// - Parameter style: The ``ToastViewStyle`` to use for this view.
  func toastViewStyle(_ style: some ToastViewStyle) -> some View {
    environment(\.toastViewStyle, AnyToastViewStyle(style))
  }

  /// Sets the dimmed background when presenting the toast within this view.
  ///
  /// - Parameter enabled: Should enable the dimmed background for this view.
  func toastDimmedBackground(_ enabled: Bool) -> some View {
    environment(\.toastDimmedBackground, enabled)
  }
}
