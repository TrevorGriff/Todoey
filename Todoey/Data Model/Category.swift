//
//  Category.swift
//  Todoey
//
//  Created by Trevor Griffiths on 7/7/19.
//  Copyright © 2019 Trevor Griffiths. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name: String = ""
    @objc dynamic var color: String = ""
    let items = List<Item>()


}
