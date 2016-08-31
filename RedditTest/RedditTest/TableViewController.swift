//
//  ViewController.swift
//  RedditTest
//
//  Created by Fabio Bermudez on 29/08/16.
//  Copyright © 2016 Fabio Bermudez. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: BaseViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    
    //MARK: - Outlets

    @IBOutlet weak var table: UITableView!
    
    //MARK: - View Controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.rowHeight = UITableViewAutomaticDimension;
        self.table.estimatedRowHeight = 80;
        self.table.addSubview(self.refreshControl)
    }
    
    override func reloadView() {
        self.table.reloadData()
    }
    
    // MARK: - Table View
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TableViewCell", forIndexPath: indexPath) as! TableViewCell
        let object = dataList[indexPath.row]
        cell.setModel(object,delegate:self)
        return cell
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        let actualPosition = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height - self.table.frame.size.height
        if actualPosition > contentHeight && self.refreshControl.refreshing == false {
            self.requestData()
        }
    }

}
