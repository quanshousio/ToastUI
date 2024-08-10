//
//  ToastViewHostingController.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

#if os(iOS) || os(tvOS) || os(visionOS)
final class ToastViewHostingController<Content>: UIHostingController<Content> where Content: View {
  init(rootView: Content, environment: EnvironmentValues) {
    super.init(rootView: rootView)

    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .crossDissolve

    let dimmedBackgroundColor = UIColor { traitCollection in
      .black.withAlphaComponent(traitCollection.userInterfaceStyle == .light ? 0.2 : 0.48)
    }
    view.backgroundColor = environment.toastDimmedBackground ? dimmedBackgroundColor : .clear
  }

  @available(*, unavailable)
  @objc
  dynamic required init?(coder _: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
#endif
