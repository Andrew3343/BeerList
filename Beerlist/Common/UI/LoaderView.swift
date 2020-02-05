//
//  Loader.swift
//  MovieList
//
//  Created by Andrew on 30.01.2020.
//  Copyright © 2020 Andrew. All rights reserved.
//

import UIKit

private enum Settings {
    
    static let activityIndicatorSize = CGSize(width: 30.0, height: 30.0)
}

final class LoaderView: UIView {
    
    private var activityIndicator: UIActivityIndicatorView?
    
    static func attachToView(_ view: UIView) -> LoaderView {
        
        let loaderView = LoaderView(frame: view.bounds)
        view.addSubview(loaderView)
        
        loaderView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loaderView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loaderView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loaderView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        return loaderView
    }
    
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.setupView()
    }
    
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        self.setupView()
    }
    
    func show() {
        isHidden = false
        startAnimating()
    }
    
    func hide() {
        isHidden = true
        stopAnimating()
    }
    
    private func setupView() {
        
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Color.Loader.cover
        
        let activityIndicator = UIActivityIndicatorView()
        self.activityIndicator = activityIndicator
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        addSubview(activityIndicator)
        activityIndicator.widthAnchor.constraint(equalToConstant: Settings.activityIndicatorSize.width).isActive = true
        activityIndicator.heightAnchor.constraint(equalToConstant: Settings.activityIndicatorSize.height).isActive = true
        
        activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(stopAnimating), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func appDidBecomeActive() {
        if !isHidden {
            startAnimating()
        }
    }
    
    private func startAnimating() {
        activityIndicator?.startAnimating()
    }
    
    @objc
    private func stopAnimating() {
        activityIndicator?.stopAnimating()
    }
}
