//
//  AppCoordinator+AdjustableFeesViewControllerDelegate.swift
//  DropBit
//
//  Created by Ben Winters on 6/21/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import UIKit

extension AppCoordinator: AdjustableFeesViewControllerDelegate {

  var adjustableFeesIsEnabled: Bool {
    get { return persistenceManager.brokers.preferences.adjustableFeesIsEnabled }
    set { persistenceManager.brokers.preferences.adjustableFeesIsEnabled = newValue }
  }

  var preferredTransactionFeeMode: TransactionFeeType {
    get { return persistenceManager.brokers.preferences.preferredTransactionFeeType }
    set { persistenceManager.brokers.preferences.preferredTransactionFeeType = newValue }
  }

}
