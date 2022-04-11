//
//  Auxiliaries.swift
//  ToastUISample
//
//  Created by Quan Tran on 11/14/20.
//

import SwiftUI

struct ExampleItem<Destination>: View where Destination: View {
  var destination: Destination
  var description: String

  var body: some View {
    NavigationLink {
      destination
      #if !os(macOS)
      .navigationBarTitleDisplayMode(.inline)
      #endif
    } label: {
      Text(description)
    }
  }
}

struct CustomButton: View {
  var text: String
  var maxWidth: Double
  var maxHeight: Double
  var action: () -> Void

  init(
    _ text: String,
    maxWidth: Double = 100,
    maxHeight: Double = 10,
    _ action: @escaping () -> Void
  ) {
    self.text = text
    self.maxWidth = maxWidth
    self.maxHeight = maxHeight
    self.action = action
  }

  @ViewBuilder var body: some View {
    Button(action: action) {
      Text(text)
      #if os(iOS)
        .bold()
        .foregroundColor(.white)
        .frame(maxWidth: maxWidth, maxHeight: maxHeight)
        .padding()
        .background(Color.accentColor)
        .cornerRadius(12.0)
      #endif
    }
  }
}

struct ToastUIImage: View {
  var width: Double

  var body: some View {
    Image("ToastUI")
      .resizable()
      .frame(width: width, height: width / 1.873)
  }
}
