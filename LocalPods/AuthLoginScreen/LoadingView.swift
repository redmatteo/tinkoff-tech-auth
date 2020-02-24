//
//  LoadingView.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 24.02.2020.
//

import Foundation

@available(iOS 11.0, *)
class LoadingView: UIView {
    
    // MARK: - Subviews
    
    private(set) lazy var indicatorView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 13.0, *) {
            indicator.style = .large
        } else {
            indicator.style = .gray
        }
        return indicator
    }()
    
    private(set) lazy var blurView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .extraLight)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    
    private func setupLayout() {
        self.addSubview(blurView)
        self.addSubview(indicatorView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            self.blurView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            self.blurView.leftAnchor.constraint(equalTo: safeArea.leftAnchor),
            self.blurView.rightAnchor.constraint(equalTo: safeArea.rightAnchor),
            self.blurView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            self.indicatorView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            self.indicatorView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor)
        ])
    }
    
}
