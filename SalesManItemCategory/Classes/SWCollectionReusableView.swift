//
//  SWCollectionReusableView.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit
protocol SWCollectionReusableViewDelegate {
    func foldCell(header:SWCollectionReusableView) -> Void
}
class SWCollectionReusableView: UICollectionReusableView {
    public var actionDelegate : SWCollectionReusableViewDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var foldBtn: UIButton!
    override func awakeFromNib() {
        self.titleLabel.textColor = UIColor.swColorWithHexValue(hexValue: 0x4c4c4c)
        self.foldBtn.addTarget(self, action: #selector(foldBtnAction), for: .touchUpInside)
//        self.foldBtn.setImage(UIImage.imageNamed(name:"icon_customer_up", classCoder: self.classForCoder, bundleName: bundleName), for: .normal)
    }
    public func showCategoryTitle(title:String,folded:Bool){
        self.titleLabel.text = title
        self.foldBtn.setImage(UIImage.imageNamed(name: folded ? "icon_customer_down" :"icon_customer_up", classCoder: self.classForCoder, bundleName: bundleName), for: .normal)
    }
    
    //    MARK:Action
    @objc func foldBtnAction(){
//        self.foldBtn.isSelected = !self.foldBtn.isSelected
//        let selected =  self.foldBtn.isSelected
//        self.foldBtn.setImage(UIImage.imageNamed(name: selected ? "icon_customer_down" :"icon_customer_up", classCoder: self.classForCoder, bundleName: bundleName), for: .normal)
        actionDelegate?.foldCell(header: self)
    }
}
