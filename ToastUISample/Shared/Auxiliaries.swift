//
//  Auxiliaries.swift
//  ToastUISample
//
//  Created by Quan Tran on 11/14/20.
//

import SwiftUI

// swiftlint:disable identifier_name
struct ToastItem: Identifiable, Equatable {
  let id = UUID()
  var content: AnyView

  static func == (lhs: ToastItem, rhs: ToastItem) -> Bool {
    lhs.id == rhs.id
  }
}

struct ExampleItem<Destination>: View where Destination: View {
  var destination: Destination
  var description: String

  var body: some View {
    NavigationLink(destination: destination) {
      Text(description)
    }
  }
}

struct CustomButton: View {
  var label: String
  var width: CGFloat
  var height: CGFloat
  var action: () -> Void

  init(
    _ label: String,
    width: CGFloat = 100,
    height: CGFloat = 12,
    _ action: @escaping () -> Void
  ) {
    self.label = label
    self.width = width
    self.height = height
    self.action = action
  }

  @ViewBuilder var body: some View {
    #if os(iOS)
    Button(action: action) {
      Text(label)
        .bold()
        .foregroundColor(.white)
        .frame(maxWidth: width, maxHeight: height)
        .padding()
        .background(Color.accentColor)
        .cornerRadius(8.0)
    }
    #endif

    #if os(tvOS)
    Button(action: action) {
      Text(label)
        .bold()
        .foregroundColor(.white)
    }
    #endif

    #if os(macOS)
    Button(action: action) {
      Text(label).bold()
    }
    .frame(maxWidth: width, maxHeight: height)
    #endif
  }
}

struct ToastUIImage: View {
  var width: CGFloat

  var body: some View {
    Image("ToastUI")
      .resizable()
      .frame(width: width, height: width / 1.873)
  }
}
