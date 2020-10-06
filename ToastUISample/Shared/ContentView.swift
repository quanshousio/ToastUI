//
//  ContentView.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/16/20.
//

import SwiftUI
import ToastUI

struct ExampleItem<Destination>: View where Destination: View {
  var destination: Destination
  var description: String

  var body: some View {
    NavigationLink(destination: destination) {
      VStack(alignment: .leading) {
        Text(description).lineLimit(20)
      }
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
  }
}

struct ContentView: View {
  var body: some View {
    NavigationView {
      Form {
        Section(header: Text("Basic examples")) {
          ExampleItem(
            destination: IndefiniteProgressIndicatorExample(),
            description: "Indefinite progress indicator"
          )
          ExampleItem(
            destination: DefiniteProgressIndicatorExample(),
            description: "Definite progress indicator"
          )
          ExampleItem(
            destination: SuccessToastExample(),
            description: "Success toast"
          )
          ExampleItem(
            destination: ErrorToastExample(),
            description: "Error toast"
          )
          ExampleItem(
            destination: WarningToastExample(),
            description: "Warning toast"
          )
          ExampleItem(
            destination: InformationToastExample(),
            description: "Information toast"
          )
          ExampleItem(
            destination: CustomizedAlertExample(),
            description: "Customized alert"
          )
          ExampleItem(
            destination: ToastViewWithCustomBackgroundExample(),
            description: "ToastView with custom background"
          )
          ExampleItem(
            destination: CocoaBlurModifierExample(),
            description: "cocoaBlur() view modifier"
          )
        }

        Section(header: Text("Advanced examples")) {
          ExampleItem(
            destination: CustomizedToastWithoutToastViewExample(),
            description: "Customized toast without using ToastView"
          )
          ExampleItem(
            destination: CustomizedToastUsingItemExample(),
            description: "Customized toast using different identifiable items"
          )
          ExampleItem(
            destination: ShowSuccessToastAfterCompletedExample(),
            description: "Show success toast after the definite progress indicator has completed"
          )
        }
      }
      .navigationBarTitle("ToastUI")
    }
  }
}
