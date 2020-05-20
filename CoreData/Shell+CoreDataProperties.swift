//
//  Shell+CoreDataProperties.swift
//  SwiftDemo
//
//  Created by Apple on 2020/5/12.
//  Copyright © 2020 Nautilus. All rights reserved.
//
//

import Foundation
import CoreData


extension Shell {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Shell> {
        return NSFetchRequest<Shell>(entityName: "Shell")
    }

    @NSManaged public var family_en: String?
    @NSManaged public var family_cn: String?
    @NSManaged public var scientificName: String?
    @NSManaged public var commonName: String?
    @NSManaged public var distributed: String?
    @NSManaged public var quantity: Int16
    @NSManaged public var size: Float
    @NSManaged public var photos: NSData?

}
