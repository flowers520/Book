//
//  GeneralFactory.swift
//  Book
//
//  Created by jim on 16/10/15.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

enum XIncrement{
    case love,cancelLove,scan,discuss
}

class GeneralFactory: NSObject {

    static func addTitleWithTitle(target:UIViewController,title1:String="关闭",title2:String="确认"){
        
        let btn1 = UIButton(frame: CGRectMake(10,20,40,20))
        btn1.setTitle(title1, forState: .Normal)
        btn1.contentHorizontalAlignment = .Left
        btn1.setTitleColor(MAIN_RED, forState: .Normal)
        btn1.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        btn1.tag = 1234
        target.view.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRectMake(SCREEN_WIDTH-50,20,40,20))
        btn2.setTitle(title2, forState: .Normal)
        btn2.contentHorizontalAlignment = .Right
        btn2.setTitleColor(MAIN_RED, forState: .Normal)
        btn2.titleLabel?.font = UIFont(name: MY_FONT, size: 14)
        btn2.tag = 1235
        target.view.addSubview(btn2)
        
        btn1.addTarget(target, action: Selector("close"), forControlEvents: .TouchUpInside)
        btn2.addTarget(target, action: Selector("sure"), forControlEvents: .TouchUpInside)
        
    }
    
    static func addIncrementKey(BookObject:AVObject, type:XIncrement){
        switch type{
        case .love:
            BookObject.incrementKey("loveNumber", byAmount: NSNumber(int: 1))

            break
        case .cancelLove:
            BookObject.incrementKey("loveNumber", byAmount: NSNumber(int: -1))
            break
        case .scan:
            BookObject.incrementKey("scanNumber", byAmount: NSNumber(int: 1))
            break
        case .discuss:
            BookObject.incrementKey("discussNumber", byAmount: NSNumber(int: 1))
            break
        default:
            break
            
        }
        BookObject.saveInBackground()
    }
}
