
//
//  pushBook.swift
//  Book
//
//  Created by jim on 16/10/26.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class pushBook: NSObject {
    static func pushBookInBack(dict:NSDictionary, object:AVObject){

        object.setObject(dict["BookName"], forKey: "BookName")
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        object.setObject(dict["title"], forKey: "title")
        object.setObject(dict["score"], forKey: "score")
        object.setObject(dict["type"], forKey: "type")
        object.setObject(dict["detailType"], forKey: "detailType")
        object.setObject(dict["description"], forKey: "description")
        object.setObject(AVUser.currentUser(), forKey: "user")
        let image = dict["BookCover"] as? UIImage
        let coverFile = AVFile(data: UIImagePNGRepresentation(image!))
        coverFile.saveInBackgroundWithBlock { (success, error) -> Void in
            if success {
                object.setObject(coverFile, forKey: "cover")
                object.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success {
                        NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotifition", object: nil, userInfo: ["success":"true"])
                    }else{
                        NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotifition", object: nil, userInfo:  ["success":"true"])
                    }
                })
            }else{
                NSNotificationCenter.defaultCenter().postNotificationName("pushBookNotifition", object: nil, userInfo: ["success":"false"])
            }
        }
        
    }
}
