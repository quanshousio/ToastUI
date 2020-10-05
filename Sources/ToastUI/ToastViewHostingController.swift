//
//  ToastViewHostingController.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

internal final class ToastViewHostingController<Content>: UIHostingController<Content>
where Content: View
{
  override init(rootView: Content) {
    super.init(rootView: rootView)
    commonInit()
  }

  @objc dynamic required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .crossDissolve
    view.backgroundColor = .clear
  }
}
