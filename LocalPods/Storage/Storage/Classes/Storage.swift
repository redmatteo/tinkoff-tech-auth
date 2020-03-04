//
//  Storage.swift
//  Pods-Storage_Example
//
//  Created by Artem Kufaev on 04.03.2020.
//

import CoreData

open class Storage {
    
    let coreData: CoreDataStack
    
    init(with modelName: String) {
        coreData = CoreDataStack(modelName: modelName)
    }
    
//    public func read() {
//
//    }
    
    public func readAll<T: NSManagedObject>() throws -> [T] {
        let entityName = String(describing: T.self)
        let fetchRequest = NSFetchRequest<T>(entityName: entityName)
        let context = coreData.mainContext
        let result = try context.fetch(fetchRequest)
        return result
    }
    
    public func write(_ object: NSManagedObject) throws {
        let context = coreData.mainContext
        try context.save()
    }
    
    public func write(_ objects: [NSManagedObject]) throws {
        let context = coreData.mainContext
        try context.save()
    }
    
}
