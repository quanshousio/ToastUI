//
//  BasicExamples.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/22/20.
//

import SwiftUI
import ToastUI

struct BuiltInToastViewStyleExample: View {
  enum Style: String, CaseIterable {
    case indeterminate = "Indeterminate progress indicator toast"
    case determinate = "Determinate progress indicator toast"
    case icon = "Icon toast"
    case success = "Success toast"
    case failure = "Failure toast"
    case warning = "Warning toast"
    case information = "Information toast"
  }

  @State private var style: Style = .indeterminate

  @State private var presentingToast: Bool = false
  @State private var dimmedBackground: Bool = true

  @State private var value: Double = 0 // for .definite style

  var body: some View {
    VStack {
      Picker("Style", selection: $style) {
        ForEach(Style.allCases, id: \.rawValue) { style in
          Text(style.rawValue)
            .tag(style)
        }
      }
      #if os(iOS)
        .pickerStyle(.wheel)
      #elseif os(tvOS)
        .pickerStyle(.segmented)
      #elseif os(macOS)
        .pickerStyle(.radioGroup)
      #endif

      Toggle("Dimmed background", isOn: $dimmedBackground)

      CustomButton("Tap me") {
        presentingToast = true

        if style == .determinate {
          Timer.scheduledTimer(
            withTimeInterval: Double.random(in: 0.3 ... 0.7),
            repeats: true
          ) { timer in
            if value < 1 {
              value += Double.random(in: 0.1 ... 0.25)
            } else {
              timer.invalidate()
              DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                presentingToast = false
              }
            }
          }
        } else {
          DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            presentingToast = false
          }
        }
      }
      .toast(isPresented: $presentingToast) {
        if style == .determinate {
          value = 0
        }
      } content: {
        switch style {
        case .indeterminate:
          ToastView("Loading...")
            .toastViewStyle(.indeterminate)
        case .determinate:
          ToastView("Loading...")
            .toastViewStyle(.determinate(value: $value))
        case .icon:
          ToastView("Saved")
            .toastViewStyle(.icon {
              Image(systemName: "arrow.down.doc.fill")
                .foregroundColor(.green)
            })
        case .success:
          ToastView("Success")
            .toastViewStyle(.success)
        case .failure:
          ToastView("Failure")
            .toastViewStyle(.failure)
        case .warning:
          ToastView("Warning")
            .toastViewStyle(.warning)
        case .information:
          ToastView("Information")
            .toastViewStyle(.information)
        }
      }
      .toastDimmedBackground(dimmedBackground)
    }
    .padding()
  }
}

struct CustomAlertExample: View {
  @State private var presentingToast: Bool = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast) {
      ToastView {
        VStack {
          Text("You can create a custom alert with ToastView")
            .padding(.bottom)
            .multilineTextAlignment(.center)

          CustomButton("OK", maxWidth: .infinity) {
            presentingToast = false
          }
        }
        .frame(idealWidth: 250, maxWidth: .infinity)
      }
      .padding()
    }
  }
}

struct CustomBackgroundExample: View {
  @State private var presentingToast: Bool = false
  @State private var customBackground: Bool = false

  private let gradient = AngularGradient(
    gradient: Gradient(colors: [.red, .yellow, .green, .blue, .purple, .red]),
    center: .center,
    startAngle: .zero,
    endAngle: .degrees(360)
  )

  var body: some View {
    VStack {
      Toggle("Custom background", isOn: $customBackground)

      CustomButton("Tap me") {
        presentingToast = true
      }
      .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
        ToastView {
          ToastUIImage(width: 67.43)
        } label: {
          Text("Hello from ToastUI")
        } background: {
          if customBackground {
            Rectangle()
              .fill(gradient)
              .opacity(0.3)
              .ignoresSafeArea()
          }
        }
      }
    }
    .padding()
  }
}
