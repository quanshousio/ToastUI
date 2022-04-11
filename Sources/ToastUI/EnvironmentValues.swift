//
//  EnvironmentValues.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

extension EnvironmentValues {
  var toastViewStyle: AnyToastViewStyle {
    get {
      self[ToastViewStyleEnvironmentKey.self]
    }
    set {
      self[ToastViewStyleEnvironmentKey.self] = newValue
    }
  }

  var toastDimmedBackground: Bool {
    get {
      self[ToastDimmedBackgroundEnvironmentKey.self]
    }
    set {
      self[ToastDimmedBackgroundEnvironmentKey.self] = newValue
    }
  }
}

struct ToastViewStyleEnvironmentKey: EnvironmentKey {
  static let defaultValue = AnyToastViewStyle(DefaultToastViewStyle())
}

struct ToastDimmedBackgroundEnvironmentKey: EnvironmentKey {
  static let defaultValue: Bool = true
}
