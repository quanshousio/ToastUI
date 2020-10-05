//
//  VisualEffectView.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

/// `UIVisualEffectView` wrapper for SwiftUI.
public struct VisualEffectView<Content>: View where Content: View {
  // MARK: Properties

  private var blurStyle: UIBlurEffect.Style
  #if os(iOS)
  private var vibrancyStyle: UIVibrancyEffectStyle?
  #endif
  private var blurIntensity: CGFloat?
  private var content: Content

  /// The content and behavior of the view.
  public var body: some View {
    #if os(iOS)
    return Representable(
      blurStyle: blurStyle,
      vibrancyStyle: vibrancyStyle,
      blurIntensity: blurIntensity,
      content: ZStack { content }
    )
    .accessibility(hidden: Content.self == EmptyView.self)
    #endif

    #if os(tvOS)
    return Representable(
      blurStyle: blurStyle,
      blurIntensity: blurIntensity,
      content: ZStack { content }
    )
    .accessibility(hidden: Content.self == EmptyView.self)
    #endif
  }
}

// MARK: Initializers

extension VisualEffectView {
  #if os(iOS)
  /// Creates a `VisualEffectView` with provided `content`.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the `UIBlurEffect`. Default value is `systemMaterial`.
  ///   - vibrancyStyle: Value of the `UIVibrancyEffectStyle`. Default value is `nil`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  ///   - content: A view builder that creates a view for the content of `VisualEffectView`.
  public init(
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
  #endif

  #if os(tvOS)
  /// Creates a `VisualEffectView` with provided `content`.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the `UIBlurEffect`. Default value is `regular`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  ///   - content: A view builder that creates a view for the content of `VisualEffectView`.
  public init(
    blurStyle: UIBlurEffect.Style = .regular,
    blurIntensity: CGFloat? = 1.0,
    @ViewBuilder content: () -> Content
  ) {
    self.blurStyle = blurStyle
    self.blurIntensity = blurIntensity
    self.content = content()
  }
  #endif
}

extension VisualEffectView where Content == EmptyView {
  #if os(iOS)
  /// Creates an empty `VisualEffectView`.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the `UIBlurEffect`. Default value is `systemMaterial`.
  ///   - vibrancyStyle: Value of the `UIVibrancyEffectStyle`. Default value is `nil`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  public init(
    blurStyle: UIBlurEffect.Style = .systemMaterial,
    vibrancyStyle: UIVibrancyEffectStyle? = nil,
    blurIntensity: CGFloat? = 1.0
  ) {
    self.init(blurStyle: blurStyle, vibrancyStyle: nil, blurIntensity: blurIntensity) {
      EmptyView()
    }
  }
  #endif

  #if os(tvOS)
  /// Creates an empty `VisualEffectView`.
  ///
  /// - Parameters:
  ///   - blurStyle: Style of the `UIBlurEffect`. Default value is `systemMaterial`.
  ///   - blurIntensity: Blur intensity ranging from `0.0` to `1.0`. Default value is `1.0`.
  public init(blurStyle: UIBlurEffect.Style = .regular, blurIntensity: CGFloat? = 1.0) {
    self.init(blurStyle: blurStyle, blurIntensity: blurIntensity) {
      EmptyView()
    }
  }
  #endif
}

// MARK: Representable

internal extension VisualEffectView {
  struct Representable<Content>: UIViewRepresentable where Content: View {
    var blurStyle: UIBlurEffect.Style
    #if os(iOS)
    var vibrancyStyle: UIVibrancyEffectStyle?
    #endif
    var blurIntensity: CGFloat?
    var content: Content

    func makeUIView(context: Context) -> UIVisualEffectView {
      context.coordinator.blurView
    }

    func updateUIView(_ view: UIVisualEffectView, context: Context) {
      #if os(iOS)
      context.coordinator.update(
        content: content,
        blurStyle: blurStyle,
        vibrancyStyle: vibrancyStyle,
        blurIntensity: blurIntensity
      )
      #endif

      #if os(tvOS)
      context.coordinator.update(
        content: content,
        blurStyle: blurStyle,
        blurIntensity: blurIntensity
      )
      #endif
    }

    func makeCoordinator() -> Coordinator {
      Coordinator(content: content)
    }
  }
}

// MARK: Coordinator

internal extension VisualEffectView.Representable {
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

    #if os(iOS)
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

      animator.addAnimations { [weak self] in
        self?.blurView.effect = blurEffect
        self?.vibrancyView.effect = vibrancyEffect
      }

      DispatchQueue.main.async { [weak self] in
        self?.animator.fractionComplete = blurIntensity ?? 1.0
      }

      hostingController.view.setNeedsDisplay()
    }
    #endif

    #if os(tvOS)
    func update(
      content: Content,
      blurStyle: UIBlurEffect.Style,
      blurIntensity: CGFloat?
    ) {
      hostingController.rootView = content

      let blurEffect = UIBlurEffect(style: blurStyle)
      animator.addAnimations { [weak self] in
        self?.blurView.effect = blurEffect
      }

      DispatchQueue.main.async { [weak self] in
        self?.animator.fractionComplete = blurIntensity ?? 1.0
      }

      hostingController.view.setNeedsDisplay()
    }
    #endif

    deinit {
      animator.stopAnimation(true)
    }
  }
}
