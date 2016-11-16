//
//  pushViewController.swift
//  Book
//
//  Created by jim on 16/10/13.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class pushViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArray = NSMutableArray()
    var tableView: UITableView!
    var navigationView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.setNavigationBar()
        
        self.tableView = UITableView(frame: self.view.frame)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.registerClass(pushBook_Cell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView()
        
        self.tableView.mj_header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: Selector("headerRefresh"))
        self.tableView.mj_footer = MJRefreshAutoNormalFooter(refreshingTarget: self, refreshingAction: Selector("footerRefresh"))
        self.tableView.mj_header.beginRefreshing()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        self.navigationView.hidden = false
    }
    
    override func viewDidDisappear(animated: Bool) {
        self.navigationView.hidden = true
    }

    func setNavigationBar(){
        navigationView = UIView(frame:CGRectMake(0,-20,SCREEN_WIDTH,65))
        navigationView.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.addSubview(navigationView)
        
        let addBookBtn = UIButton(frame: CGRectMake(20,20,SCREEN_WIDTH,45))
        addBookBtn.setImage(UIImage(named: "plus circle"), forState: .Normal)
        addBookBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
        addBookBtn.setTitle("    新建书评", forState: .Normal)
        addBookBtn.titleLabel?.font = UIFont(name: MY_FONT, size: 15)
        addBookBtn.contentHorizontalAlignment = .Left //按钮文字现实朋友
        addBookBtn.addTarget(self, action: Selector("pushNewBook"), forControlEvents: .TouchUpInside)
        navigationView.addSubview(addBookBtn)
        
    }

    func pushNewBook(){
        let vc = pushNewBookController()
        GeneralFactory.addTitleWithTitle(vc, title1: "关闭", title2: "发布")
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    /**
    *  UIableViewDelegate UItTableViewDataSouce
    */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 88
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as? pushBook_Cell
        let dict = self.dataArray[indexPath.row] as? AVObject
        cell?.BookName.text = " 《"+(dict!["BookName"] as! String)+"》:"+(dict!["title"] as! String)
        cell?.Editor.text = "作者:"+(dict!["BookEditor"] as! String)
        
        let date = dict!["createdAt"] as? NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yyyy-MM-dd hh:mm"
        cell?.more.text = format.stringFromDate(date!)
        
        let coverFile = dict!["cover"] as? AVFile
        cell?.cover.sd_setImageWithURL(NSURL(string: (coverFile?.url)!), placeholderImage: UIImage(named: "Cover"))
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let vc = BookDetailViewController()
        vc.BookObject = self.dataArray[indexPath.row] as! AVObject
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /**
    *  上拉加载，下拉加载
    */
    
    func headerRefresh(){
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = 0
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView.mj_footer.endRefreshing()
            self.dataArray.addObjectsFromArray(results)
            self.tableView.reloadData()
        }
    }
    func footerRefresh(){
        let query = AVQuery(className: "Book")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.skip = self.dataArray.count
        query.whereKey("user", equalTo: AVUser.currentUser())
        query.findObjectsInBackgroundWithBlock { (results, error) -> Void in
            self.tableView.mj_footer.endRefreshing()
            self.dataArray.addObjectsFromArray(results)
            self.tableView.reloadData()
        }

    }
}
