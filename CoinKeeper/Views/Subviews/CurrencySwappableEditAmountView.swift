//
//  CurrencySwappableEditAmountView.swift
//  DropBit
//
//  Created by Mitchell Malleo on 7/11/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencySwappableEditAmountViewDelegate: AnyObject {
  func swapViewDidSwap(_ swapView: CurrencySwappableEditAmountView)
}

struct DualAmountLabels {
  let primary: NSAttributedString?
  let secondary: NSAttributedString?
}

class CurrencySwappableEditAmountView: UIView {

  weak var delegate: CurrencySwappableEditAmountViewDelegate!

  @IBOutlet var primaryAmountTextField: PrimaryAmountTextField!
  @IBOutlet var secondaryAmountLabel: UILabel!
  @IBOutlet var editAmountButton: UIButton!
  @IBOutlet var swapButton: UIButton!

  @IBAction func performSwap(_ sender: Any) {
    delegate.swapViewDidSwap(self)
  }

  @IBAction func editAmountButtonTapped() {
    primaryAmountTextField.becomeFirstResponder()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    xibSetup()
  }

  override init(frame: CGRect) {
    super.init(frame: frame)
    xibSetup()
  }

  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = .clear

    primaryAmountTextField.tintColor = .darkBlueText //cursor
  }

  func disableSwap() {
    swapButton.isUserInteractionEnabled = false
    swapButton.isHidden = true
  }

  func enableEditing(_ isEnabled: Bool) {
    self.isUserInteractionEnabled = isEnabled
    self.editAmountButton.isUserInteractionEnabled = isEnabled
    self.primaryAmountTextField.isUserInteractionEnabled = isEnabled
  }

  func configure(withLabels labels: DualAmountLabels,
                 delegate: CurrencySwappableEditAmountViewDelegate) {
    update(with: labels)
    self.delegate = delegate
  }

  func update(with labels: DualAmountLabels) {
    primaryAmountTextField.defaultTextAttributes[.font] = nil
    primaryAmountTextField.attributedText = labels.primary
    secondaryAmountLabel.attributedText = labels.secondary
  }

}
