//
//  SWTableView.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit
protocol SWTableViewDelegate{
    func tableViewDidSelecteRowAtIndex(indexPath:IndexPath,dataSource:NSArray?)
}
class SWTableView: UITableView {
    internal var dataSourceArray:NSArray? = nil
    public var actionDelegate : SWTableViewDelegate?

    override func awakeFromNib() {
        self.delegate = self
        self.dataSource = self
    }
    public func showContentWith(valueArray:NSArray){
        self.dataSourceArray = valueArray
        self.reloadData()
        self.selectRow(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: .top)
        self.selecteRowAtIndexPath(indexPath: IndexPath.init(row: 0, section: 0))
    }
    private func selecteRowAtIndexPath(indexPath:IndexPath) {
        let category:SWCateogryItem = self.dataSourceArray![indexPath.row] as! SWCateogryItem
        actionDelegate?.tableViewDidSelecteRowAtIndex(indexPath: indexPath,dataSource: category.childs)
    }
}

//MARK:UITableview Delegate & DataSource
extension SWTableView:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSourceArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:SWTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! SWTableViewCell
        let category:SWCateogryItem = self.dataSourceArray![indexPath.row] as! SWCateogryItem
        cell.showContent(title:category.name!)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selecteRowAtIndexPath(indexPath: indexPath)
    }
}

