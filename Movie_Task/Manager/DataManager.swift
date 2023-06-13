//
//  DataManager.swift
//  Movie_Task
//
//  Created by Sergo Azizbekyants on 15.06.23..
//

import Foundation
import CoreData

protocol DataManagerProtocol {
    func fetchTaskList() -> [ItemProduct]
    func addTask(title: String)
    func toggleIsCompleted(for task: ItemProduct)
}

extension DataManagerProtocol {
    func fetchTaskList() -> [ItemProduct] { fetchTaskList() }
}

class DataManager {
    static let shared: DataManagerProtocol = DataManager()

    private var dbHelper: CoreDataHelper = .shared

    private init() { }

    private func fetchTaskEntity(for task: ItemProduct) -> ItemEntity? {
        let predicate = NSPredicate(format: "id == %@", task.id as CVarArg)
        let result = dbHelper.readFirst(ItemEntity.self, predicate: predicate)
        switch result {
        case .success(let taskEntity):
            return taskEntity
        case .failure:
            return nil
        }
    }
}

// MARK: - DataManagerProtocol
extension DataManager: DataManagerProtocol {
    func fetchTaskList() -> [ItemProduct] {
//        let predicate = NSPredicate(format: "id > 0")
        let result: Result<[ItemEntity], Error> = dbHelper.read(ItemEntity.self, predicate: nil, limit: nil)
        switch result {
        case .success(let taskEntities):
            return taskEntities.map { $0.convertToItem() }
        case .failure(let error):
            fatalError(error.localizedDescription)
        }
    }

    func addTask(title: String) {
        let entity = ItemEntity.entity()
        let newTask = ItemEntity(entity: entity, insertInto: dbHelper.context)
        newTask.id = UUID()
        newTask.title = title
        dbHelper.create(newTask)
    }

    func toggleIsCompleted(for task: ItemProduct) {
        guard let taskEntity = fetchTaskEntity(for: task) else { return }
        dbHelper.update(taskEntity)
    }
}
