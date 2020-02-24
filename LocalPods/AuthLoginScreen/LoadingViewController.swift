//
//  LoadingViewController.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 24.02.2020.
//

import Foundation

@available(iOS 11.0, *)
public class LoadingViewController: UIViewController {
    
    private(set) lazy var loadingView: LoadingView = {
        let view = LoadingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var loadingViewConstraints: [NSLayoutConstraint] = {
        let safeArea = self.view.safeAreaLayoutGuide
        return [
            self.loadingView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.loadingView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            self.loadingView.heightAnchor.constraint(equalToConstant: 100),
            self.loadingView.widthAnchor.constraint(equalToConstant: 100)
        ]
    }()
    
    public func openLoadingView() {
        loadingView.indicatorView.startAnimating()
        self.view.isUserInteractionEnabled = false
        self.view.addSubview(self.loadingView)
        NSLayoutConstraint.activate(self.loadingViewConstraints)
    }
    
    public func closeLoadingView() {
        self.loadingView.indicatorView.stopAnimating()
        self.view.isUserInteractionEnabled = true
        NSLayoutConstraint.deactivate(self.loadingViewConstraints)
        self.loadingView.removeFromSuperview()
    }
    
}
