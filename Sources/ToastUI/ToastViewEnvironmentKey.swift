//
//  ToastViewEnvironmentKey.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

extension EnvironmentValues {
  /// The preferred style of the `ToastView`. Default value is `DefaultToastViewStyle`.
  public var toastViewStyle: AnyToastViewStyle {
    get { self[ToastViewEnvironmentKey] }
    set { self[ToastViewEnvironmentKey] = newValue }
  }
}

internal struct ToastViewEnvironmentKey: EnvironmentKey {
  static var defaultValue = AnyToastViewStyle(DefaultToastViewStyle())
}
