//
//  BeerlistViewController.swift
//  Beerlist
//
//  Created by Andrew on 03.02.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

private enum Settings {
    
    static let estimatedRowHeight: CGFloat = 127.0
    static let topContentInset: CGFloat = 20.0
}

final class BeerlistViewController: UIViewController {
    
    private var interactor: BeerListInteractable!
    private lazy var loaderView = {
        return LoaderView.attachToView(view)
    }()
    
    @IBOutlet private var tableView: UITableView!
    
    private var cellTypes: [UITableViewCell.Type] {
        [
            BeerlistLoaderTableViewCell.self,
            BeerlistTableViewCell.self
        ]
    }
    
    static func assembleModule() -> UIViewController {
        
        let viewController = BeerlistViewController.instantiateFromStoryboard(storyboard: .Beerlist)
        viewController.interactor = BeerListInteractor(beerListView: viewController)
        return viewController
    }
    
    override func viewDidLoad() {
        
        view.backgroundColor = .white

        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.contentInset = UIEdgeInsets(top: Settings.topContentInset, left: 0.0, bottom: 0.0, right: 0.0)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = Settings.estimatedRowHeight
        tableView.separatorInset = UIEdgeInsets.zero
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        for cellType in cellTypes {
            tableView.register(UINib(nibName: cellType.nibName, bundle: nil), forCellReuseIdentifier: cellType.reuseIdentifier)
        }
        
        super.viewDidLoad()
        
        interactor.startOperating()
    }
    
    @objc
    func refreshData() {
        
        interactor.fetchInitialPage(useCustomLoader: false)
    }
}

extension BeerlistViewController: BeerListView {
    
    func startLoading() {
        loaderView.show()
    }
    
    func stopLoading() {
        loaderView.hide()
        tableView.refreshControl?.endRefreshing()
    }
    
    func reloadSection() {
        tableView.reloadSections([0], with: .automatic)
    }
    
    func showError(name: String, description: String) {
        showStandardError(name: name, description: description)
    }
}

extension BeerlistViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let itemCount = interactor.currentItemList?.count else {
            return 0
        }
        
        switch itemCount {
        case 0:
            return 0
        default:
            return itemCount + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == (tableView.numberOfRows(inSection: indexPath.section) - 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: BeerlistLoaderTableViewCell.reuseIdentifier, for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: BeerlistTableViewCell.reuseIdentifier, for: indexPath)
            
            if let beerListCell = cell as? BeerlistTableViewCell, let beerItem = interactor.currentItemList?[indexPath.row] {
                beerListCell.setupWith(beerItem: beerItem, imageSupply: interactor.imageSupply)
            }
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if let cell = cell as? BeerlistLoaderTableViewCell {
            cell.stopAnimating()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard interactor.isFetchingNextPage == false else {
            return
        }
        
        if let cell = tableView.visibleCells.first(where: {
            $0 is BeerlistLoaderTableViewCell
        }) {
            guard let indexPath = tableView.indexPath(for: cell) else {
                return
            }
            let rect = tableView.rectForRow(at: indexPath)
            guard rect.intersection(tableView.bounds).height > (0.4 * rect.height) else {
                return
            }
            
            if let cell = cell as? BeerlistLoaderTableViewCell {
                cell.startAnimating()
                interactor.fetchNextPage()
            }
        }
    }
    
}

