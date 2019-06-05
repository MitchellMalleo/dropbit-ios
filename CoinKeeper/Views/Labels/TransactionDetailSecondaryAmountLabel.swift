//
//  TransactionDetailSecondaryAmountLabel.swift
//  CoinKeeper
//
//  Created by Ben Winters on 4/12/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import UIKit

class TransactionDetailSecondaryAmountLabel: UILabel {
  override func awakeFromNib() {
    super.awakeFromNib()
    font = .regular(15)
    textColor = .grayText
    isHidden = false
    numberOfLines = 1
    textAlignment = .center
  }

  override var intrinsicContentSize: CGSize {
    let buffer = CGFloat(8)
    var size = super.intrinsicContentSize
    size.width += buffer
    return size
  }
}
