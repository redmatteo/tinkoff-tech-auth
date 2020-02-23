//
//  AuthLoginModuleBuilder.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

import Foundation

@available(iOS 11.0, *)
public class AuthLoginModuleBuilder {
    
    public static func build() -> AuthLoginViewController {
        let controller = AuthLoginViewController()
        let presenter = AuthLoginViewPresenter()
        controller.presenter = presenter
        presenter.controller = controller
        return controller
    }
    
}
