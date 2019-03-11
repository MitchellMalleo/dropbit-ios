//
//  MenuButton.swift
//  DropBit
//
//  Created by Ben Winters on 10/24/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import UIKit

class BalanceContainerLeftButton: UIButton, Badgeable {

  var badgeDisplayCriteria: BadgeInfo = [:]

  var badgeOffset: ViewOffset {
    return ViewOffset(dx: -13, dy: 16)
  }

}
