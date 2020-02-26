//
//  VerticalScrollView.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 25.02.2020.
//

import Foundation

@available(iOS 11.0, *)
open class VerticalScrollView: UIScrollView {
    
    private(set) lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func addContentSubview(_ view: UIView) {
        self.contentView.addSubview(view)
    }
    
    private func setupLayout() {
        super.addSubview(contentView)
        self.setConstraints()
    }
    
    private func setConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        
        let heightConstraint = self.contentView.heightAnchor.constraint(equalTo: safeArea.heightAnchor)
        heightConstraint.priority = .init(rawValue: 999)
        
        NSLayoutConstraint.activate([
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.contentView.rightAnchor.constraint(equalTo: self.rightAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.contentView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            heightConstraint
        ])
    }
    
}
