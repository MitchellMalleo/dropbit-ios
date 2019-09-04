//
//  StartViewController.swift
//  CoinKeeper
//
//  Created by BJ Miller on 2/1/18.
//  Copyright © 2018 Coin Ninja, LLC. All rights reserved.
//

import UIKit

protocol StartViewControllerDelegate: AnyObject {
  func createWallet()
  func restoreWallet()
  func claimInvite()
  func clearPin()
  func requireAuthenticationIfNeeded(whenAuthenticated: @escaping () -> Void)
  func requireAuthenticationIfNeeded()
}

final class StartViewController: BaseViewController {

  var coordinationDelegate: StartViewControllerDelegate? {
    return generalCoordinationDelegate as? StartViewControllerDelegate
  }

  let restoreWalletButton = UIButton(type: .custom)
  @IBOutlet var claimInviteButton: UIButton!
  @IBOutlet var newWalletButton: UIButton!

  @IBOutlet var blockchainImage: UIImageView!
  @IBOutlet var logoImage: UIImageView!
  @IBOutlet var logoImageVerticalConstraint: NSLayoutConstraint!
  @IBOutlet var welcomeLabel: UILabel!
  @IBOutlet var welcomeBGView: UIView! {
    didSet {
      welcomeBGView.backgroundColor = .clear
    }
  }
  @IBOutlet var welcomeBGViewTopConstraint: NSLayoutConstraint!
  @IBOutlet var animatableViews: [UIView]!

  override func accessibleViewsAndIdentifiers() -> [AccessibleViewElement] {
    return [
      (self.view, .start(.page)),
      (self.newWalletButton, .start(.newWallet)),
      (self.restoreWalletButton, .start(.restoreWallet))
    ]
  }

  @objc func restoreWalletButtonTapped() {
    coordinationDelegate?.restoreWallet()
  }

  @IBAction func claimBitcoinFromInviteTapped(_ sender: UIButton) {
    coordinationDelegate?.claimInvite()
  }

  @IBAction func newWalletButtonTapped(_ sender: UIButton) {
    coordinationDelegate?.createWallet()
  }

  // MARK: view lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()

    configureButtons()
    toggleAnimatableViews(show: false)
  }

  private func configureButtons() {
    let restoreTitle = NSAttributedString(imageName: "rightArrow",
                                          imageSize: CGSize(width: 8, height: 12),
                                          title: "Restore Wallet",
                                          sharedColor: .darkBlueText,
                                          font: .regular(12),
                                          imageOffset: CGPoint(x: 0, y: 1),
                                          trailingImage: true)
    let size = restoreTitle.size()
    let buffer = CGFloat(16)
    let width = size.width + buffer
    restoreWalletButton.frame = CGRect(x: 0, y: 0, width: width, height: 40)
    restoreWalletButton.backgroundColor = .clear
    restoreWalletButton.addTarget(self, action: #selector(restoreWalletButtonTapped), for: .touchUpInside)
    restoreWalletButton.setAttributedTitle(restoreTitle, for: .normal)
    self.navigationItem.titleView = restoreWalletButton

    claimInviteButton.setTitle("CLAIM BITCOIN FROM INVITE", for: .normal)
    claimInviteButton.backgroundColor = .darkBlueBackground
    claimInviteButton.applyCornerRadius(4)
    claimInviteButton.setTitleColor(.whiteText, for: .normal)
    claimInviteButton.titleLabel?.font = .primaryButtonTitle

    newWalletButton.setTitle("NEW WALLET", for: .normal)
    newWalletButton.setTitleColor(.lightBlueTint, for: .normal)
    newWalletButton.titleLabel?.font = .primaryButtonTitle
  }

  private func toggleAnimatableViews(show: Bool) {
    guard let views = animatableViews else { return }
    (views + [restoreWalletButton as UIView]).forEach { view in
      view.alpha = show ? 1.0 : 0.0
      view.isHidden = !show
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let animationDuration: TimeInterval = 0.75
    let delay: TimeInterval = 0.33
    let offset = ((welcomeBGView.frame.height / 2.0) * -1) - (welcomeBGViewTopConstraint.constant / 2.0)

    // do a layout pass
    view.layoutIfNeeded()

    // set properties to animate
    logoImageVerticalConstraint.constant = offset

    // animate
    UIView.animate(withDuration: animationDuration, delay: delay, options: .curveEaseInOut, animations: {
      self.toggleAnimatableViews(show: true)
      self.view.layoutIfNeeded()
    })
  }

}

extension StartViewController: StoryboardInitializable {}
