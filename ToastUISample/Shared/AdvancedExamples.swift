//
//  AdvancedExamples.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/22/20.
//

import SwiftUI
import ToastUI

// swiftlint:disable identifier_name
struct ToastItem: Identifiable, Equatable {
  let id = UUID()
  var title: String
  var content: AnyView

  static func == (lhs: ToastItem, rhs: ToastItem) -> Bool {
    lhs.id == rhs.id
  }
}

struct CustomizedToastWithoutToastViewExample: View {
  @State private var presentingToast: Bool = false
  @State private var blurBackground: Bool = true

  var body: some View {
    VStack {
      Toggle("Blur the background", isOn: $blurBackground)

      if !blurBackground {
        CustomButton("Tap me") {
          self.presentingToast = true
        }
        .toast(isPresented: $presentingToast, dismissAfter: 2.0, onDismiss: {
          print("toast dismissed")
        }) {
          VStack {
            Spacer()
            Text("You can put any SwiftUI views here without the need of ToastView")
              .bold()
              .foregroundColor(.white)
              .padding()
              .background(Color.green)
              .cornerRadius(8.0)
              .shadow(radius: 4)
              .padding()
          }
        }
      } else {
        CustomButton("Tap me") {
          self.presentingToast = true
        }
        .toast(isPresented: $presentingToast, dismissAfter: 2.0, onDismiss: {
          print("Toast dismissed")
        }) {
          VStack {
            Spacer()
            Text(
              """
              You can put any SwiftUI views here here without the need of ToastView, \
              and blur the background using cocoaBlur() modifier
              """
            )
            .bold()
            .foregroundColor(.white)
            .padding()
            .background(Color.green)
            .cornerRadius(8.0)
            .shadow(radius: 4)
            .padding()
          }
          .cocoaBlur()
        }
      }
    }
    .padding()
  }
}

struct CustomizedToastUsingItemExample: View {
  private var toastItems = ["First Toast Item", "Second Toast Item"]
  @State private var selectedToast = 0

  @State private var toastItem: ToastItem?
  @State private var username: String = ""
  @State private var email: String = ""

  var body: some View {
    VStack {
      Picker("", selection: $selectedToast) {
        ForEach(0 ..< toastItems.count) {
          Text(self.toastItems[$0])
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      .padding()

      CustomButton("Tap me") {
        if self.selectedToast == 0 {
          self.toastItem = ToastItem(
            title: "Alert",
            content: AnyView(self.firstToastView)
          )
        } else {
          self.toastItem = ToastItem(
            title: "",
            content: AnyView(self.secondToastView)
          )
        }
      }
      .toast(item: $toastItem, onDismiss: {
        print("Toast dismissed")
      }) { item in
        ToastView(item.title) {
          item.content
        }
      }
    }
    .frame(maxWidth: 300)
  }

  private var firstToastView: some View {
    VStack {
      Text("Hello from ToastUI")
        .padding(.bottom)
        .multilineTextAlignment(.center)

      CustomButton("OK", width: .infinity) {
        self.toastItem = nil
      }
    }
    .frame(maxWidth: 300)
  }

  private var secondToastView: some View {
    VStack {
      Text("Create a new account").bold()
      #if os(iOS)
      TextField("Username", text: $username)
        .frame(height: 44)
        .textFieldStyle(PlainTextFieldStyle())
        .padding([.leading, .trailing], 12)
        .background(RoundedRectangle(cornerRadius: 8.0).stroke(Color(.systemGray3)).foregroundColor(.clear))
      TextField("Email", text: $email)
        .frame(height: 44)
        .textFieldStyle(PlainTextFieldStyle())
        .padding([.leading, .trailing], 12)
        .background(RoundedRectangle(cornerRadius: 8.0).stroke(Color(.systemGray3)).foregroundColor(.clear))
      #endif

      #if os(tvOS)
      TextField("Username", text: $username)
        .textFieldStyle(PlainTextFieldStyle())
        .padding()
      TextField("Email", text: $email)
        .textFieldStyle(PlainTextFieldStyle())
        .padding()
      #endif

      Spacer().frame(height: 16.0)

      HStack {
        CustomButton("Cancel", width: .infinity) {
          self.toastItem = nil
        }
        CustomButton("OK", width: .infinity) {
          print("username: \(self.username), email: \(self.email)")
          self.toastItem = nil
          self.username = ""
          self.email = ""
        }
      }
    }
    .frame(maxWidth: 300)
  }
}

struct ShowSuccessToastAfterCompletedExample: View {
  @State private var presentingProgressView: Bool = false
  @State private var presentingSuccessView: Bool = false
  @State private var value: Double = 0.0

  var body: some View {
    CustomButton("Tap me") {
      self.presentingProgressView = true

      Timer.scheduledTimer(withTimeInterval: Double.random(in: 0.3 ... 0.7), repeats: true) { timer in
        if self.value >= 100 {
          timer.invalidate()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.presentingProgressView = false
          }
        } else {
          self.value += Double.random(in: 10 ... 25)
        }
      }
    }
    .toast(isPresented: $presentingProgressView, onDismiss: {
      self.presentingSuccessView = true
      self.value = 0
    }) {
      ToastView("Loading...")
        .toastViewStyle(DefiniteProgressToastViewStyle(value: self.$value, total: .constant(100)))
    }
    .toast(isPresented: $presentingSuccessView, dismissAfter: 2.0) {
      ToastView("Success")
        .toastViewStyle(SuccessToastViewStyle())
    }
  }
}
