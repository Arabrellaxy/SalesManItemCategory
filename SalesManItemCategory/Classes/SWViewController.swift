//
//  SWViewController.swift
//  SalesManItemCategory
//
//  Created by 谢艳 on 2018/11/19.
//

import UIKit
import SalesManNetwork
import SalesManGlobal
 public class SWViewController: UIViewController,UISearchBarDelegate {
    @IBOutlet weak var tableView: SWTableView!
    @IBOutlet weak var collectionView: SWCollectionView!
     var searchBar: UISearchBar!
    var apiReformer:SWAPIReformer?
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.requestData()
        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.swCategoryGreyColor()
        self.tableView.actionDelegate = self
        self.collectionView.actionDelegate = self
        self.searchBar = UISearchBar.init(frame: CGRect(x:0,y:0,width:self.view.frame.size.width,height:44))
        self.navigationController?.navigationBar.barTintColor = UIColor.swThemeColor()
        self.searchBar.returnKeyType = .done
        self.searchBar.delegate = self
        self.searchBar.placeholder = "请输入关键字搜索"
        self.searchBar.tintColor = UIColor.gray
        let searchField:UITextField? = self.searchBar.value(forKey: "searchField") as? UITextField
        if #available(iOS 11.0, *) {
            searchField!.layer.cornerRadius = 18;
            searchField!.layer.masksToBounds = true;
        }
        guard #available(iOS 8, *) else {
            searchField!.layer.cornerRadius = 14;
            searchField!.layer.masksToBounds = true;
            return
        }
        self.navigationItem.titleView = self.searchBar
    }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override public func awakeFromNib() {
      
    }
    
}

//MARK:Network
extension SWViewController{
    func requestData() ->()  {
        self.view.showLoadingHud(loadingText: "正在请求数据")
        let callBack = { (responseDic : NSDictionary)  in
            self.view.hideHud()
            let status = responseDic.object(forKey: SWGlobal.status) as? Bool
            guard let _ = status else {
                return
            }
            if status! {
                    self.apiReformer = SWAPIReformer()
                    let (failureMessage,resultArray) = (self.apiReformer?.reformWithResponse(value: responseDic))!
                    if failureMessage != nil {
                        self.view.showTextHud(text: failureMessage!, autoHide: true)
                    } else {
                        self.tableView.showContentWith(valueArray: (resultArray! as NSArray))
                    }
            } else {
                let message = responseDic.object(forKey: SWGlobal.message) as? String ?? "数据加载失败,请重试"
                self.view.showTextHud(text: message, autoHide: true)
            }
        }
        SalesManAFNetworkAPI.shareInstance.requestItemCategory(completion: callBack)
    }
}
//MARK:TableView & Collection Delegate
extension SWViewController:SWTableViewDelegate,SWCollectionViewDelegate{
    func collectionViewExpendSectionAt(section: NSInteger) {
        self.apiReformer?.foldedStatusChangedAt(row: (self.tableView.indexPathForSelectedRow?.row)!, section: section, completion: { (array) in
            self.collectionView.showContentWith(dataSource: array)
        })
    }
    
    func tableViewDidSelecteRowAtIndex(indexPath: IndexPath, dataSource: NSArray?) {
        self.collectionView.showContentWith(dataSource: dataSource)
    }
}
