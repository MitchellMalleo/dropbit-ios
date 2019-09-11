//
//  LightningUpgradePageViewController.swift
//  DropBit
//
//  Created by BJ Miller on 8/30/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import UIKit
import CNBitcoinKit

final class LightningUpgradePageViewController: UIPageViewController, StoryboardInitializable {

  weak var generalCoordinationDelegate: AnyObject?
  weak var activeViewController: UIViewController?

  var transactionData: CNBTransactionData? {
    didSet {
      if let data = transactionData {
        self.activeViewController
          .flatMap { $0 as? LightningUpgradeStartViewController }?
          .updateUI(withTransactionData: data)
      }
    }
  }
  var transactionMetadata: CNBTransactionMetadata?

  private func performUpgradeNowAction() {
    activeViewController = lnViewControllers()[1]
    activeViewController.map { self.setViewControllers([$0], direction: .forward, animated: true, completion: nil) }
  }

  private func showFinalizeUpgradeAction(error: Error?) {
    activeViewController = lnViewControllers()[2]
    activeViewController.map { self.setViewControllers([$0], direction: .forward, animated: true, completion: nil) }
  }

  private func lnViewControllers() -> [UIViewController] {
    return [

      (generalCoordinationDelegate as? LightningUpgradeStartViewControllerDelegate)
        .map {
          LightningUpgradeStartViewController.newInstance(
            delegate: $0,
            nextStep: { [weak self] in self?.performUpgradeNowAction() })
        },

      (generalCoordinationDelegate as? LightningUpgradeStatusViewControllerDelegate)
        .map {
          LightningUpgradeStatusViewController.newInstance(
            withDelegate: $0,
            dataSource: self,
            nextStep: { [weak self] (error: Error?) in self?.showFinalizeUpgradeAction(error: error) })
        },

      (generalCoordinationDelegate as? LightningUpgradeCompleteViewControllerDelegate)
        .map(LightningUpgradeCompleteViewController.newInstance)

      ].compactMap { $0 }
  }

  static func newInstance(withGeneralCoordinationDelegate delegate: AnyObject) -> LightningUpgradePageViewController {
    let controller = LightningUpgradePageViewController.makeFromStoryboard()
    controller.generalCoordinationDelegate = delegate
    return controller
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    modalPresentationStyle = .overFullScreen
    modalTransitionStyle = .coverVertical

    activeViewController = lnViewControllers().first

    activeViewController.map { self.setViewControllers([$0], direction: .forward, animated: true, completion: nil) }
  }

  func updateUI(with data: CNBTransactionData?, txMetadata: CNBTransactionMetadata?) {
    self.transactionData = data
    self.transactionMetadata = txMetadata
  }

}

extension LightningUpgradePageViewController: LightningUpgradeStatusDataSource { }
