//
//  BasicExamples.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/22/20.
//

import SwiftUI
import ToastUI

struct IndefiniteProgressIndicatorExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      ToastView("Loading...")
        .toastViewStyle(IndefiniteProgressToastViewStyle())
    }
  }
}

struct DefiniteProgressIndicatorExample: View {
  @State private var presentingToast: Bool = false
  @State private var value: Double = 0.0

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true

      Timer
        .scheduledTimer(withTimeInterval: Double.random(in: 0.3 ... 0.7), repeats: true) { timer in
          if value >= 100 {
            timer.invalidate()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
              presentingToast = false
              value = 0
            }
          } else {
            value += Double.random(in: 10 ... 25)
          }
        }
    }
    .toast(isPresented: $presentingToast) {
      value = 0
    } content: {
      ToastView("Loading...")
        .toastViewStyle(DefiniteProgressToastViewStyle(value: $value, total: .constant(100)))
    }
  }
}

struct SuccessToastExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      ToastView("Success")
        .toastViewStyle(SuccessToastViewStyle())
    }
  }
}

struct ErrorToastExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      ToastView("Error")
        .toastViewStyle(ErrorToastViewStyle())
    }
  }
}

struct WarningToastExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      ToastView("Warning")
        .toastViewStyle(WarningToastViewStyle())
    }
  }
}

struct InformationToastExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      ToastView("Information")
        .toastViewStyle(InfoToastViewStyle())
    }
  }
}

struct ToastViewWithCustomBackgroundExample: View {
  @State private var presentingToast: Bool = false
  @State private var withoutBackground: Bool = false

  private let gradient = AngularGradient(
    gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
    center: .center,
    startAngle: .zero,
    endAngle: .degrees(360)
  )

  var body: some View {
    VStack {
      Toggle("Without the background", isOn: $withoutBackground)

      CustomButton("Tap me") {
        presentingToast = true
      }
      .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
        ToastView {
          ToastUIImage(width: 67.43)
        } label: {
          Text("Hello from ToastUI")
        } background: {
          if !withoutBackground {
            Rectangle()
              .fill(gradient)
              .opacity(0.3)
          } else {
            // EmptyView() or blank is fine
          }
        }
      }
    }
    .padding()
  }
}

struct CustomizedAlertExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast) {
      ToastView {
        VStack {
          Text("You can create a customized alert with ToastView")
            .fixedSize()
            .padding(.bottom)
            .multilineTextAlignment(.center)

          CustomButton("OK", width: .infinity) {
            presentingToast = false
          }
        }
        .frame(width: 400)
      }
    }
  }
}
