# About ToastUI

Details about ToastUI and its functionalities.

### Presenting a toast

ToastUI supports presenting any SwiftUI views from anywhere. You just need to add the `toast()` view modifier and provide your views, much like using `alert()` or `sheet()`.

```swift
.toast(isPresented: $presentingToast) {
  // your view here
}
```

There are two types of `toast()` view modifiers for different usage:

Function | Description
--- | ---
``ToastView/toast(isPresented:dismissAfter:onDismiss:content:)`` | Presents a toast when the given binding to a Boolean value is true.
``ToastView/toast(item:dismissAfter:onDismiss:content:)`` | Presents a toast when using the given item as a data source for the toast’s content.

### ToastView

``ToastView`` is visually represented as a rounded rectangle shape that contains your provided views.

![Default Toast View](toastview-default.png)

```swift
.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
  ToastView("Hello from ToastUI")
}
```

``ToastView`` consists of three different views: `Background`, `Label` and `Content`. All three views are optional and can be empty.

```swift
╭─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─╮
│ <Background>          │
│                       │
│     ╭─ ─ ─ ─ ─ ─╮     │
│     │ <Content> │     │
│     │           │     │
│     │           │     │
│     │  <Label>  │     │
│     ╰─ ─ ─ ─ ─ ─╯     │
╰─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─╯

ToastView {
  <Content>
} label: {
  <Label>
} background: {
  <Background>
}
```

![Toast View initialized with all three views](toastview-all.png)

```swift
.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
  ToastView {
    Text("Content")
  } label: {
    Text("Label")
  } background: {
    ZStack {
      Color.accentColor
        .opacity(0.5)
        .ignoresSafeArea()

      VStack {
        Text("Background")
        Spacer()
      }
    }
  }
}
```

By default, `ToastView` resolves to a `DefaultToastView` internally. `DefaultToastView` has a fixed-size, center-aligned label with content and background provided when initializing.

```swift
struct DefaultToastView<Background, Label, Content>: View
where Background: View, Label: View, Content: View {
  private var background: Background
  private var label: Label
  private var content: Content
  
  @ScaledMetric private var paddingSize: Double = 16
  @ScaledMetric private var cornerSize: Double = 9

  /* initializer omitted */

  var body: some View {
    VStack(spacing: 8) {
      content

      label
        .fixedSize()
        .multilineTextAlignment(.center)
    }
    .padding(paddingSize)
    .background(Color.background)
    .cornerRadius(cornerSize)
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .background(background)
  }
}
```

### Styling

ToastUI includes various built-in ``ToastViewStyle`` for common purposes such as showing a loading indicator or a success alert. You have to use `ToastView` and set the style by using ``ToastView/toastViewStyle(_:)`` modifier. All built-in styles have native support for dynamic types for accessibility.

Styles | Shorthand | Description
--- | --- | ---
``DefaultToastViewStyle`` | ``ToastViewStyle/default`` | An empty toast if user does not provide anything. `ToastView` uses this style by default.
``IndeterminateProgressToastViewStyle`` | ``ToastViewStyle/indeterminate`` | An indefinite circular progress indicator.
``DeterminateProgressToastViewStyle`` | ``ToastViewStyle/determinate(value:total:)`` | A definite circular progress indicator from `value` to `total`.
``IconToastViewStyle`` | ``ToastViewStyle/icon(content:)`` | An icon toast.
``SuccessToastViewStyle`` | ``ToastViewStyle/success`` | A success toast.
``FailureToastViewStyle`` | ``ToastViewStyle/failure`` | A failure toast.
``WarningToastViewStyle`` | ``ToastViewStyle/warning`` | A warning toast.
``InformationToastViewStyle`` | ``ToastViewStyle/information`` | An information toast.

![Indeterminate Toast View](indeterminate-style.png)

```swift
.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
  ToastView("Loading...")
    .toastViewStyle(.indefinite)
}
```

![Icon Toast View](icon-style.png)

```swift
.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
  ToastView("Saved")
    .toastViewStyle(.icon {
      Image(systemName: "arrow.down.doc.fill")
        .foregroundColor(.green)
    })
}
```

You can also create a custom style by conforming to the `ToastViewStyle` protocol.

![Custom Toast View Style](custom-style.png)

```swift
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
        configuration.label
        configuration.content
      }
      .padding()
      .background(
        RoundedRectangle(cornerRadius: 9.0)
          .foregroundColor(.init(.init(white: brightness, alpha: 1.0)))
          .frame(maxWidth: .infinity, maxHeight: .infinity)
      )
      .frame(idealWidth: 250, maxWidth: .infinity)
    }
  }
}

extension ToastViewStyle where Self == CustomToastViewStyle {
  static func custom(brightness: Binding<Double>) -> Self {
    .init(brightness: brightness)
  }
}

struct ContentView: View {
  @State private var presentingToast: Bool = false
  @State private var brightness: Double = 0.5

  var body: some View {
    Button("Tap me") {
      presentingToast = true
    }
    .toast(isPresented: $presentingToast) {
      ToastView("A toast with custom ToastViewStyle") {
        VStack {
          HStack {
            Text("Brightness")
            Slider(value: $brightness, in: 0 ... 1)
          }

          Divider()

          Button("OK") {
            presentingToast = false
          }
        }
      }
      .toastViewStyle(.custom(brightness: $brightness))
      .padding()
    }
  }
}
```

### Dimmed background

ToastUI shows a dimmed background when presenting a toast by default. You can disable it by using ``ToastView/toastDimmedBackground(_:)`` modifier.

![Toast Dimmed Background](dimmed-background.png)

```swift
.toast(isPresented: $presentingToast, dismissAfter: 2.0) {
  ToastView("Information")
    .toastViewStyle(.information)
}
.toastDimmedBackground(false)
```
