//
//  BookDetailViewController.swift
//  Book
//
//  Created by jim on 16/11/10.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController,BookTabBarDelegate{

    var BookObject:AVObject!
    var BookTitleView:BookDetailView!
    var BookViewTabbar:BookTabBar!
    var BookTextView:UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.navigationController?.navigationBar.tintColor = UIColor.grayColor()
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: .Default)
        
        self.initBooKDetailView()
        
        self.BookViewTabbar = BookTabBar(frame: CGRectMake(0,SCREEN_HEIGHT-40,SCREEN_WIDTH,40))
        self.view.addSubview(self.BookViewTabbar)
        self.BookViewTabbar.delegate = self
        
        self.BookTextView = UITextView(frame: CGRectMake(0,64+SCREEN_HEIGHT/4,SCREEN_WIDTH,SCREEN_HEIGHT-64-SCREEN_HEIGHT/4-40))
        self.BookTextView.editable = false
        self.BookTextView.text = self.BookObject!["description"] as? String
        self.view.addSubview(self.BookTextView)
        
    }

    /**
    *  初始化BookDetailView
    */
    func initBooKDetailView(){
        self.BookTitleView = BookDetailView(frame: CGRectMake(0,64,SCREEN_WIDTH,SCREEN_HEIGHT/4))
        self.view.addSubview(BookTitleView)
        
        let coverFile = self.BookObject["cover"] as! AVFile
        self.BookTitleView.cover.sd_setImageWithURL(NSURL(string: (coverFile.url)), placeholderImage: UIImage(named: "Cover"))
        
        self.BookTitleView.BookName.text = "《"+(self.BookObject["BookName"] as! String)+"》"
        self.BookTitleView.Editor.text = "作者:"+(self.BookObject["BookEditor"] as! String)
        
        let user = self.BookObject["user"] as! AVUser
        user.fetchInBackgroundWithBlock { (returnUser, error) -> Void in
            self.BookTitleView.userName.text = "编者:"+(returnUser as! AVUser).username
        }
        let date = self.BookObject["createdAt"] as! NSDate
        let format = NSDateFormatter()
        format.dateFormat = "yy-MM-dd"
        self.BookTitleView.date.text = format.stringFromDate(date)
        
        let scoreString = self.BookObject["score"] as! String
        self.BookTitleView.score.show_star = Int(scoreString)!
        
        self.BookTitleView.more.text = "70个喜欢.5次评论.12000次浏览"
    }
    
    /**
    *  BookViewDelegate
    */
    func comment() {
        print("comment")
    }
    
    func commentController() {
        print("commentController")
    }
    func likeBook() {
        print("likeBook")
    }
    func sharAction() {
        print("sharAction")
    }


}
