//
//  User+CoreDataProperties.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 27.05.2024.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var username: String?
    @NSManaged public var has: NSSet?

}

// MARK: Generated accessors for has
extension User {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Score)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Score)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}

extension User : Identifiable {

}
