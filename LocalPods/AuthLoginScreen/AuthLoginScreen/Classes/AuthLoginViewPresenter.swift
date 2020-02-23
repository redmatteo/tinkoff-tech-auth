//
//  AuthLoginViewPresenter.swift
//  AuthLoginScreen
//
//  Created by Artem Kufaev on 23.02.2020.
//

protocol AuthLoginController: class {
    
}

protocol AuthLoginPresenter: class {
    
}

class AuthLoginViewPresenter {
    
    weak var controller: AuthLoginController!
    
}

extension AuthLoginViewPresenter: AuthLoginPresenter {
    
}
