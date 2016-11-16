//
//  Push_TitleController.swift
//  Book
//
//  Created by jim on 16/10/21.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

typealias Push_TitleCallBack = (Title: String) -> Void

class Push_TitleController: UIViewController {

    var textField: UITextField?
    var callBack: Push_TitleCallBack?
    /**
     实现回调
     1.Block
     2.Delegate
     3.通知 NsNotification
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.textField = UITextField(frame: CGRectMake(15,60,SCREEN_WIDTH-30,30))
        self.textField?.borderStyle = .RoundedRect
        self.textField?.placeholder = "书评标题"
        self.textField?.font = UIFont(name: MY_FONT, size: 15)
        self.view.addSubview(self.textField!)
        
        self.textField?.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sure(){
        self.callBack!(Title: (self.textField?.text)!)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func close(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
