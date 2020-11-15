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

  private func present() {
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

    if isPresented {
      if !toastAlreadyPresented {
        let toastViewController = ToastViewHostingController(rootView: content())
        rootViewController?.present(toastViewController, animated: true)

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
      keyWindow = nil
    }
  }

  @ViewBuilder internal func body(content: Content) -> some View {
    if #available(iOS 14.0, tvOS 14.0, *) {
      content
        .onChange(of: isPresented) { _ in
          present()
        }
    } else {
      content
        .onAppear()
        .onChange(value: isPresented) { _ in
          present()
        }
    }
  }
}

internal struct ToastViewItemModifier<Item, QTContent>: ViewModifier
where Item: Identifiable & Equatable, QTContent: View
{
  @Binding var item: Item?
  let dismissAfter: Double?
  let onDismiss: (() -> Void)?
  let content: (Item) -> QTContent

  @State private var keyWindow: UIWindow?

  private func present() {
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

    if item != nil {
      if !toastAlreadyPresented {
        if let item = item {
          let toastViewController = ToastViewHostingController(rootView: content(item))
          rootViewController?.present(toastViewController, animated: true)

          if let dismissAfter = dismissAfter {
            DispatchQueue.main.asyncAfter(deadline: .now() + dismissAfter) {
              self.item = nil
            }
          }
        }
      } else {
        print(
          """
          [ToastUI] Attempted to present toast while another toast is being presented. \
          This is an undefined behavior and will result in view presentation failures.
          """
        )
      }
    } else {
      if toastAlreadyPresented {
        rootViewController?.dismiss(animated: true, completion: onDismiss)
      }
      keyWindow = nil
    }
  }

  @ViewBuilder internal func body(content: Content) -> some View {
    if #available(iOS 14.0, tvOS 14.0, *) {
      content
        .onChange(of: item) { _ in
          present()
        }
    } else {
      content
        .onAppear()
        .onChange(value: item) { _ in
          present()
        }
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
