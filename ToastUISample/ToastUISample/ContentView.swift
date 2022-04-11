//
//  ContentView.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/16/20.
//

import SwiftUI
import ToastUI

struct ContentView: View {
  var body: some View {
    NavigationView {
      VStack {
        List {
          Section {
            ExampleItem(
              destination: BuiltInToastViewStyleExample(),
              description: "ToastView with different built-in styles"
            )
            ExampleItem(
              destination: CustomAlertExample(),
              description: "Custom alert"
            )
            ExampleItem(
              destination: CustomBackgroundExample(),
              description: "Custom background"
            )
          } header: {
            Text("Basic examples")
          }

          Section {
            ExampleItem(
              destination: PresentSuccessToastAfterCompletedExample(),
              description: "Present success toast after definite progress indicator completed"
            )
            ExampleItem(
              destination: CustomToastUsingToastViewStyleExample(),
              description: "Custom toast using custom ToastViewStyle"
            )
            ExampleItem(
              destination: CustomToastWithoutToastViewExample(),
              description: "Custom toast using normal SwiftUI views"
            )
            ExampleItem(
              destination: CustomToastUsingItemExample(),
              description: "Different toast using identifiable items"
            )
          } header: {
            Text("Advanced Examples")
          }
        }
      }
      .navigationTitle("ToastUI")
      .toolbar {
        ToastUIImage(width: 52.45)
      }
      #if os(macOS)
      .listStyle(.inset)
      #endif
    }
  }
}
