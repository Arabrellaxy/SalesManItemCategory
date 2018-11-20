//
//  SWCollectionViewCell.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit

class SWCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        self.nameLabel.textColor = UIColor.swCategoryGreyTextColor()
        self.nameLabel.font = UIFont.systemFont(ofSize: 14)
        self.nameLabel.numberOfLines = 2
    }
    public  func showContent(title:String){
        self.nameLabel.text = title
    }
}
