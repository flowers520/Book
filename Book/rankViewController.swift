//
//  rankViewController.swift
//  Book
//
//  Created by jim on 16/10/13.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class rankViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setUp(){
        
//        let label = UILabel(frame: CGRectMake(0,0,200,20))
//        label.center = self.view.center
//        label.textAlignment = NSTextAlignment.Center
//        label.adjustsFontSizeToFitWidth = true
//        label.text = "哈哈哈，我是老司机。。。"
//        label.font = UIFont(name: MY_FONT, size: 14)
//        label.textColor = UIColor.blackColor()
//        self.view.addSubview(label)
        
//        let arr = UIFont.familyNames()
//        print(arr)
        
//       AVUser.logOut()
        
        if AVUser.currentUser() == nil{
            let story = UIStoryboard(name: "Login", bundle: nil)
            let loginVC = story.instantiateViewControllerWithIdentifier("Login")
            self.presentViewController(loginVC, animated: true, completion: { () -> Void in
                
            })
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
