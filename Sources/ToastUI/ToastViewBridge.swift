//
//  ToastViewBridge.swift
//  ToastUI
//
//  Created by Quan Tran on 4/20/24.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
struct ToastViewIsPresentedBridge<Content>: UIViewControllerRepresentable where Content: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> Content

  func makeUIViewController(context _: Context) -> ToastViewIsPresentedController<Content> {
    let _ = isPresented // BUG: Need this for SwiftUI to update the view appropriately.
    return ToastViewIsPresentedController()
  }

  func updateUIViewController(
    _ toastViewController: ToastViewIsPresentedController<Content>,
    context: Context
  ) {
    toastViewController.update(
      $isPresented,
      dismissAfter,
      onDismiss,
      content,
      context.environment
    )
  }
}

struct ToastViewItemBridge<Item, Content>: UIViewControllerRepresentable
  where Item: Identifiable, Content: View {
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> Content

  func makeUIViewController(context _: Context) -> ToastViewItemController<Item, Content> {
    let _ = item // BUG: Need this for SwiftUI to update the view appropriately.
    return ToastViewItemController()
  }

  func updateUIViewController(
    _ toastViewController: ToastViewItemController<Item, Content>,
    context: Context
  ) {
    toastViewController.update(
      $item,
      dismissAfter,
      onDismiss,
      content,
      context.environment
    )
  }
}
#endif
