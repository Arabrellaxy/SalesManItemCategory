//
//  SWAPIReformer.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit
import SalesManNetwork
class SWAPIReformer: NSObject {
   private(set) var dataSourceArray:NSArray? = nil
    private(set) var originData:NSDictionary? = nil

    func reformWithResponse(value:NSDictionary) -> (String?,[SWCateogryItem]?) {
        var failureMsg:String?
        let success:Bool = value.object(forKey: SWGlobal.status) as! Bool
        if success {
            self.originData = value
            let originCategoryData:NSArray = (value.object(forKey: "data") as! NSDictionary).object(forKey: "data") as! NSArray
             dataSourceArray = self.analysisResultByResult(array: originCategoryData)
        } else {
            failureMsg = (value[SWGlobal.message] as? String) ?? "请求失败"
        }
        return(failureMsg,dataSourceArray as? [SWCateogryItem])
    }
    func foldedStatusChangedAt(row:NSInteger,section:NSInteger,completion:(_ result:NSArray)->()) {
        let firstCategoryArray :NSMutableArray = NSMutableArray.init(array: (self.dataSourceArray![row] as! SWCateogryItem).childs!)
        let secondCategoryAtSection:SWCateogryItem = firstCategoryArray[section] as! SWCateogryItem
        secondCategoryAtSection.folded = !secondCategoryAtSection.folded
        firstCategoryArray[section] = secondCategoryAtSection
        let tempDataSourceArray :NSMutableArray = NSMutableArray.init(array: self.dataSourceArray!)
        (tempDataSourceArray[row] as! SWCateogryItem).childs = firstCategoryArray
        self.dataSourceArray = tempDataSourceArray
        completion(firstCategoryArray)
    }
    private func analysisResultByResult(array:NSArray)->NSArray?{
        var tempMutableArray:NSMutableArray? = nil
        for  tempCategory  in array {
            let tempCategoryItem:SWCateogryItem = SWCateogryItem.init()
            tempCategoryItem.name = (tempCategory as! NSDictionary).object(forKey: "name") as? String
            tempCategoryItem.categoryID = (tempCategory as! NSDictionary).object(forKey: "id") as? Int ?? 0
            let tempChilds:NSArray? = (tempCategory as! NSDictionary).object(forKey: "childs") as? NSArray
            if let _ = tempChilds {
                tempCategoryItem.childs = self.analysisResultByResult(array: tempChilds!)
            }
            if tempMutableArray == nil {
                tempMutableArray = NSMutableArray.init()
            }
            tempMutableArray?.add(tempCategoryItem)
        }
        return tempMutableArray?.copy() as? NSArray ?? nil
    }
    
}
