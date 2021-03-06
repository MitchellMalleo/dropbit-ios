//
//  LightningActionButton.swift
//  DropBit
//
//  Created by Mitchell Malleo on 8/12/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import Foundation
import UIKit

class LightningActionButton: PrimaryActionButton {

  override func awakeFromNib() {
    super.awakeFromNib()
    style = .lightning(rounded: true)
    titleLabel?.font = .medium(18)
  }
}
