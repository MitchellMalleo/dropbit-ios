//
//  TransactionHistoryDetailInvalidCellTests.swift
//  DropBitTests
//
//  Created by BJ Miller on 4/26/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import XCTest
@testable import DropBit

class TransactionHistoryDetailInvalidCellTests: XCTestCase {
  var sut: TransactionHistoryDetailInvalidCell!
  var mockCoordinator: MockTransactionHistoryDetailCellDelegate!

  override func setUp() {
    super.setUp()
    self.sut = TransactionHistoryDetailInvalidCell.nib().instantiate(withOwner: self, options: nil).first as? TransactionHistoryDetailInvalidCell
    self.sut.awakeFromNib()
    mockCoordinator = MockTransactionHistoryDetailCellDelegate()
    self.sut.delegate = mockCoordinator
  }

  override func tearDown() {
    mockCoordinator = nil
    sut = nil
    super.tearDown()
  }

  // MARK: outlets
  func testOutletsAreConnected() {
    XCTAssertNotNil(sut.warningLabel, "warningLabel should be connected")

    //inherited outlets
    XCTAssertNotNil(sut.underlyingContentView, "underlyingContentView should be connected")
    XCTAssertNotNil(sut.questionMarkButton, "questionMarkButton should be connected")
    XCTAssertNotNil(sut.closeButton, "closeButton should be connected")
    XCTAssertNotNil(sut.directionView, "directionView should be connected")
    XCTAssertNotNil(sut.statusLabel, "statusLabel should be connected")
    XCTAssertNotNil(sut.twitterAvatarView, "twitterAvatarView should be connected")
    XCTAssertNotNil(sut.counterpartyLabel, "counterpartyLabel should be connected")
    XCTAssertNotNil(sut.primaryAmountLabel, "primaryAmountLabel should be connected")
    XCTAssertNotNil(sut.secondaryAmountLabel, "secondaryAmountLabel should be connected")
    XCTAssertNotNil(sut.historicalValuesLabel, "historicalValuesLabel should be connected")
    XCTAssertNotNil(sut.addMemoButton, "addMemoButton should be connected")
    XCTAssertNotNil(sut.memoContainerView, "memoContainerView should be connected")
    XCTAssertNotNil(sut.dateLabel, "dateLabel should be connected")
  }

  // MARK: buttons contain actions
  func testAddMemoButtonContainsAction() {
    let actions = sut.addMemoButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []
    let expected = #selector(TransactionHistoryDetailInvalidCell.didTapAddMemoButton(_:)).description
    XCTAssertTrue(actions.contains(expected), "button should contain action")
  }

  func testCloseButtonContainsAction() {
    let actions = sut.closeButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []
    let expected = #selector(TransactionHistoryDetailInvalidCell.didTapClose(_:)).description
    XCTAssertTrue(actions.contains(expected), "button should contain action")
  }

  func testQuestionMarkButtonContainsAction() {
    let actions = sut.questionMarkButton.actions(forTarget: sut, forControlEvent: .touchUpInside) ?? []
    let expected = #selector(TransactionHistoryDetailInvalidCell.didTapQuestionMarkButton(_:)).description
    XCTAssertTrue(actions.contains(expected), "button should contain action")
  }

  // MARK: actions produce results
  func testCloseButtonTellsDelegate() {
    sut.closeButton.sendActions(for: .touchUpInside)
    XCTAssertTrue(mockCoordinator.tappedClose)
  }

  func testQuestionMarkButtonTellsDelegate() {
    let viewModel = MockDetailInvalidCellVM(status: .expired)
    sut.configure(with: viewModel, delegate: mockCoordinator)
    sut.questionMarkButton.sendActions(for: .touchUpInside)
    XCTAssertTrue(mockCoordinator.tappedQuestionMark)
  }

  func testAddMemoButtonTellsDelegate() {
    sut.addMemoButton.sendActions(for: .touchUpInside)
    XCTAssertTrue(mockCoordinator.tappedAddMemo)
  }

  // MARK: configure cell
  func testLoadMethodPopulatesOutlets() {
    let mockDelegate = MockTransactionHistoryDetailCellDelegate()
    let data = self.sampleData()
    //TODO:
//    self.sut.load(with: data, delegate: mockDelegate)
//    XCTAssertTrue(data === sut.viewModel)
    XCTAssertTrue(mockDelegate === sut.delegate)
    XCTAssertEqual(self.sut.counterpartyLabel.text, data.counterpartyDescription, "counterpartyLabel should contain description")
    XCTAssertEqual(self.sut.primaryAmountLabel.text, data.primaryAmountLabel, "primaryAmountLabel should be populated")
    XCTAssertEqual(self.sut.secondaryAmountLabel.attributedText?.string, data.secondaryAmountLabel?.string,
                   "secondaryAmountLabel should be populated")
    XCTAssertFalse(sut.addMemoButton.isHidden)
    XCTAssertEqual(self.sut.dateLabel.text, data.dateDescriptionFull, "dateLabel should be populated")
  }

//    XCTAssertTrue(mockDelegate === sut.delegate)
//    XCTAssertEqual(self.sut.counterpartyLabel.text, data.counterpartyDescription, "counterpartyLabel should contain description")
//    XCTAssertEqual(self.sut.primaryAmountLabel.text, data.primaryAmountLabel, "primaryAmountLabel should be populated")
//    XCTAssertEqual(self.sut.secondaryAmountLabel.attributedText?.string, data.secondaryAmountLabel?.string,
//                   "secondaryAmountLabel should be populated")
//    XCTAssertFalse(sut.addMemoButton.isHidden)
//    XCTAssertEqual(self.sut.dateLabel.text, data.dateDescriptionFull, "dateLabel should be populated")
  }

}
