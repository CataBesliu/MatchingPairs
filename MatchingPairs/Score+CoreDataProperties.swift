//
//  Score+CoreDataProperties.swift
//  MatchingPairs
//
//  Created by Catalina Besliu on 27.05.2024.
//
//

import Foundation
import CoreData


extension Score {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Score> {
        return NSFetchRequest<Score>(entityName: "Score")
    }

    @NSManaged public var noOfMoves: Int16
    @NSManaged public var noOfPoints: Int32
    @NSManaged public var time: String?

}

extension Score : Identifiable {

}
