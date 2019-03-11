//
//  TransactionDetailDateLabel.swift
//  CoinKeeper
//
//  Created by Ben Winters on 4/12/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import UIKit

class TransactionDetailDateLabel: UILabel {
  override func awakeFromNib() {
    super.awakeFromNib()
    font = Theme.Font.transactionDetailDate.font
    textColor = Theme.Color.grayText.color
    isHidden = false
    numberOfLines = 1
    textAlignment = .center
  }
}
