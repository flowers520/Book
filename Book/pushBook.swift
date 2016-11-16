
//
//  pushBook.swift
//  Book
//
//  Created by jim on 16/10/26.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class pushBook: NSObject {
    static func pushBookInBack(dict:NSDictionary){
        let object = AVObject(className: "Book")
        /**
        *              
        "BookName":(self.BookTitle?.BooKName?.text)!,
        "BookEditor":(self.BookTitle?.BookEdite?.text)!,
        "BookCover":(self.BookTitle?.BookCover?.currentImage)!,
        "title":self.Book_Title,
        "score":String((self.Score?.show_score)!),
        "type":self.type,
        "detaileType":self.detailType,
        "descrition":self.Book_Description
        */
        object.setObject(dict["BookName"], forKey: "BookName")
        object.setObject(dict["BookEditor"], forKey: "BookEditor")
        object.setObject(dict["title"], forKey: "title")
        object.setObject(dict["score"], forKey: "score")
        object.setObject(dict["type"], forKey: "type")
        object.setObject(dict["detaileType"], forKey: "detaileType")
        object.setObject(dict["descrition"], forKey: "descrition")
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
