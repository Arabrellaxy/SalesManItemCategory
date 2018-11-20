//
//  SWCateogryItem.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/20.
//

import UIKit

class SWCateogryItem: NSObject {
    var name: String?
    var folded: Bool = false
    var categoryID: String?
    var childs: NSArray?
    override init() {
        super.init()
    }
    override var description: String{
        return "\(self.value(forKeyPath:"folded") ?? "tst")"
    }
}

