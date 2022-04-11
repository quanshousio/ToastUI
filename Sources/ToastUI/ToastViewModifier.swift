//
//  ToastViewModifier.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

// swiftlint:disable file_length
// swiftlint:disable function_body_length

import os
import SwiftUI

let logger = Logger(subsystem: "com.quanshousio.ToastUI", category: "ToastUI")

#if os(iOS) || os(tvOS)
struct ToastViewIsPresentedModifier<ToastContent>: ViewModifier where ToastContent: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> ToastContent

  @State private var toastWindow: UIWindow!
  @State private var viewController: UIViewController!
  @State private var transitioning: Bool = false

  @Environment(\.toastDimmedBackground) private var dimmedBackground

  private func present() {
    if transitioning {
      let what = isPresented ? "present" : "dismiss"
      logger.error("Attempted to \(what) the toast view while it is in transition")
      return
    }

    guard let windowScene = viewController?.view.window?.windowScene else {
      logger.error("Failed to get the scene containing the window in the current view")
      return
    }

    if toastWindow == nil {
      let window = UIWindow()
      window.rootViewController = UIViewController()
      window.backgroundColor = .clear
      window.windowLevel = .alert
      window.windowScene = windowScene
      toastWindow = window
    }

    let rootViewController = toastWindow.rootViewController!

    let toastAlreadyPresented =
      rootViewController.presentedViewController is ToastViewHostingController<ToastContent>

    let anotherToastAlreadyPresented = windowScene
      .windows
      .compactMap { window in
        String(describing: window.rootViewController?.presentedViewController)
      }
      .contains(where: "ToastViewHostingController".contains)

    if isPresented {
      if toastAlreadyPresented {
        logger.error("Attempted to present the toast view while it is already presented")
        return
      }

      if anotherToastAlreadyPresented {
        logger.error("Attempted to present the toast view while another toast view is presenting")
        return
      }

      transitioning = true
      toastWindow.makeKeyAndVisible()
      let toastViewController = ToastViewHostingController(
        rootView: content(),
        dimmedBackground: dimmedBackground
      )
      rootViewController.present(toastViewController, animated: true) {
        transitioning = false
      }

      if let dismissAfter = dismissAfter {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
          isPresented = false
        }
      }
    } else {
      if !toastAlreadyPresented, !anotherToastAlreadyPresented {
        logger.error("Attempted to dismiss the toast view while it is not presenting")
        return
      }

      transitioning = true
      rootViewController.dismiss(animated: true) {
        onDismiss?()
        toastWindow.windowScene = nil
        toastWindow = nil
        transitioning = false
      }
    }
  }

  func body(content: Content) -> some View {
    content
      .introspectViewController { viewController in
        self.viewController = viewController
      }
      .onChange(of: isPresented) { _ in
        present()
      }
  }
}

struct ToastViewItemModifier<Item, ToastContent>: ViewModifier
where Item: Identifiable & Equatable, ToastContent: View {
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> ToastContent

  @State private var toastWindow: UIWindow!
  @State private var viewController: UIViewController!
  @State private var transitioning: Bool = false

  @Environment(\.toastDimmedBackground) private var dimmedBackground

  private func present(previousItem: Item?) {
    if transitioning {
      let what = item != nil ? "present" : "dismiss"
      logger.error("Attempted to \(what) a toast view while it is in transition")
      return
    }

    guard let windowScene = viewController?.view.window?.windowScene else {
      logger.error("Failed to get the scene containing the window in the current view")
      return
    }

    if toastWindow == nil {
      let window = UIWindow()
      window.rootViewController = UIViewController()
      window.backgroundColor = .clear
      window.windowLevel = .alert
      window.windowScene = windowScene
      toastWindow = window
    }

    let rootViewController = toastWindow.rootViewController!

    let toastAlreadyPresented =
      rootViewController.presentedViewController is ToastViewHostingController<ToastContent>

    let anotherToastAlreadyPresented = windowScene
      .windows
      .compactMap { window in
        String(describing: window.rootViewController?.presentedViewController)
      }
      .contains(where: "ToastViewHostingController".contains)

    if let item = item {
      if anotherToastAlreadyPresented || previousItem != nil {
        logger.error("Attempted to present the toast view while another toast view is presenting")
        return
      }

      if toastAlreadyPresented {
        logger.error("Attempted to present the toast view while it is already presented")
        return
      }

      transitioning = true
      toastWindow.makeKeyAndVisible()
      let toastViewController = ToastViewHostingController(
        rootView: content(item),
        dimmedBackground: dimmedBackground
      )
      rootViewController.present(toastViewController, animated: true) {
        transitioning = false
      }

      if let dismissAfter = dismissAfter {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
          self.item = nil
        }
      }
    } else {
      if !toastAlreadyPresented, !anotherToastAlreadyPresented {
        logger.error("Attempted to dismiss the toast view while it is not presenting")
        return
      }

      transitioning = true
      rootViewController.dismiss(animated: true) {
        onDismiss?()
        toastWindow.windowScene = nil
        toastWindow = nil
        transitioning = false
      }
    }
  }

  func body(content: Content) -> some View {
    content
      .introspectViewController { viewController in
        self.viewController = viewController
      }
      .onChange(of: item) { [item] _ in
        present(previousItem: item)
      }
  }
}
#endif

