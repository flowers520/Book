
//
//  BookTitleView.swift
//  Book
//
//  Created by jim on 16/10/17.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

@objc protocol BookTitleDelegate{
    optional func choiceCover()
}

class BookTitleView: UIView {
    
    var BookCover: UIButton?
    var BooKName: JVFloatLabeledTextField?
    var BookEdite: JVFloatLabeledTextField?
    //弱引用
    weak var delegate: BookTitleDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.BookCover = UIButton(frame: CGRectMake(10,0,110,141))
        self.BookCover?.setImage(UIImage(named: "Cover"), forState: .Normal)
        self.addSubview(self.BookCover!)
        self.BookCover?.addTarget(self, action: Selector("choiceCover"), forControlEvents: .TouchUpInside)
        
        self.BooKName = JVFloatLabeledTextField(frame: CGRectMake(120,8+40,SCREEN_WIDTH-120-5,30))
        self.BookEdite = JVFloatLabeledTextField(frame: CGRectMake(120,8+70+40,SCREEN_WIDTH-120-15,30))
        
        self.BooKName?.placeholder = "书名"
        self.BookEdite?.placeholder = "作者"
        
        self.BooKName?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        self.BookEdite?.floatingLabelFont = UIFont(name: MY_FONT, size: 14)
        
        self.addSubview(self.BooKName!)
        self.addSubview(self.BookEdite!)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func choiceCover(){
        self.delegate?.choiceCover?()
    }
}
