//
//  QueryUsers.swift
//  DropBit
//
//  Created by Mitchell on 5/29/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import Foundation

typealias StringDictResponse = [String: String]

extension Dictionary: ResponseDecodable where Key == String, Value == String {

  static var sampleJSON: String {
    return """
    {
    "498803d5964adce8037d2c53da0c7c7a96ce0e0f99ab99e9905f0dda59fb2e49": "1JbJbAkCXtxpko39nby44hpPenpC1xKGYw"
    }
    """
  }

  static var requiredStringKeys: [KeyPath<StringDictResponse, String>] { return [] }
  static var optionalStringKeys: [WritableKeyPath<StringDictResponse, String?>] { return [] }

}

typealias StringResponse = String
extension String: ResponseDecodable {

  static var sampleJSON: String {
    return "Success"
  }

  static var requiredStringKeys: [KeyPath<String, String>] { return [] }
  static var optionalStringKeys: [WritableKeyPath<String, String?>] { return [] }

}
