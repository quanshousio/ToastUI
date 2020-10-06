//
//  ToastViewModifier.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

internal struct ToastViewIsPresentedModifier<QTContent>: ViewModifier where QTContent: View {
  @Binding var isPresented: Bool
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: () -> QTContent

  @State private var keyWindow: UIWindow?

  private func present(_ shouldPresent: Bool) {
    if keyWindow == nil {
      keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
    var rootViewController = keyWindow?.rootViewController
    while true {
      if let presented = rootViewController?.presentedViewController {
        rootViewController = presented
      } else if let navigationController = rootViewController as? UINavigationController {
        rootViewController = navigationController.visibleViewController
      } else if let tabBarController = rootViewController as? UITabBarController {
        rootViewController = tabBarController.selectedViewController
      } else {
        break
      }
    }

    let toastAlreadyPresented = rootViewController is ToastViewHostingController<QTContent>

    if shouldPresent {
      if !toastAlreadyPresented {
        let toastViewController = ToastViewHostingController(rootView: content())

        DispatchQueue.main.async {
          rootViewController?.present(toastViewController, animated: true)
        }

        if let dismissAfter = dismissAfter {
          DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
            isPresented = false
          }
        }
      }
    } else {
      if toastAlreadyPresented {
        rootViewController?.dismiss(animated: true, completion: onDismiss)
      }
    }
  }

  internal func body(content: Content) -> some View {
    content
      .preference(key: ToastViewPreferenceKey.self, value: isPresented)
      .onPreferenceChange(ToastViewPreferenceKey.self) {
        present($0)
      }
  }
}

internal struct ToastViewItemModifier<Item, QTContent>: ViewModifier
where Item: Identifiable, QTContent: View
{
  @Binding var item: Item?
  let onDismiss: (() -> Void)?
  let content: (Item) -> QTContent

  @State private var keyWindow: UIWindow?

  private func present(_ shouldPresent: Bool) {
    if keyWindow == nil {
      keyWindow = UIApplication.shared.windows.first(where: \.isKeyWindow)
    }
    var rootViewController = keyWindow?.rootViewController
    while true {
      if let presented = rootViewController?.presentedViewController {
        rootViewController = presented
      } else if let navigationController = rootViewController as? UINavigationController {
        rootViewController = navigationController.visibleViewController
      } else if let tabBarController = rootViewController as? UITabBarController {
        rootViewController = tabBarController.selectedViewController
      } else {
        break
      }
    }

    let toastAlreadyPresented = rootViewController is ToastViewHostingController<QTContent>

    if shouldPresent {
      if !toastAlreadyPresented {
        if let item = item {
          let toastViewController = ToastViewHostingController(rootView: content(item))

          DispatchQueue.main.async {
            rootViewController?.present(toastViewController, animated: true)
          }
        }
      }
    } else {
      if toastAlreadyPresented {
        rootViewController?.dismiss(animated: true, completion: onDismiss)
      }
    }
  }

  internal func body(content: Content) -> some View {
    content
      .preference(key: ToastViewPreferenceKey.self, value: item != nil)
      .onPreferenceChange(ToastViewPreferenceKey.self) {
        present($0)
      }
  }
}

#if os(iOS)
internal struct VisualEffectViewModifier: ViewModifier {
  var blurStyle: UIBlurEffect.Style
  var vibrancyStyle: UIVibrancyEffectStyle?
  var blurIntensity: CGFloat?

  internal func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        VisualEffectView(
          blurStyle: blurStyle,
          vibrancyStyle: vibrancyStyle,
          blurIntensity: blurIntensity
        )
        .edgesIgnoringSafeArea(.all)
      )
  }
}
#endif

#if os(tvOS)
internal struct VisualEffectViewModifier: ViewModifier {
  var blurStyle: UIBlurEffect.Style
  var blurIntensity: CGFloat?

  internal func body(content: Content) -> some View {
    content
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .background(
        VisualEffectView(
          blurStyle: blurStyle,
          blurIntensity: blurIntensity
        )
        .edgesIgnoringSafeArea(.all)
      )
  }
}
#endif
