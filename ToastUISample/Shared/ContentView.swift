//
//  ContentView.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/16/20.
//

import SwiftUI
import ToastUI

struct ContentView: View {
  @ViewBuilder var content: some View {
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
    }

    Section(header: Text("Advanced examples")) {
      ExampleItem(
        destination: CustomizedToastUsingToastViewStyleExample(),
        description: "Customized toast using custom ToastViewStyle"
      )
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
    .navigationViewStyle(DoubleColumnNavigationViewStyle())
  }

  #if os(iOS) || os(tvOS)
  var body: some View {
    NavigationView {
      Form {
        content
      }
    }
    .navigationBarTitle("ToastUI")
    .navigationBarItems(trailing: ToastUIImage(width: 52.45))
  }
  #endif

  #if os(macOS)
  var body: some View {
    NavigationView {
      List {
        content
      }
    }
    .navigationTitle("ToastUI")
  }
  #endif
}
