//
//  ToastPresentationAnimator.swift
//  ToastUI
//
//  Created by Quan Tran on 9/30/21.
//

#if os(macOS)
import CoreImage.CIFilterBuiltins
import SwiftUI

class ToastContainerView: NSView {}

class ToastDimmingView: NSView {
  var dimmedBackground = true

  override func hitTest(_ point: NSPoint) -> NSView? {
    super.hitTest(point)?.superview
  }

  override var wantsUpdateLayer: Bool {
    true
  }

  override func updateLayer() {
    let dimmedBackgroundColor = NSColor(name: nil) { appearance in
      appearance.name == .aqua
        ? .lightGray.withAlphaComponent(0.6)
        : .init(deviceWhite: 0.075, alpha: 0.6)
    }.cgColor
    layer?.backgroundColor = dimmedBackground ? dimmedBackgroundColor : .clear

    let filter = CIFilter.colorControls()
    filter.saturation = 0
    layer?.backgroundFilters = [filter]
  }
}

class ToastPresentationAnimator: NSObject, NSViewControllerPresentationAnimator {
  var dimmedBackground = true

  private var fromView: NSView!
  private var dimmingView: ToastDimmingView!

  func animatePresentation(
    of viewController: NSViewController,
    from fromViewController: NSViewController
  ) {
    /*
     expected view hierarchy after presentation
     NSHostingController
     + ToastContainerView
     | + NSHostingView<RootView>
     | + ToastDimmingView
     | + ToastViewHostingController
     | | + NSHostingView<ToastView>
     */
    fromView = fromViewController.view

    let containerView = ToastContainerView()
    containerView.frame = fromView.bounds
    containerView.autoresizingMask = [.width, .height]

    dimmingView = ToastDimmingView()
    dimmingView.frame = containerView.bounds
    dimmingView.autoresizingMask = [.width, .height]
    dimmingView.alphaValue = 0
    dimmingView.dimmedBackground = dimmedBackground

    viewController.view.frame = containerView.bounds
    viewController.view.autoresizingMask = [.width, .height]
    viewController.view.alphaValue = 0

    fromViewController.addChild(viewController)
    fromViewController.view = containerView

    containerView.addSubview(fromView)
    containerView.addSubview(dimmingView)
    containerView.addSubview(viewController.view)

    NSAnimationContext.runAnimationGroup { context in
      context.duration = 0.4
      dimmingView.animator().alphaValue = 1
      viewController.view.animator().alphaValue = 1
    }
  }

  func animateDismissal(
    of viewController: NSViewController,
    from fromViewController: NSViewController
  ) {
    /*
     expected view hierarchy after dismissal
     NSHostingController
     + NSHostingView<RootView>
     */
    NSAnimationContext.runAnimationGroup { context in
      context.duration = 0.4
      fromView.animator().alphaValue = 1
      dimmingView.animator().alphaValue = 0
      dimmingView.animator().layer?.backgroundFilters = []
      viewController.view.animator().alphaValue = 0
    } completionHandler: {
      fromViewController.view.subviews.forEach { view in
        view.removeFromSuperview()
      }
      viewController.removeFromParent()
      fromViewController.view = self.fromView
    }
  }
}
#endif
