// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {

  internal enum CharacterDetail {
    /// Description:
    internal static let descriptionHeader = L10n.tr("Localizable", "CharacterDetail.DescriptionHeader")
    /// most expensive magazine!
    internal static let mostExpensiveMagazine = L10n.tr("Localizable", "CharacterDetail.MostExpensiveMagazine")
    /// Name:
    internal static let nameHeader = L10n.tr("Localizable", "CharacterDetail.NameHeader")
  }

  internal enum CharacterList {
    internal enum NavigationBar {
      /// Marvel Heroes
      internal static let title = L10n.tr("Localizable", "CharacterList.NavigationBar.Title")
    }
  }

  internal enum ErrorAlertController {
    /// Please, try again later
    internal static let description = L10n.tr("Localizable", "ErrorAlertController.Description")
    /// Ok
    internal static let okAction = L10n.tr("Localizable", "ErrorAlertController.OkAction")
    /// Error
    internal static let title = L10n.tr("Localizable", "ErrorAlertController.Title")
  }

  internal enum NoComicAlertController {
    /// No comic found!
    internal static let description = L10n.tr("Localizable", "NoComicAlertController.Description")
    /// Ok
    internal static let okAction = L10n.tr("Localizable", "NoComicAlertController.OkAction")
    /// Sorry
    internal static let title = L10n.tr("Localizable", "NoComicAlertController.Title")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
