//
//  ContextProvider.swift
//  fibi
//
//  Created by Kyryl Horbushko on 28.07.2020.
//  Copyright © 2020 Kyryl Horbushko. All rights reserved.
//

import Foundation
import AuthenticationServices
import UIKit

@available(iOS 13.0, *)
public protocol AuthContextProvider where Self: ASWebAuthenticationPresentationContextProviding {

  func clear()
}

@available(iOS 13.0, *)
extension ContextProvider: AuthContextProvider {

  public func clear() {
    // No need to clear context as we're using the app's main window
  }
}

@available(iOS 12.0, *)
final class ContextProvider: NSObject {

  // MARK: - ASWebAuthenticationPresentationContextProviding

  public func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
    // Get the app's key window
    if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
      return window
    }
    // Fallback to first window if no key window
    return UIApplication.shared.windows.first ?? ASPresentationAnchor()
  }
}
