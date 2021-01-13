//
//  ToastViewEnvironmentKey.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

public extension EnvironmentValues {
  /// The preferred style of the `ToastView`. Default value is `DefaultToastViewStyle`.
  var toastViewStyle: AnyToastViewStyle {
    get { self[ToastViewEnvironmentKey] }
    set { self[ToastViewEnvironmentKey] = newValue }
  }
}

struct ToastViewEnvironmentKey: EnvironmentKey {
  static var defaultValue = AnyToastViewStyle(DefaultToastViewStyle())
}
