//
//  AdvancedExamples.swift
//  ToastUISample
//
//  Created by Quan Tran on 7/22/20.
//

import SwiftUI
import ToastUI

struct PresentSuccessToastAfterCompletedExample: View {
  @State private var presentingProgressToast = false
  @State private var presentingSuccessToast = false
  @State private var value = 0.0

  var body: some View {
    CustomButton("Tap me") {
      presentingProgressToast = true

      Timer.scheduledTimer(
        withTimeInterval: Double.random(in: 0.3 ... 0.7),
        repeats: true
      ) { timer in
        if value < 1 {
          value += Double.random(in: 0.1 ... 0.25)
        } else {
          timer.invalidate()
          DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            presentingProgressToast = false
          }
        }
      }
    }
    .toast(isPresented: $presentingProgressToast) {
      presentingSuccessToast = true
      value = 0
    } content: {
      ToastView("Loading...")
        .toastViewStyle(.determinate(value: $value))
    }
    .toast(isPresented: $presentingSuccessToast, dismissAfter: 2.0) {
      ToastView("Success")
        .toastViewStyle(.success)
    }
  }
}

struct CustomToastViewStyle: ToastViewStyle {
  @Binding var brightness: Double

  func makeBody(configuration: Configuration) -> some View {
    CustomToastView(configuration: configuration, brightness: $brightness)
  }

  struct CustomToastView: View {
    let configuration: Configuration
    @Binding var brightness: Double

    var body: some View {
      VStack {
        // don't use the background of the ToastView
        // configuration.background

        configuration.label
          .fixedSize()

        configuration.content
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 9.0)
          .foregroundColor(.init(.init(white: brightness, alpha: 1.0)))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      )
      .frame(idealWidth: 250, maxWidth: .infinity)
      .fixedSize()
    }
  }
}

extension ToastViewStyle where Self == CustomToastViewStyle {
  static func custom(brightness: Binding<Double>) -> Self {
    .init(brightness: brightness)
  }
}

struct CustomToastUsingToastViewStyleExample: View {
  @State private var presentingToast = false
  @State private var brightness = 0.5

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast) {
      ToastView("A toast with custom ToastViewStyle" /* label */ ) {
        // content
        VStack {
          HStack {
            Text("Brightness")

            #if os(iOS) || os(macOS)
            Slider(value: $brightness, in: 0 ... 1)
            #elseif os(tvOS)
            Button {
              if brightness < 1 {
                brightness += 0.1
              }
            } label: {
              Image(systemName: "plus.circle.fill")
            }
            Button {
              if brightness > 0 {
                brightness -= 0.1
              }
            } label: {
              Image(systemName: "minus.circle.fill")
            }
            #endif
          }

          CustomButton("OK") {
            presentingToast = false
          }
        }
      } background: {
        // background will be ignored by CustomToastViewStyle
      }
      .toastViewStyle(.custom(brightness: $brightness)) // apply CustomToastViewStyle
      .padding()
    }
  }
}

struct CustomToastWithoutToastViewExample: View {
  @State private var presentingToast = false

  var body: some View {
    CustomButton("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast, dismissAfter: 2.0) {
      print("Toast dismissed")
    } content: {
      VStack {
        Spacer()
        Text("You can put any SwiftUI views here without using ToastView")
          .bold()
          .multilineTextAlignment(.center)
          .foregroundColor(.white)
          .padding()
          .frame(maxWidth: .infinity)
          .background(Color.accentColor)
          .cornerRadius(8.0)
          .shadow(radius: 4.0)
      }
      .padding()
    }
  }
}

struct CustomToastUsingItemExample: View {
  enum Toast: String, CaseIterable {
    case first = "First"
    case second = "Second"
  }

  struct ToastItem: Identifiable, Equatable {
    let id = UUID()

    var content: AnyView

    init<Content: View>(_ content: Content) {
      self.content = AnyView(content)
    }

    static func == (lhs: ToastItem, rhs: ToastItem) -> Bool {
      lhs.id == rhs.id
    }
  }

  @State private var selectedToast: Toast = .first
  @State private var toastItem: ToastItem?
  @State private var username = ""
  @State private var email = ""

  var body: some View {
    VStack {
      Picker("Toast Item", selection: $selectedToast) {
        ForEach(Toast.allCases, id: \.rawValue) { toast in
          Text(toast.rawValue)
            .tag(toast)
        }
      }
      .pickerStyle(.segmented)
      .fixedSize()
      .padding()

      CustomButton("Tap me") {
        switch selectedToast {
        case .first:
          toastItem = ToastItem(firstToastView)
        case .second:
          toastItem = ToastItem(secondToastView)
        }
      }
      .toast(item: $toastItem) {
        print("Toast dismissed")
      } content: { item in
        ToastView {
          item.content
            .frame(idealWidth: 250, maxWidth: .infinity)
            .fixedSize()
        }
        .padding()
      }
    }
  }

  private var firstToastView: some View {
    VStack {
      Text("Hello from ToastUI")

      CustomButton("OK", maxWidth: .infinity) {
        toastItem = nil
      }
    }
  }

  private var secondToastView: some View {
    VStack {
      Text("Create a new account")
        .bold()

      #if os(iOS)
      TextField("Username", text: $username)
        .frame(height: 44)
        .textFieldStyle(.plain)
        .padding([.leading, .trailing], 12)
        .background(
          RoundedRectangle(cornerRadius: 8.0)
            .stroke(Color(.systemGray3))
            .foregroundColor(.clear)
        )
      TextField("Email", text: $email)
        .frame(height: 44)
        .textFieldStyle(.plain)
        .padding([.leading, .trailing], 12)
        .background(
          RoundedRectangle(cornerRadius: 8.0)
            .stroke(Color(.systemGray3))
            .foregroundColor(.clear)
        )
      #elseif os(tvOS) || os(macOS)
      TextField("Username", text: $username)
      TextField("Email", text: $email)
      #endif

      Spacer()
        .frame(height: 16.0)

      HStack {
        CustomButton("Cancel", maxWidth: .infinity) {
          toastItem = nil
        }
        CustomButton("OK", maxWidth: .infinity) {
          toastItem = nil
          print("username: \(username), email: \(email)")
          username = ""
          email = ""
        }
      }
    }
  }
}
