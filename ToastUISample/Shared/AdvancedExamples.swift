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
  var content: AnyView

  static func == (lhs: ToastItem, rhs: ToastItem) -> Bool {
    lhs.id == rhs.id
  }
}

struct CustomizedToastWithoutToastViewExample: View {
  @State private var presentingToast: Bool = false
  @State private var blurBackground: Bool = true

  struct ContentView: View {
    var text: String

    var body: some View {
      VStack {
        Spacer()
        Text(text)
          .bold()
          .foregroundColor(.white)
          .padding()
          .background(Color.green)
          .cornerRadius(8.0)
          .shadow(radius: 4)
          .padding()
      }
    }
  }

  var body: some View {
    VStack {
      Toggle("Blur the background", isOn: $blurBackground)

      CustomButton("Tap me") {
        presentingToast = true
      }
      .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
        print("Toast dismissed")
      } content: {
        if blurBackground {
          ContentView(
            text:
            """
            You can put any SwiftUI views here without using ToastView, \
            and blur the background using cocoaBlur() modifier
            """
          )
          .cocoaBlur()
        } else {
          ContentView(text: "You can put any SwiftUI views here without using ToastView")
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
          Text(toastItems[$0])
        }
      }
      .pickerStyle(SegmentedPickerStyle())
      .padding()

      CustomButton("Tap me") {
        if selectedToast == 0 {
          toastItem = ToastItem(content: AnyView(firstToastView))
        } else {
          toastItem = ToastItem(content: AnyView(secondToastView))
        }
      }
      .toast(item: $toastItem) {
        print("Toast dismissed")
      } content: { item in
        ToastView {
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
        toastItem = nil
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
        .background(
          RoundedRectangle(cornerRadius: 8.0).stroke(Color(.systemGray3))
            .foregroundColor(.clear)
        )
      TextField("Email", text: $email)
        .frame(height: 44)
        .textFieldStyle(PlainTextFieldStyle())
        .padding([.leading, .trailing], 12)
        .background(
          RoundedRectangle(cornerRadius: 8.0).stroke(Color(.systemGray3))
            .foregroundColor(.clear)
        )
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
          toastItem = nil
        }
        CustomButton("OK", width: .infinity) {
          print("username: \(username), email: \(email)")
          toastItem = nil
          username = ""
          email = ""
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
      presentingProgressView = true

      Timer
        .scheduledTimer(withTimeInterval: Double.random(in: 0.3 ... 0.7), repeats: true) { timer in
          if value >= 100 {
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              presentingProgressView = false
            }
          } else {
            value += Double.random(in: 10 ... 25)
          }
        }
    }
    .toast(isPresented: $presentingProgressView) {
      presentingSuccessView = true
      value = 0
    } content: {
      ToastView("Loading...")
        .toastViewStyle(DefiniteProgressToastViewStyle(value: $value, total: .constant(100)))
    }
    .toast(isPresented: $presentingSuccessView, dismissAfter: 2.0) {
      ToastView("Success")
        .toastViewStyle(SuccessToastViewStyle())
    }
  }
}
