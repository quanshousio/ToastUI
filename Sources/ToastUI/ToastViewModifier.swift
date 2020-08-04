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

  private func present(_ shouldPresent: Bool) {
    // TODO: Find the correct active window when there are multiple foreground active scenes
    let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
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

    let alertAlreadyPresented = rootViewController is ToastViewHostingController<QTContent>

    if shouldPresent {
      if !alertAlreadyPresented {
        let alertViewController = ToastViewHostingController(rootView: content())
        rootViewController?.present(alertViewController, animated: true)

        if let dismissAfter = dismissAfter {
          DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
            self.isPresented = false
          }
        }
      }
    } else {
      if alertAlreadyPresented {
        rootViewController?.dismiss(animated: true, completion: onDismiss)
      }
    }
  }

  internal func body(content: Content) -> some View {
    content
      .preference(key: ToastViewPreferenceKey.self, value: isPresented)
      .onPreferenceChange(ToastViewPreferenceKey.self) {
        self.present($0)
      }
  }
}

internal struct ToastViewItemModifier<Item, QTContent>: ViewModifier where Item: Identifiable, QTContent: View {
  @Binding var item: Item?
  let onDismiss: (() -> Void)?
  let content: (Item) -> QTContent

  private func present(_ shouldPresent: Bool) {
    // TODO: Find the correct active window when there are multiple foreground active scenes
    let keyWindow = UIApplication.shared.windows.first { $0.isKeyWindow }
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

    let alertAlreadyPresented = rootViewController is ToastViewHostingController<QTContent>

    if shouldPresent {
      if !alertAlreadyPresented {
        if let item = item {
          let alertViewController = ToastViewHostingController(rootView: content(item))
          rootViewController?.present(alertViewController, animated: true)
        }
      }
    } else {
      if alertAlreadyPresented {
        rootViewController?.dismiss(animated: true, completion: onDismiss)
      }
    }
  }

  internal func body(content: Content) -> some View {
    content
      .preference(key: ToastViewPreferenceKey.self, value: item != nil)
      .onPreferenceChange(ToastViewPreferenceKey.self) {
        self.present($0)
      }
  }
}

#if os(iOS)
internal struct VisualEffectBlurViewModifier: ViewModifier {
  var blurStyle: UIBlurEffect.Style
  var vibrancyStyle: UIVibrancyEffectStyle?
  var blurIntensity: CGFloat?

  func body(content: Content) -> some View {
    VisualEffectBlur(blurStyle: blurStyle, vibrancyStyle: vibrancyStyle, blurIntensity: blurIntensity) {
      content
    }
    .edgesIgnoringSafeArea(.all)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
#endif

#if os(tvOS)
internal struct VisualEffectBlurViewModifier: ViewModifier {
  var blurStyle: UIBlurEffect.Style
  var blurIntensity: CGFloat?

  func body(content: Content) -> some View {
    VisualEffectBlur(blurStyle: blurStyle, blurIntensity: blurIntensity) {
      content
    }
    .edgesIgnoringSafeArea(.all)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
  }
}
#endif
