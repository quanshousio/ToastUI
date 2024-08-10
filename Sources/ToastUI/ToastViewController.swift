//
//  ToastViewController.swift
//  ToastUI
//
//  Created by Quan Tran on 4/20/24.
//

// swiftlint:disable function_body_length

import os
import SwiftUI

let logger = Logger(subsystem: "com.quanshousio.ToastUI", category: "ToastUI")

#if os(iOS) || os(tvOS) || os(visionOS)
final class ToastViewIsPresentedController<Content>: UIViewController where Content: View {
  var toastWindow: UIWindow!
  var currentState = false
  var transitioning = false

  func update(
    _ isPresented: Binding<Bool>,
    _ dismissAfter: Double?,
    _ onDismiss: (() -> Void)?,
    _ content: () -> Content,
    _ environment: EnvironmentValues
  ) {
    if currentState == isPresented.wrappedValue {
      return
    }
    
    defer {
      currentState = isPresented.wrappedValue
    }
    
    if transitioning && isPresented.wrappedValue {
      logger.fault("Attempted to present the toast view while a presentation is in progress.")
      DispatchQueue.main.async {
        isPresented.wrappedValue = false
      }
      return
    }

    guard let windowScene = view.window?.windowScene else {
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
      rootViewController.presentedViewController is ToastViewHostingController<Content>

    let anotherToastAlreadyPresented = windowScene
      .windows
      .compactMap { window in
        String(describing: window.rootViewController?.presentedViewController)
      }
      .contains(where: "ToastViewHostingController".contains)

    if isPresented.wrappedValue {
      if toastAlreadyPresented {
        logger.fault("Attempted to present the toast view while it is already presented.")
        DispatchQueue.main.async {
          isPresented.wrappedValue = false
        }
        return
      }

      if anotherToastAlreadyPresented {
        logger.fault("Attempted to present the toast view while another one is presenting.")
        DispatchQueue.main.async {
          isPresented.wrappedValue = false
        }
        return
      }

      transitioning = true
      
      toastWindow.makeKeyAndVisible()
      
      let toastViewController = ToastViewHostingController(
        rootView: content(),
        environment: environment
      )
      
      DispatchQueue.main.async {
        rootViewController.present(toastViewController, animated: true) {
          self.transitioning = false
        }
      }

      if let dismissAfter = dismissAfter {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
          isPresented.wrappedValue = false
        }
      }
    } else {
      if !toastAlreadyPresented, !anotherToastAlreadyPresented {
        return
      }

      transitioning = true
      
      DispatchQueue.main.async {
        rootViewController.dismiss(animated: true) { [self] in
          onDismiss?()
          if toastWindow != nil {
            toastWindow.windowScene = nil
          }
          toastWindow = nil
          transitioning = false
        }
      }
    }
  }
}

final class ToastViewItemController<Item, Content>: UIViewController
where Item: Identifiable, Content: View {
  var toastWindow: UIWindow!
  var currentState: Item.ID?
  var transitioning = false

  func update(
    _ item: Binding<Item?>,
    _ dismissAfter: Double?,
    _ onDismiss: (() -> Void)?,
    _ content: (Item) -> Content,
    _ environment: EnvironmentValues
  ) {
    if currentState == item.wrappedValue?.id {
      return
    }
    
    defer {
      currentState = item.wrappedValue?.id
    }
    
    if transitioning && item.wrappedValue != nil {
      logger.fault("Attempted to present the toast view while a presentation is in progress.")
      DispatchQueue.main.async {
        item.wrappedValue = nil
      }
      return
    }

    guard let windowScene = view.window?.windowScene else {
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
      rootViewController.presentedViewController is ToastViewHostingController<Content>

    let anotherToastAlreadyPresented = windowScene
      .windows
      .compactMap { window in
        String(describing: window.rootViewController?.presentedViewController)
      }
      .contains(where: "ToastViewHostingController".contains)

    if let value = item.wrappedValue {
      if toastAlreadyPresented {
        logger.fault("Attempted to present the toast view while it is already presented.")
        DispatchQueue.main.async {
          item.wrappedValue = nil
        }
        return
      }

      if anotherToastAlreadyPresented {
        logger.fault("Attempted to present the toast view while another toast view is presenting.")
        DispatchQueue.main.async {
          item.wrappedValue = nil
        }
        return
      }

      transitioning = true
      
      toastWindow.makeKeyAndVisible()
      
      let toastViewController = ToastViewHostingController(
        rootView: content(value),
        environment: environment
      )
      
      DispatchQueue.main.async {
        rootViewController.present(toastViewController, animated: true) {
          self.transitioning = false
        }
      }

      if let dismissAfter = dismissAfter {
        DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
          item.wrappedValue = nil
        }
      }
    } else {
      if !toastAlreadyPresented, !anotherToastAlreadyPresented {
        return
      }

      transitioning = true
      
      DispatchQueue.main.async {
        rootViewController.dismiss(animated: true) { [self] in
          onDismiss?()
          if toastWindow != nil {
            toastWindow.windowScene = nil
          }
          toastWindow = nil
          transitioning = false
        }
      }
    }
  }
}
#endif
