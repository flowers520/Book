//
//  Push_DescriptionController.swift
//  Book
//
//  Created by jim on 16/10/21.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

typealias Push_DescriptionControllerBlock=(description:String)->Void

class Push_DescriptionController: UIViewController {

    var textView: JVFloatLabeledTextView?
    var callBack: Push_DescriptionControllerBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
       
        self.textView = JVFloatLabeledTextView(frame: CGRectMake(8, 58, SCREEN_WIDTH-8-8, SCREEN_HEIGHT-50-8))
        self.view.addSubview(self.textView!)
        self.textView?.placeholder = "    你可以在这里撰写详细的评价、吐槽、介绍~~"
        self.view.tintColor = UIColor.grayColor()
        self.textView?.becomeFirstResponder()
        
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sure(){
        self.callBack!(description:(self.textView?.text)!)
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    func close(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    /**
    *  键盘遮挡
    */
    func keyboardWillHideNotification(notification:NSNotification){
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func keyboardWillShowNotification(notification:NSNotification){
        let rect = XKeyBoard.returnKeyBoardWindow(notification)
        self.textView?.contentInset = UIEdgeInsetsMake(0, 0, rect.size.height, 0)
    }
}
