//
//  ToastViewPreferenceKey.swift
//  ToastUI
//
//  Created by Quan Tran on 7/17/20.
//

import SwiftUI

internal struct ToastViewPreferenceKey: PreferenceKey {
  static var defaultValue: Bool = false

  static func reduce(value: inout Bool, nextValue: () -> Bool) {
    value = nextValue()
  }
}
