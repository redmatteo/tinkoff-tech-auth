//
//  ViewController.swift
//  UIViewKit
//
//  Created by Nelmeris on 03/03/2020.
//  Copyright (c) 2020 Nelmeris. All rights reserved.
//

import UIKit
import UIViewKit

class Cell: UITableViewCell, ConfigurableCell {
    typealias T = ViewModel
    
    func configure(_ viewModel: ViewModel, at indexPath: IndexPath) {
        self.textLabel?.text = viewModel.text
    }
}

struct ViewModel {
    let text: String
}

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var adapter: TableViewAdapter<ViewModel, Cell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.adapter = TableViewAdapter(table: tableView)
        let models = [
            ViewModel(text: "1"),
            ViewModel(text: "2"),
            ViewModel(text: "3"),
            ViewModel(text: "4"),
            ViewModel(text: "5"),
            ViewModel(text: "6"),
            ViewModel(text: "7")
        ]
        adapter.set(items: models)
    }
    
}
