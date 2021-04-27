//
//  Users+CoreDataProperties.swift
//  
//
//  Created by 김진우 on 2021/04/11.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var pw: String?
    @NSManaged public var id: String?
    @NSManaged public var email: String?

}
