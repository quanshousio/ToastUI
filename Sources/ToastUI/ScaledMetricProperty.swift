//
//  ScaledMetricProperty.swift
//  ToastUI
//
//  Created by Quan Tran on 7/24/20.
//
//  https://gist.github.com/apptekstudios/e5f282a67beaa85dc725d1d98ec74191

import SwiftUI

#if os(iOS)
@propertyWrapper
internal struct ScaledMetricProperty<Value>: DynamicProperty where Value: BinaryFloatingPoint {
  @Environment(\.horizontalSizeClass) var horizontalSizeClass
  @Environment(\.verticalSizeClass) var verticalSizeClass
  @Environment(\.sizeCategory) var contentSize

  // Creates the scaled metric with an unscaled value and a text style to scale relative to.
  init(wrappedValue: Value, maxValue: Value? = nil, relativeTo textStyle: Font.TextStyle = .body) {
    self.textStyle = textStyle.uiKit
    self.baseValue = wrappedValue
    self.maxValue = maxValue
  }

  let textStyle: UIFont.TextStyle
  let baseValue: Value
  let maxValue: Value?

  var traitCollection: UITraitCollection {
    UITraitCollection(traitsFrom: [
      UITraitCollection(horizontalSizeClass: horizontalSizeClass?.uiKit ?? .unspecified),
      UITraitCollection(verticalSizeClass: verticalSizeClass?.uiKit ?? .unspecified),
      UITraitCollection(preferredContentSizeCategory: contentSize.uiKit)
    ])
  }

  // The value scaled based on the current environment.
  var wrappedValue: Value {
    let scaled = Value(
      UIFontMetrics(forTextStyle: textStyle)
        .scaledValue(for: CGFloat(baseValue), compatibleWith: traitCollection)
    )
    return maxValue.map { min($0, scaled) } ?? scaled
  }
}

private extension UserInterfaceSizeClass {
  var uiKit: UIUserInterfaceSizeClass {
    switch self {
    case .compact: return .compact
    case .regular: return .regular
    @unknown default: return .unspecified
    }
  }
}

private extension ContentSizeCategory {
  var uiKit: UIContentSizeCategory {
    switch self {
    case .accessibilityExtraExtraExtraLarge: return .accessibilityExtraExtraExtraLarge
    case .accessibilityExtraExtraLarge: return .accessibilityExtraExtraLarge
    case .accessibilityExtraLarge: return .accessibilityExtraLarge
    case .accessibilityLarge: return .accessibilityLarge
    case .accessibilityMedium: return .accessibilityMedium
    case .extraExtraExtraLarge: return .extraExtraExtraLarge
    case .extraExtraLarge: return .extraExtraLarge
    case .extraLarge: return .extraLarge
    case .extraSmall: return .extraSmall
    case .large: return .large
    case .medium: return .medium
    case .small: return .small
    @unknown default: return .unspecified
    }
  }
}

private extension Font.TextStyle {
  var uiKit: UIFont.TextStyle {
    switch self {
    case .body: return .body
    case .callout: return .callout
    case .caption: return .caption1
    case .caption2: return .caption2
    case .footnote: return .footnote
    case .headline: return .headline
    case .largeTitle: return .largeTitle
    case .subheadline: return .subheadline
    case .title: return .title1
    case .title2: return .title2
    case .title3: return .title3
    default: return .body
    }
  }
}
#endif

#if os(tvOS)
@propertyWrapper
internal struct ScaledMetricProperty<Value>: DynamicProperty where Value: BinaryFloatingPoint {
  @Environment(\.sizeCategory) var contentSize

  // Creates the scaled metric with an unscaled value and a text style to scale relative to.
  init(wrappedValue: Value, maxValue: Value? = nil, relativeTo textStyle: Font.TextStyle = .body) {
    self.textStyle = textStyle.uiKit
    self.baseValue = wrappedValue
    self.maxValue = maxValue
  }

  let textStyle: UIFont.TextStyle
  let baseValue: Value
  let maxValue: Value?

  var traitCollection: UITraitCollection {
    UITraitCollection(preferredContentSizeCategory: contentSize.uiKit)
  }

  // The value scaled based on the current environment.
  var wrappedValue: Value {
    let scaled = Value(
      UIFontMetrics(forTextStyle: textStyle)
        .scaledValue(for: CGFloat(baseValue), compatibleWith: traitCollection)
    )
    return maxValue.map { min($0, scaled) } ?? scaled
  }
}

private extension ContentSizeCategory {
  var uiKit: UIContentSizeCategory {
    switch self {
    case .accessibilityExtraExtraExtraLarge: return .accessibilityExtraExtraExtraLarge
    case .accessibilityExtraExtraLarge: return .accessibilityExtraExtraLarge
    case .accessibilityExtraLarge: return .accessibilityExtraLarge
    case .accessibilityLarge: return .accessibilityLarge
    case .accessibilityMedium: return .accessibilityMedium
    case .extraExtraExtraLarge: return .extraExtraExtraLarge
    case .extraExtraLarge: return .extraExtraLarge
    case .extraLarge: return .extraLarge
    case .extraSmall: return .extraSmall
    case .large: return .large
    case .medium: return .medium
    case .small: return .small
    @unknown default: return .unspecified
    }
  }
}

private extension Font.TextStyle {
  var uiKit: UIFont.TextStyle {
    switch self {
    case .body: return .body
    case .callout: return .callout
    case .caption: return .caption1
    case .caption2: return .caption2
    case .footnote: return .footnote
    case .headline: return .headline
    case .largeTitle: return .title1
    case .subheadline: return .subheadline
    case .title: return .title1
    case .title2: return .title2
    case .title3: return .title3
    default: return .body
    }
  }
}
#endif
