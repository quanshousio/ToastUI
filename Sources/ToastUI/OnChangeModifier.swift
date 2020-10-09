//
//  OnChangeModifier.swift
//  ToastUI
//
//  Created by Quan Tran on 10/09/20.
//
//  https://stackoverflow.com/questions/58363563/swiftui-get-notified-when-binding-value-changes

import SwiftUI

internal struct ChangeObserver<Base, Value>: View where Base: View, Value: Equatable {
  let base: Base
  let value: Value
  let action: (Value) -> Void

  private let model = Model()

  var body: some View {
    if model.update(value: value) {
      DispatchQueue.main.async {
        action(value)
      }
    }
    return base
  }

  class Model {
    private var savedValue: Value?

    func update(value: Value) -> Bool {
      guard value != savedValue else { return false }
      savedValue = value
      return true
    }
  }
}

extension View {
  /// Adds a modifier for this view that fires an action when a specific value changes.
  ///
  /// - Parameters:
  ///   - value: The value to check against when determining whether to run the closure.
  ///   - action: A closure to run when the value changes.
  internal func onChange<Value>(
    value: Value,
    perform action: @escaping (Value) -> Void
  ) -> some View where Value: Equatable {
    ChangeObserver(base: self, value: value, action: action)
  }
}
