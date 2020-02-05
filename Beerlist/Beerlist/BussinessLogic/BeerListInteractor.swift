//
//  MovieListDataInteractor.swift
//  MovieList
//
//  Created by Andrew on 24.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//


import Foundation

protocol BeerListInteractable: DataInteractable {
    
    var currentItemList: [BeerItem]? { get }
    var isFetchingNextPage: Bool { get }
    var imageSupply: ImageSupply { get }
    func fetchNextPage()
    func fetchInitialPage(useCustomLoader: Bool)
}

protocol BeerListView: class {
    
    func startLoading()
    func stopLoading()
    func reloadSection()
    func showError(name: String, description: String)
}


final class BeerListInteractor: BeerListInteractable {
    
    private var beerList: [BeerItem]?
    private var currentLastPage: Int = 0
    
    private lazy var beerListWorker = BeerListWorker()
    private lazy var imageSupplyWorker = ImageSupplyWorker()
    
    private let beerListView: BeerListView
    
    var isFetchingNextPage: Bool = false
    
    
    var currentItemList: [BeerItem]? {
        beerList
    }
    
    var imageSupply: ImageSupply {
        imageSupplyWorker
    }
    
    init(beerListView: BeerListView) {
        
        self.beerListView = beerListView
    }
    
    func startOperating() {
        
        fetchInitialPage(useCustomLoader: true)
    }
    
    func fetchInitialPage(useCustomLoader: Bool) {
        
        if useCustomLoader {
            beerListView.startLoading()
        }
        
        beerListWorker.fetchBeerList(page: 1) { [weak self](result) in
            guard let strongSelf = self else {
                return
            }
            
            DispatchQueue.main.async {
                strongSelf.beerListView.stopLoading()
            }
            
            switch result {
            case .success(let beerList):
                
                strongSelf.currentLastPage = 1
                strongSelf.beerList = beerList
                DispatchQueue.main.async {
                    self?.beerListView.reloadSection()
                }
                
            case .failure(let error):
                self?.handleNetworkError(error)
            }
        }
    }
    
    func fetchNextPage() {
        isFetchingNextPage = true
        beerListWorker.fetchBeerList(page: currentLastPage + 1) { [weak self](result) in
            guard let strongSelf = self else {
                return
            }
            strongSelf.isFetchingNextPage = false
            
            switch result {
            case .success(let beerList):
                strongSelf.currentLastPage += 1
                strongSelf.beerList?.append(contentsOf: beerList)
                
                DispatchQueue.main.async {
                    self?.beerListView.reloadSection()
                }
                
            case .failure(let error):
                self?.handleNetworkError(error)
            }
            
        }
    }
    
    private func handleNetworkError(_ error:APIError) {
        
        guard error != .requestCancelled else {
            return
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.beerListView.showError(name: CommonStrings.networkErrorName, description: error.localizedDescription)
        }
    }
}
