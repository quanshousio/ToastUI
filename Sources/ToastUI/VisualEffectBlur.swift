//
//  VisualEffectBlur.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

#if os(iOS)
public struct VisualEffectBlur<Content: View>: View {
  /// Defaults to .systemMaterial
  var blurStyle: UIBlurEffect.Style

  /// Defaults to nil
  var vibrancyStyle: UIVibrancyEffectStyle?

  /// Defaults to 1.0
  var blurIntensity: CGFloat?

  var content: Content

  init(
    blurStyle: UIBlurEffect.Style = .systemMaterial,
    vibrancyStyle: UIVibrancyEffectStyle? = nil,
    blurIntensity: CGFloat? = 1.0,
    @ViewBuilder content: () -> Content
  ) {
    self.blurStyle = blurStyle
    self.vibrancyStyle = vibrancyStyle
    self.blurIntensity = blurIntensity
    self.content = content()
  }

  public var body: some View {
    Representable(
      blurStyle: blurStyle,
      vibrancyStyle: vibrancyStyle,
      blurIntensity: blurIntensity,
      content: ZStack { content }
    )
    .accessibility(hidden: Content.self == EmptyView.self)
  }
}

extension VisualEffectBlur {
  struct Representable<Content: View>: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    var vibrancyStyle: UIVibrancyEffectStyle?
    var blurIntensity: CGFloat?
    var content: Content

    func makeUIView(context: Context) -> UIVisualEffectView {
      context.coordinator.blurView
    }

    func updateUIView(_ view: UIVisualEffectView, context: Context) {
      context.coordinator.update(
        content: content,
        blurStyle: blurStyle,
        vibrancyStyle: vibrancyStyle,
        blurIntensity: blurIntensity
      )
    }

    func makeCoordinator() -> Coordinator {
      Coordinator(content: content)
    }
  }
}

extension VisualEffectBlur.Representable {
  class Coordinator {
    let blurView = UIVisualEffectView()
    let vibrancyView = UIVisualEffectView()
    let hostingController: UIHostingController<Content>
    let animator: UIViewPropertyAnimator!

    init(content: Content) {
      self.hostingController = UIHostingController(rootView: content)
      hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      hostingController.view.backgroundColor = nil

      blurView.contentView.addSubview(vibrancyView)
      blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

      vibrancyView.contentView.addSubview(hostingController.view)
      vibrancyView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

      self.animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
    }

    func update(
      content: Content,
      blurStyle: UIBlurEffect.Style,
      vibrancyStyle: UIVibrancyEffectStyle?,
      blurIntensity: CGFloat?
    ) {
      hostingController.rootView = content

      let blurEffect = UIBlurEffect(style: blurStyle)

      var vibrancyEffect: UIVibrancyEffect?
      if let vibrancyStyle = vibrancyStyle {
        vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
      } else {
        vibrancyEffect = nil
      }

      animator.addAnimations {
        self.blurView.effect = blurEffect
        self.vibrancyView.effect = vibrancyEffect
      }
      animator.fractionComplete = blurIntensity ?? 1.0

      hostingController.view.setNeedsDisplay()
    }
  }
}

extension VisualEffectBlur where Content == EmptyView {
  init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
    self.init(blurStyle: blurStyle, vibrancyStyle: nil) {
      EmptyView()
    }
  }
}
#endif

#if os(tvOS)
public struct VisualEffectBlur<Content: View>: View {
  /// Defaults to .systemMaterial
  var blurStyle: UIBlurEffect.Style

  /// Defaults to 1.0
  var blurIntensity: CGFloat?

  var content: Content

  init(
    blurStyle: UIBlurEffect.Style = .regular,
    blurIntensity: CGFloat? = 1.0,
    @ViewBuilder content: () -> Content
  ) {
    self.blurStyle = blurStyle
    self.blurIntensity = blurIntensity
    self.content = content()
  }

  public var body: some View {
    Representable(
      blurStyle: blurStyle,
      blurIntensity: blurIntensity,
      content: ZStack { content }
    )
    .accessibility(hidden: Content.self == EmptyView.self)
  }
}

extension VisualEffectBlur {
  struct Representable<Content: View>: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style
    var blurIntensity: CGFloat?
    var content: Content

    func makeUIView(context: Context) -> UIVisualEffectView {
      context.coordinator.blurView
    }

    func updateUIView(_ view: UIVisualEffectView, context: Context) {
      context.coordinator.update(
        content: content,
        blurStyle: blurStyle,
        blurIntensity: blurIntensity
      )
    }

    func makeCoordinator() -> Coordinator {
      Coordinator(content: content)
    }
  }
}

extension VisualEffectBlur.Representable {
  class Coordinator {
    let blurView = UIVisualEffectView()
    let hostingController: UIHostingController<Content>
    let animator: UIViewPropertyAnimator!

    init(content: Content) {
      self.hostingController = UIHostingController(rootView: content)
      hostingController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
      hostingController.view.backgroundColor = nil

      blurView.contentView.addSubview(hostingController.view)
      blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

      self.animator = UIViewPropertyAnimator(duration: 1.0, curve: .linear)
    }

    func update(
      content: Content,
      blurStyle: UIBlurEffect.Style,
      blurIntensity: CGFloat?
    ) {
      hostingController.rootView = content

      let blurEffect = UIBlurEffect(style: blurStyle)
      animator.addAnimations {
        self.blurView.effect = blurEffect
      }
      animator.fractionComplete = blurIntensity ?? 1.0

      hostingController.view.setNeedsDisplay()
    }
  }
}

extension VisualEffectBlur where Content == EmptyView {
  init(blurStyle: UIBlurEffect.Style = .regular) {
    self.init(blurStyle: blurStyle) {
      EmptyView()
    }
  }
}
#endif
