//
//  TestItem.swift
//  Quinbay
//
//  Created by Sergo Azizbekyants on 15.06.23.
//

import Foundation
import CoreData

@objc(ItemEntity)
final class ItemEntity :NSManagedObject {
    @NSManaged var id: UUID?
    @NSManaged var title: String
}

extension ItemEntity {
    func convertToItem() -> ItemProduct {
        ItemProduct(id: id ?? UUID(), title: title)
    }
}
