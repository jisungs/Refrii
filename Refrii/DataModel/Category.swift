//
//  Category.swift
//  Refrii
//
//  Created by The book on 23/12/2018.
//  Copyright © 2018 The book. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var name : String = ""
    
    let items = List<Item>()
    
}
