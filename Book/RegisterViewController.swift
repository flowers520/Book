//
//  RegisterViewController.swift
//  Book
//
//  Created by jim on 16/10/24.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
    }

    @IBAction func register(sender: AnyObject) {
        let user = AVUser()
        user.username = self.username.text
        user.password = self.password.text
        user.email = self.email.text
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                ProgressHUD.showSuccess("注册成功，请验证邮箱")
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                if error.code == 125{
                    ProgressHUD.showError("邮箱不合法")
                }else if error.code == 203{
                    ProgressHUD.showError("该邮箱已注册")
                }else if error.code == 202{
                    ProgressHUD.showError("用户名已经存在")
                }else{
                    ProgressHUD.showError("注册失败")
                }
            }
        }
    }
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let t:UITouch = touch as! UITouch
            if(t.tapCount == 1){
                email.resignFirstResponder()
                password.resignFirstResponder()
                username.resignFirstResponder()
            }
        }
    }
    
    /**
     注册键盘出现和消失
     */
    func keyboardWillHideNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.topLayout.constant = 8
            self.view.layoutIfNeeded()
        }
    }
    func keyboardWillShowNotification(notification:NSNotification){
        UIView.animateWithDuration(0.3) { () -> Void in
            self.topLayout.constant = -200
            self.view.layoutIfNeeded()
        }
    }
}
