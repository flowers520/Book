//
//  config.swift
//  Book
//
//  Created by jim on 16/10/13.
//  Copyright © 2016年 jim. All rights reserved.
//

import Foundation

let SCREEN_WIDTH = UIScreen.mainScreen().bounds.width
let SCREEN_HEIGHT = UIScreen.mainScreen().bounds.height

let MAIN_RED = UIColor(colorLiteralRed: 235/255, green: 114/255, blue: 118/255, alpha: 1)
let MainFontColor = UIColor.orangeColor()

let MY_FONT = "Bauhaus ITC"

func RGB(r:Float,g:Float,b:Float)->UIColor{
    return UIColor(colorLiteralRed: r/255.0, green: g/255.0, blue: b/255.0, alpha: 1)

}