//
//  AuthHandlerType.swift
//  fibi
//
//  Created by Kyryl Horbushko on 28.07.2020.
//  Copyright © 2020 Kyryl Horbushko. All rights reserved.
//

import Foundation
import SafariServices
import AuthenticationServices
import UIKit

protocol AuthHandlerType: class {

  var session: NSObject? { get set }

  var contextProvider: NSObject? { get set }

  func performAuth(url: URL,
                   callbackScheme: String,
                   completion: @escaping FitBitAuth.CompletionHandler)
}

extension AuthHandlerType {

  func performAuth(url: URL,
                   callbackScheme: String,
                   completion: @escaping FitBitAuth.CompletionHandler) {
    if #available(iOS 12, *) {
      let session = ASWebAuthenticationSession(url: url, callbackURLScheme: callbackScheme) { [weak self] url, error in
        defer {
          // Clean up
          self?.session = nil
          if #available(iOS 13, *) {
            (self?.contextProvider as? AuthContextProvider)?.clear()
          }
        }
        
        if let error = error as? ASWebAuthenticationSessionError {
          switch error.code {
          case .canceledLogin:
            // Handle cancellation explicitly
            completion(nil, NSError(domain: "com.fitbit.auth",
                                  code: error.code.rawValue,
                                  userInfo: [NSLocalizedDescriptionKey: "User cancelled authentication"]))
          default:
            completion(url, error)
          }
        } else {
          completion(url, error)
        }
      }

      self.session = session

      if #available(iOS 13, *) {
        // Only create a new context provider if we don't have one
        if self.contextProvider == nil {
          self.contextProvider = ContextProvider()
        }
        session.presentationContextProvider = self.contextProvider as? ASWebAuthenticationPresentationContextProviding
        session.prefersEphemeralWebBrowserSession = true
      }

      session.start()
    } else {
      let session = SFAuthenticationSession(url: url, callbackURLScheme: callbackScheme) { [weak self] url, error in
        defer {
          self?.session = nil
        }
        completion(url, error)
      }

      self.session = session
      session.start()
    }
  }
}
