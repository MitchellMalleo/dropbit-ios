//
//  SummaryCellSatsLabel.swift
//  DropBit
//
//  Created by Ben Winters on 8/24/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import UIKit

class SummaryCellBitcoinLabel: UILabel {
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    initialize()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    initialize()
  }

  fileprivate func initialize() {
    self.backgroundColor = .clear
    self.textColor = .bitcoinOrange
    self.font = .semiBold(13)
    self.textAlignment = .right

    self.translatesAutoresizingMaskIntoConstraints = false
    self.heightAnchor.constraint(equalToConstant: 28).isActive = true
  }
}

class SummaryCellSatsLabel: SummaryCellBitcoinLabel {

}
