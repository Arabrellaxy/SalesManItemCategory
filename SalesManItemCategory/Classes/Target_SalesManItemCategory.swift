//
//  Target_SalesManItemCategory.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/20.
//

import UIKit

class Target_SalesManItemCategory : NSObject {
    @objc  func Action_viewController(_ params:[AnyHashable:Any]?) -> UIViewController{
        let bundle1 = Bundle.init(for: SWViewController.classForCoder())
        let path = bundle1.path(forResource: "SalesManItemCategory", ofType: "bundle")!
        
        let bundle:Bundle = Bundle.init(path:path)!
        let vc:SWViewController = UIStoryboard.init(name: "Main", bundle: bundle).instantiateViewController(withIdentifier: "category") as! SWViewController
        return vc
    }
}
