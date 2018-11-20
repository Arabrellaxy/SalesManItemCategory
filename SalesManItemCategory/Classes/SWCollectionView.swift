//
//  SWCollectionView.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit
protocol SWCollectionViewDelegate{
    func collectionViewExpendSectionAt(section:NSInteger)
}

class SWCollectionView: UICollectionView {
    internal var dataSourceArray:NSArray? = nil
    public var actionDelegate : SWCollectionViewDelegate?

    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
        
    }
    public func showContentWith(dataSource:NSArray?) {
        self.dataSourceArray = dataSource
        self.reloadData()
    }
}
//MARK:Private
extension SWCollectionView {
    func thirdCategoryOf(second:SWCateogryItem) -> NSArray? {
        var thirdCategory:NSArray?
        thirdCategory = second.childs
        return thirdCategory
    }
}
extension SWCollectionView:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.dataSourceArray?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let secondCategory:SWCateogryItem = self.dataSourceArray![section] as! SWCateogryItem
        let folded:Bool = secondCategory.folded
        
        return folded ? 0 : self.thirdCategoryOf(second: secondCategory )?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SWCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SWCollectionViewCell
        let secondCategory:SWCateogryItem = self.dataSourceArray![indexPath.section] as! SWCateogryItem
        let thirdCateogryArray:NSArray = self.thirdCategoryOf(second: secondCategory)!
        let thirdCategoryAtIndexPath:SWCateogryItem = thirdCateogryArray[indexPath.row] as! SWCateogryItem
        cell.showContent(title: thirdCategoryAtIndexPath.name!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header:SWCollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SWCollectionReusableView
        let secondCategory:SWCateogryItem = self.dataSourceArray![indexPath.section] as! SWCateogryItem
        header.actionDelegate = self
        header.showCategoryTitle(title: secondCategory.name!,folded:secondCategory.folded)
        header.tag = indexPath.section
        return header
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: collectionView.bounds.size.width / 3, height: 40)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: collectionView.bounds.size.width, height: 50)
    }
}

extension SWCollectionView:SWCollectionReusableViewDelegate {
    func foldCell(header: SWCollectionReusableView) {
        self.actionDelegate?.collectionViewExpendSectionAt(section: header.tag)
    }
}
