//
//  ToastViewHostingController.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

#if os(iOS) || os(tvOS)
final class ToastViewHostingController<Content>: UIHostingController<Content>
where Content: View {
  override init(rootView: Content) {
    super.init(rootView: rootView)
    commonInit()
  }

  @objc dynamic required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .crossDissolve
    view.backgroundColor = .clear
  }
}
#endif

#if os(macOS)
// swiftlint:disable colon
final class ToastViewHostingController<Content>:
  NSHostingController<Content>,
  NSWindowDelegate
where Content: View {
  var onDismiss: (() -> Void)?

  override func viewDidAppear() {
    super.viewDidAppear()
    NSApplication.shared.windows.first?.delegate = self
  }

  func dismissWithCompletion(_ onDismiss: (() -> Void)? = nil) {
    self.onDismiss = onDismiss
    dismiss(nil)
  }

  func windowDidEndSheet(_ notification: Notification) {
    onDismiss?()
  }
}
#endif
