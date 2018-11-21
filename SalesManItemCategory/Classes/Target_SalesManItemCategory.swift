//
//  Target_SalesManItemCategory.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/20.
//

import UIKit
class Target_SalesManItemCategory : NSObject {
    @objc  func Action_viewController(_ params:[AnyHashable:Any]?) -> UINavigationController{
        let bundle1 = Bundle.init(for: SWViewController.classForCoder())
        let path = bundle1.path(forResource: "SalesManItemCategory", ofType: "bundle")!
        
        let bundle:Bundle = Bundle.init(path:path)!
        let vc:UINavigationController = UIStoryboard.init(name: "Main", bundle: bundle).instantiateInitialViewController() as! UINavigationController
        return vc
    }
}
