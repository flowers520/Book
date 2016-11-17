//
//  commentViewController.swift
//  Book
//
//  Created by jim on 16/11/18.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class commentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        let btn = self.view.viewWithTag(1234)
        btn?.hidden = true
        
        let titleLabel = UILabel(frame: CGRectMake(0,20,SCREEN_WIDTH,44))
        titleLabel.text = "讨论区"
        titleLabel.font = UIFont(name: MY_FONT, size: 17)
        titleLabel.textAlignment = .Center
        titleLabel.textColor = MAIN_RED
        self.view.addSubview(titleLabel)
    
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sure(){
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }


}
