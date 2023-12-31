//
//  DBHelper.swift
//  Movie_Task
//
//  Created by Sergo Azizbekyants on 15.06.23..
//

import Foundation
import CoreData

final class CoreDataHelper {
    typealias DBObject = NSManagedObject
    typealias DBPredicate = NSPredicate
    
    static let shared = CoreDataHelper()
    
    var context: NSManagedObjectContext { persistentContainer.viewContext }
    
    private init() { }
    
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "Movie_Task")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let error = error as NSError
                fatalError("Unresolved error: \(error), \(error.userInfo)")
            }
        }
    }
}

extension CoreDataHelper: DBHelper {
    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context: \(error)")
        }
    }
    
    func read<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?, limit: Int? = nil) -> Result<[T], Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        if let limit = limit {
            request.fetchLimit = limit
        }
        do {
            let result = try context.fetch(request)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }
    
    func readFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        
        do {
            let result = try context.fetch(request)
            return .success(result.first as? T)
        } catch {
            return .failure(error)
        }
    }
    
    func update<T: NSManagedObject>(_ object: T) {
        do {
            try context.save()
        } catch {
            fatalError("error updating context: \(error)")
        }
    }
    
    func delete<T: NSManagedObject>(_ object: T) {
        context.delete(object)
    }
}