#if os(macOS)
struct ToastViewIsPresentedModifier<ToastContent>: ViewModifier where ToastContent: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> ToastContent

  @State private var keyWindow: NSWindow!
  @State private var viewController: NSViewController!
  @State private var transitioning: Bool = false

  @Environment(\.toastDimmedBackground) private var dimmedBackground

  private func present() {
    if transitioning {
      let what = isPresented ? "present" : "dismiss"
      logger.error("Attempted to \(what) a toast view while it is in transition")
      return
    }

    if keyWindow == nil {
      keyWindow = viewController?.view.window
    }

    guard let rootViewController = keyWindow?.contentViewController else {
      logger.error("Failed to get the main content view controller of the key window: \(keyWindow)")
      return
    }

    let presentedToastViewController = rootViewController
      .presentedViewControllers?
      .compactMap { viewController in
        viewController as? ToastViewHostingController<ToastContent>
      }
      .first

    let anotherToastAlreadyPresented = rootViewController.view is ToastContainerView

    if isPresented {
      if presentedToastViewController != nil {
        logger.error("Attempted to present the toast view while it is already presented")
        return
      }

      if anotherToastAlreadyPresented {
        logger.error("Attempted to present the toast view while another toast view is presenting")
        return
      }

      transitioning = true
      let toastViewController = ToastViewHostingController(rootView: content())
      toastViewController.onPresent = {
        transitioning = false
      }
      let toastPresentationAnimator = ToastPresentationAnimator()
      toastPresentationAnimator.dimmedBackground = dimmedBackground
      rootViewController.present(toastViewController, animator: toastPresentationAnimator)

      if let dismissAfter = dismissAfter {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
          isPresented = false
        }
      }
    } else {
      guard let toastViewController = presentedToastViewController,
            anotherToastAlreadyPresented
      else {
        logger.error("Attempted to dismiss the toast view while it is not presenting")
        return
      }

      transitioning = true
      toastViewController.onDismiss = {
        onDismiss?()
        keyWindow = nil
        transitioning = false
      }
      rootViewController.dismiss(toastViewController)
    }
  }

  func body(content: Content) -> some View {
    content
      .introspectViewController { viewController in
        self.viewController = viewController
      }
      .onChange(of: isPresented) { _ in
        present()
      }
  }
}

struct ToastViewItemModifier<Item, ToastContent>: ViewModifier
where Item: Identifiable & Equatable, ToastContent: View {
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> ToastContent

  @State private var keyWindow: NSWindow!
  @State private var viewController: NSViewController!
  @State private var transitioning: Bool = false

  @Environment(\.toastDimmedBackground) private var dimmedBackground

  private func present(previousItem: Item?) {
    if transitioning {
      let what = item != nil ? "present" : "dismiss"
      logger.error("Attempted to \(what) a toast view while it is in transition")
      return
    }

    if keyWindow == nil {
      keyWindow = viewController?.view.window
    }

    guard let rootViewController = keyWindow?.contentViewController else {
      logger.error("Failed to get the main content view controller of the key window: \(keyWindow)")
      return
    }

    let presentedToastViewController = rootViewController
      .presentedViewControllers?
      .compactMap { viewController in
        viewController as? ToastViewHostingController<ToastContent>
      }
      .first

    let anotherToastAlreadyPresented = rootViewController.view is ToastContainerView

    if let item = item {
      if anotherToastAlreadyPresented || previousItem != nil {
        logger.error("Attempted to present the toast view while another toast view is presenting")
        return
      }

      if presentedToastViewController != nil {
        logger.error("Attempted to present the toast view while it is already presented")
        return
      }

      transitioning = true
      let toastViewController = ToastViewHostingController(rootView: content(item))
      toastViewController.onPresent = {
        transitioning = false
      }
      let toastPresentationAnimator = ToastPresentationAnimator()
      toastPresentationAnimator.dimmedBackground = dimmedBackground
      rootViewController.present(toastViewController, animator: toastPresentationAnimator)

      if let dismissAfter = dismissAfter {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
          self.item = nil
        }
      }
    } else {
      guard let toastViewController = presentedToastViewController,
            anotherToastAlreadyPresented
      else {
        logger.error("Attempted to dismiss the toast view while it is not presenting")
        return
      }

      transitioning = true
      toastViewController.onDismiss = {
        onDismiss?()
        keyWindow = nil
        transitioning = false
      }
      rootViewController.dismiss(toastViewController)
    }
  }

  func body(content: Content) -> some View {
    content
      .introspectViewController { viewController in
        self.viewController = viewController
      }
      .onChange(of: item) { [item] _ in
        present(previousItem: item)
      }
  }
}
#endif

#if os(watchOS)
struct ToastViewIsPresentedModifier<ToastContent>: ViewModifier where ToastContent: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> ToastContent

  func body(content view: Content) -> some View {
    view
      .sheet(isPresented: $isPresented, onDismiss: onDismiss, content: content)
  }
}

struct ToastViewItemModifier<Item, ToastContent>: ViewModifier
where Item: Identifiable & Equatable, ToastContent: View {
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> ToastContent

  func body(content view: Content) -> some View {
    view
      .sheet(item: $item, onDismiss: onDismiss, content: content)
  }
}
#endif
