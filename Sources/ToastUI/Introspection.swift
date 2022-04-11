//
//  Introspection.swift
//  ToastUI
//
//  Created by Quan Tran on 8/13/21.
//

import SwiftUI

#if os(iOS) || os(tvOS)
struct IntrospectionViewController: UIViewControllerRepresentable {
  let targetViewController: (UIViewController) -> Void

  init(targetViewController: @escaping (UIViewController) -> Void) {
    self.targetViewController = targetViewController
  }

  func makeUIViewController(context _: Context) -> UIViewController {
    UIViewController()
  }

  func updateUIViewController(_ uiViewController: UIViewController, context _: Context) {
    DispatchQueue.main.async {
      targetViewController(uiViewController)
    }
  }
}

extension View {
  func introspectViewController(
    targetViewController: @escaping (UIViewController) -> Void
  ) -> some View {
    background(
      IntrospectionViewController(targetViewController: targetViewController)
        .frame(width: 0, height: 0)
        .disabled(true)
    )
  }
}
#endif

#if os(macOS)
struct IntrospectionViewController: NSViewControllerRepresentable {
  let targetViewController: (NSViewController) -> Void

  init(targetViewController: @escaping (NSViewController) -> Void) {
    self.targetViewController = targetViewController
  }

  func makeNSViewController(context _: Context) -> NSViewController {
    let viewController = NSViewController()
    viewController.view = NSView()
    return viewController
  }

  func updateNSViewController(_ nsViewController: NSViewController, context _: Context) {
    DispatchQueue.main.async {
      targetViewController(nsViewController)
    }
  }
}

extension View {
  func introspectViewController(
    targetViewController: @escaping (NSViewController) -> Void
  ) -> some View {
    background(
      IntrospectionViewController(targetViewController: targetViewController)
        .frame(width: 0, height: 0)
        .disabled(true)
    )
  }
}
#endif
