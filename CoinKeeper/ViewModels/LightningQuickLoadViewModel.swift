//
//  LightningQuickLoadViewModel.swift
//  DropBit
//
//  Created by Ben Winters on 11/21/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import Foundation

struct LightningQuickLoadViewModel {

  let balances: WalletBalances
  let currency: CurrencyCode
  let controlConfigs: [QuickLoadControlConfig]

  static var standardAmounts: [NSDecimalNumber] {
    return [5, 10, 20, 50, 100].map { NSDecimalNumber(value: $0) }
  }

  init(spendableBalances: WalletBalances, rates: ExchangeRates, currency: CurrencyCode) throws {
    let maxAmount = spendableBalances.onChain
    //Validate the on chain and lightning balances, throw LightningWalletAmountValidatorError as appropriate
    self.balances = spendableBalances
    self.currency = currency
    self.controlConfigs = [] // LightningQuickLoadViewModel.configs(withMax: maxAmount, currency: currency)
  }

  private static func configs(withMax max: NSDecimalNumber, currency: CurrencyCode) -> [QuickLoadControlConfig] {
    let standardConfigs = standardAmounts.map { amount -> QuickLoadControlConfig in
      let money = Money(amount: amount, currency: currency)
      return QuickLoadControlConfig(isEnabled: amount <= max, amount: money)
    }
    let maxConfig = QuickLoadControlConfig(maxAmount: Money(amount: max, currency: currency))
    return standardConfigs + [maxConfig]
  }

}
