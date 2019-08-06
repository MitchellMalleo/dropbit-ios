//
//  NewsViewController.swift
//  DropBit
//
//  Created by Mitchell Malleo on 6/19/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//

import Foundation
import UIKit
import Charts
import PromiseKit
import SVProgressHUD

protocol NewsViewControllerDelegate: ViewControllerDismissable, URLOpener {
  func viewControllerDidRequestNewsData(count: Int) -> Promise<[NewsArticleResponse]>
  func viewControllerDidRequestPriceDataFor(period: PricePeriod) -> Promise<[PriceSummaryResponse]>
  func viewControllerBecameVisible(_ viewController: UIViewController)
  func viewControllerWillShowNewsArticle(_ viewController: UIViewController)
}

final class NewsViewController: BaseViewController, StoryboardInitializable {

  @IBOutlet var tableView: UITableView!
  @IBOutlet var newsErrorLabel: UILabel!
  @IBOutlet var closeButton: UIButton!

  private var newsViewControllerDDS: NewsViewControllerDDS?

  lazy var updateRatesRequest: ExchangeRatesRequest = { [weak self] rates in
    let value = rates[.USD] as NSNumber?
    self?.newsViewControllerDDS?.newsData.currentPrice = value
    self?.tableView.reloadData()
  }

  static func newInstance(with delegate: NewsViewControllerDelegate) -> NewsViewController {
    let controller = NewsViewController.makeFromStoryboard()
    controller.generalCoordinationDelegate = delegate
    return controller
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  var coordinationDelegate: NewsViewControllerDelegate? {
    return generalCoordinationDelegate as? NewsViewControllerDelegate
  }

  override var generalCoordinationDelegate: AnyObject? {
    didSet {
      currencyValueManager = generalCoordinationDelegate as? CurrencyValueDataSourceType
    }
  }

  weak var currencyValueManager: CurrencyValueDataSourceType?

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.registerNib(cellType: PriceCell.self)
    tableView.registerNib(cellType: TimePeriodCell.self)
    tableView.registerNib(cellType: NewsTitleCell.self)
    tableView.registerNib(cellType: LineChartCell.self)
    tableView.registerNib(cellType: NewsArticleCell.self)

    newsViewControllerDDS = NewsViewControllerDDS(delegate: self)

    tableView.delegate = newsViewControllerDDS
    tableView.dataSource = newsViewControllerDDS
    tableView.separatorStyle = .none
    tableView.showsVerticalScrollIndicator = false
    tableView.backgroundColor = .lightGrayBackground

    newsErrorLabel.font = .light(13)
    newsErrorLabel.textColor = .darkGrayText

    SVProgressHUD.show()

    CKNotificationCenter.subscribe(self, [.didUpdateExchangeRates: #selector(refreshDisplayedPrice)])
    currencyValueManager?.latestExchangeRates(responseHandler: updateRatesRequest)

    if let delegate = coordinationDelegate {
      newsViewControllerDDS?.setupDataSet(coordinationDelegate: delegate)
    }
  }

  @IBAction func closeButtonWasTouched() {
    SVProgressHUD.dismiss()
    coordinationDelegate?.viewControllerDidSelectClose(self)
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    coordinationDelegate?.viewControllerBecameVisible(self)
  }

  @objc private func refreshDisplayedPrice() {
    currencyValueManager?.latestExchangeRates(responseHandler: updateRatesRequest)
  }
}

extension NewsViewController: NewsViewControllerDDSDelegate {

  func delegateRefreshNews() {
    tableView.reloadData()
  }

  func delegateDidRequestUrl(_ url: URL) {
    coordinationDelegate?.viewControllerWillShowNewsArticle(self)
    coordinationDelegate?.openURL(url, completionHandler: nil)
  }

  func delegateFinishedLoadingData() {
    SVProgressHUD.dismiss()
    tableView.isHidden = false
  }

  func delegateErrorLoadingData() {
    SVProgressHUD.dismiss()
    newsErrorLabel.isHidden = false
  }
}
