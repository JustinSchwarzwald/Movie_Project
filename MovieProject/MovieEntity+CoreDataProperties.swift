//
//  MovieEntity+CoreDataProperties.swift
//  MovieProject
//
//  Created by Justin on 3/14/21.
//
//

import Foundation
import CoreData


extension MovieEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieEntity> {
        return NSFetchRequest<MovieEntity>(entityName: "MovieEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var picture: Data?
    @NSManaged public var title: String?

}

extension MovieEntity : Identifiable {

}
