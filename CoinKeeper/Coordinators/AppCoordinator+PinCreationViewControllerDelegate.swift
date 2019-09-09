//
//  AppCoordinator+PinCreationViewControllerDelegate.swift
//  DropBit
//
//  Created by BJ Miller on 4/24/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import UIKit

extension AppCoordinator: PinCreationEntryDelegate {
  func viewControllerFullyEnteredPin(_ viewController: PinCreationViewController, digits: String) {
    let verifyVC = PinCreationViewController.newInstance(setupFlow: viewController.setupFlow,
                                                         delegate: self,
                                                         mode: .pinVerification(digits: digits))
    navigationController.pushViewController(verifyVC, animated: true)
  }
}
