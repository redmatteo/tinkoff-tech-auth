//
//  UITableView+Reusable.swift
//  Pods-UIViewKit_Example
//
//  Created by Artem Kufaev on 04.03.2020.
//

extension UITableView {

    func dequeueReusableCell<T: ReusableCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to Dequeue Reusable Table View Cell")
        }

        return cell
    }

}
