//
//  SWTableViewCell.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit

class SWTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.standardizeStyle(selected: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.standardizeStyle(selected: selected)
    }
    
    func showContent(title:String) {
        self.titleLabel.text = title
    }
    
    private func standardizeStyle(selected:Bool){
        self.selectionStyle = .none
        self.contentView.backgroundColor = selected ? UIColor.white : UIColor.clear
        self.imgView.backgroundColor = selected ? UIColor.swThemeColor() :UIColor.clear
        self.titleLabel.textColor = selected ? UIColor.swThemeColor() : UIColor.lightGray
        self.titleLabel.font = selected ? UIFont.boldSystemFont(ofSize: 14):UIFont.systemFont(ofSize: 14)
        self.titleLabel.textAlignment = selected ? .center : .left
    }
}
