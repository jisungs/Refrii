//
//  Item.swift
//  Refrii
//
//  Created by The book on 23/12/2018.
//  Copyright © 2018 The book. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}

