//
//  TransactionHistoryDetailBaseCell.swift
//  DropBit
//
//  Created by BJ Miller on 4/23/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import UIKit
import PromiseKit

protocol TransactionHistoryDetailCellDelegate: class {
  func didTapQuestionMarkButton(detailCell: TransactionHistoryDetailBaseCell, with url: URL)
  func didTapClose(detailCell: TransactionHistoryDetailBaseCell)
  func didTapTwitterShare(detailCell: TransactionHistoryDetailBaseCell)
  func didTapAddress(detailCell: TransactionHistoryDetailBaseCell)
  func didTapBottomButton(detailCell: TransactionHistoryDetailBaseCell, action: TransactionDetailAction)
  func didTapAddMemoButton(completion: @escaping (String) -> Void)
  func shouldSaveMemo(for transaction: CKMTransaction) -> Promise<Void>
}

//TODO: resolve commented out implementations
class TransactionHistoryDetailBaseCell: UICollectionViewCell {

  // MARK: outlets
  @IBOutlet var underlyingContentView: UIView!
  @IBOutlet var closeButton: UIButton!
  @IBOutlet var questionMarkButton: UIButton!
  @IBOutlet var directionImageView: UIImageView!
  @IBOutlet var dateLabel: TransactionDetailDateLabel!
  @IBOutlet var primaryAmountLabel: TransactionDetailPrimaryAmountLabel!
  @IBOutlet var secondaryAmountLabel: TransactionDetailSecondaryAmountLabel!
  @IBOutlet var historicalValuesLabel: UILabel! //use attributedText
  @IBOutlet var addMemoButton: UIButton!
  @IBOutlet var memoContainerView: ConfirmPaymentMemoView!
  @IBOutlet var statusLabel: TransactionDetailStatusLabel!
  @IBOutlet var counterpartyLabel: TransactionDetailCounterpartyLabel!
  @IBOutlet var twitterImage: UIImageView!
  @IBOutlet var twitterShareButton: TwitterShareButton!

  // MARK: variables
  var viewModel: TransactionHistoryDetailCellDisplayable!
  weak var delegate: TransactionHistoryDetailCellDelegate!

  // MARK: object lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()

    backgroundColor = UIColor.white
    layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    applyCornerRadius(13)

    // Shadow
    layer.shadowColor = UIColor.black.cgColor
    layer.shadowOpacity = 0.5
    layer.shadowRadius = 2
    layer.shadowOffset = CGSize(width: 0, height: 4)
    self.clipsToBounds = false
    layer.masksToBounds = false

    underlyingContentView.backgroundColor = UIColor.white
    underlyingContentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    underlyingContentView.applyCornerRadius(13)
    addMemoButton.styleAddButtonWith(title: "Add Memo")
  }

  override func prepareForReuse() {
    super.prepareForReuse()
    viewModel = nil
  }

  // MARK: actions
  @IBAction func didTapAddMemoButton(_ sender: UIButton) {
//    delegate?.didTapAddMemoButton { [weak self] memo in
//      guard let vm = self?.viewModel, let delegate = self?.delegate, let tx = vm.transaction else { return }
//      tx.memo = memo
//
//      delegate.shouldSaveMemo(for: tx)
//        .done {
//          vm.memo = memo
//          self?.load(with: vm, delegate: delegate)
//        }.catch { error in
//          log.error(error, message: "failed to add memo")
//      }
//    }
  }

  @IBAction func didTapQuestionMarkButton(_ sender: UIButton) {
//    guard let url: URL = viewModel?.invitationStatus != nil ?
//      CoinNinjaUrlFactory.buildUrl(for: .dropbitTransactionTooltip) : CoinNinjaUrlFactory.buildUrl(for: .regularTransactionTooltip) else { return }
//
//    delegate?.didTapQuestionMarkButton(detailCell: self, with: url)
  }

  @IBAction func didTapTwitterShare(_ sender: Any) {
    delegate?.didTapTwitterShare(detailCell: self)
  }

  @IBAction func didTapClose(_ sender: Any) {
    delegate?.didTapClose(detailCell: self)
  }

  func load(with viewModel: TransactionHistoryDetailCellDisplayable, delegate: TransactionHistoryDetailCellDelegate) {
    self.delegate = delegate
    self.viewModel = viewModel

  }

}
