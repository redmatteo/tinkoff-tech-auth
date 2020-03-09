//
//  ViewController.swift
//  Storage
//
//  Created by Nelmeris on 03/04/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import Storage
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let stack = CoreDataStack(modelName: "Test")
        let worker = CoreDataWorker(coreData: stack)
        
        let user1 = User(id: "0", username: "nelmeris", name: "Artem", birthday: Date())
        let user2 = User(id: "1", username: "nelmeris1", name: "Artem", birthday: Date())
        let user3 = User(id: "2", username: "nelmeris2", name: "Artem", birthday: Date())
        let user4 = User(id: "3", username: "nelmeris3", name: "Artem", birthday: Date())
        let user5 = User(id: "4", username: "nelmeris4", name: "Artem", birthday: Date())
        
        worker.upsert(user1) { print($0 ?? user1) }
        worker.upsert(user2) { print($0 ?? user2) }
        worker.upsert(user3) { print($0 ?? user3) }
        worker.upsert(user4) { print($0 ?? user4) }
        worker.upsert(user5) { print($0 ?? user5) }
        
        worker.get { (result: Result<[User], CoreDataWorkerError>) in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print("\(error)")
            }
        }
        
        worker.remove(user1) { print($0 ?? "success") }
        worker.remove(user3) { print($0 ?? "success") }
        worker.remove(user5) { print($0 ?? "success") }
        
        worker.get { (result: Result<[User], CoreDataWorkerError>) in
            switch result {
            case .success(let users):
                print(users)
            case .failure(let error):
                print("\(error)")
            }
        }
    }
    
    private func parseResult(_ result: Result<User, CoreDataWorkerError>) {
        switch result {
        case .success(let users):
            print(users)
        case .failure(let error):
            print("\(error)")
        }
    }

}

