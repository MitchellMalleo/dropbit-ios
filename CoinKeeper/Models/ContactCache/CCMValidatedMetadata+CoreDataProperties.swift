//
//  CCMValidatedMetadata+CoreDataProperties.swift
//  DropBit
//
//  Created by Ben Winters on 2/20/19.
//  Copyright © 2019 Coin Ninja, LLC. All rights reserved.
//
//

import Foundation
import CoreData

extension CCMValidatedMetadata {

  @nonobjc public class func fetchRequest() -> NSFetchRequest<CCMValidatedMetadata> {
    return NSFetchRequest<CCMValidatedMetadata>(entityName: "CCMValidatedMetadata")
  }

  @NSManaged public var countryCode: Int
  @NSManaged public var nationalNumber: String
  @NSManaged public var hashedGlobalNumber: String
  @NSManaged public var cachedPhoneNumber: CCMPhoneNumber?

}
