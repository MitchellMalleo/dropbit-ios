//
//  AppCoordinator+PinCreationViewControllerDelegate.swift
//  DropBit
//
//  Created by BJ Miller on 4/24/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import UIKit

extension AppCoordinator: PinCreationViewControllerDelegate {
  func viewControllerFullyEnteredPin(_ viewController: PinCreationViewController, digits: String) {
    let verifyVC = PinCreationViewController.makeFromStoryboard()
    verifyVC.entryMode = .pinVerification(digits: digits)
    verifyVC.setupFlow = viewController.setupFlow
    verifyVC.verificationDelegate = self
    navigationController.pushViewController(verifyVC, animated: true)
  }
}
