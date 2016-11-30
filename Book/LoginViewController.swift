//
//  LoginViewController.swift
//  Book
//
//  Created by jim on 16/10/24.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var topLayout: NSLayoutConstraint!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var username: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        XKeyBoard.registerKeyBoardHide(self)
        XKeyBoard.registerKeyBoardShow(self)
    }


    @IBAction func login(sender: AnyObject) {
        AVUser.logInWithUsernameInBackground(self.username.text, password: self.password.text) { (user, error) -> Void in
            if error == nil{
                self.dismissViewControllerAnimated(true, completion: nil)
            }else{
                if error.code == 210{
                    ProgressHUD.showError("用户名或密码错误")
                }else if error.code == 211{
                    ProgressHUD.showError("不存在该用户")
                }else if error.code == 216{
                    ProgressHUD.showError("未验证邮箱")
                }else if error.code == 1{
                    ProgressHUD.showError("操作频繁")
                }else{
                    ProgressHUD.showError("登录失败")
                }
            }
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch: AnyObject in touches{
            let t: UITouch = touch as! UITouch
            if(t.tapCount == 1){
                username.resignFirstResponder()
                password.resignFirstResponder()
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
