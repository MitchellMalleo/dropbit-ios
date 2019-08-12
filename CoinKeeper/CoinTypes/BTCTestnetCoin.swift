//
//  BTCTestnetCoin.swift
//  CoinKeeper
//
//  Created by BJ Miller on 4/18/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import CNBitcoinKit

class BTCTestnetCoin: CNBBaseCoin {
  init(purpose: CoinDerivation) {
    super.init(purpose: purpose, coin: CoinType.TestNet, account: 0)
  }
}
