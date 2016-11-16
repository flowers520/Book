//
//  Push_typeController.swift
//  Book
//
//  Created by jim on 16/10/21.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

typealias Push_typeControllerBlock = (type:String,detailType:String)->Void

class Push_typeController: UIViewController,IGLDropDownMenuDelegate {

    var segmentController1: AKSegmentedControl?
    var segmentController2: AKSegmentedControl?
    
    var literatureArray1: Array<NSDictionary> = []
    var literatureArray2: Array<NSDictionary> = []
    
    var humanitiesArray1: Array<NSDictionary> = []
    var humanitiesArray2: Array<NSDictionary> = []
    
    var livelihoodArray1: Array<NSDictionary> = []
    var livelihoodArray2: Array<NSDictionary> = []

    var economiesArray1: Array<NSDictionary> = []
    var economiesArray2: Array<NSDictionary> = []
    
    var technologyArray1: Array<NSDictionary> = []
    var technologyArray2: Array<NSDictionary> = []
    
    var NetworkArray1: Array<NSDictionary> = []
    var NetworkArray2: Array<NSDictionary> = []
    
    var dropDownMenu1: IGLDropDownMenu?
    var dropDownMenu2: IGLDropDownMenu?
    
    var type = "文学"
    var detailType = "文学"
    var callBack:Push_typeControllerBlock?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = RGB(231, g: 231, b: 231)
        
        let  segmentLabel = UILabel(frame:CGRectMake((SCREEN_WIDTH-300)/2, 20, 300, 20))
        segmentLabel.font = UIFont(name: MY_FONT, size: 17)
        segmentLabel.text = "请选择分数"
        segmentLabel.shadowOffset = CGSizeMake(0,1)
        segmentLabel.shadowColor = UIColor.whiteColor()
        segmentLabel.textColor = RGB(82, g: 113, b: 131)
        segmentLabel.textAlignment = .Center
        self.view.addSubview(segmentLabel)
        
        self.initSegment()
        self.initDropArray()
        self.createDropMenu(self.literatureArray1, array2: self.literatureArray2)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func sure(){
        self.callBack!(type: self.type,detailType: self.detailType)
        self.dismissViewControllerAnimated(true) { () -> Void in            
        }
    }
    
    func close(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    /**
     初始化Array
     */
    func initDropArray(){
        self.literatureArray1 = [
            ["title":"小说"],
            ["title":"漫画"],
            ["title":"青春文学"],
            ["title":"随笔"],
            ["title":"现当代诗"],
            ["title":"戏剧"],
        ];
        self.literatureArray2 = [
            ["title":"传记"],
            ["title":"古诗词"],
            ["title":"外国诗歌"],
            ["title":"艺术"],
            ["title":"摄影"],
        ];
        self.humanitiesArray1 = [
            ["title":"历史"],
            ["title":"文化"],
            ["title":"古籍"],
            ["title":"心理学"],
            ["title":"哲学/宗教"],
            ["title":"政治/军事"],
        ];
        self.humanitiesArray2 = [
            ["title":"社会科学"],
            ["title":"法律"],
        ];
        self.livelihoodArray1 = [
            ["title":"休闲/爱好"],
            ["title":"孕产/胎教"],
            ["title":"烹饪/美食"],
            ["title":"时尚/美妆"],
            ["title":"旅游/地图"],
            ["title":"家庭/家居"],
        ];
        self.literatureArray2 = [
            ["title":"亲子/家教"],
            ["title":"两性关系"],
            ["title":"育儿/早教"],
            ["title":"保健/养生"],
            ["title":"体育/运动"],
            ["title":"手工/DIY"],
        ];
        self.economiesArray1 = [
            ["title":"管理"],
            ["title":"投资"],
            ["title":"理财"],
            ["title":"经济"],
        ];
        self.economiesArray2 = [
            ["title":"没有更多了"],
        ];
        self.technologyArray1 = [
            ["title":"科普读物"],
            ["title":"建筑"],
            ["title":"医学"],
            ["title":"计算机/网络"],
        ];
        self.technologyArray2 = [
            ["title":"农业/林业"],
            ["title":"自然科学"],
            ["title":"工业技术"],
        ];
        self.NetworkArray1 = [
            ["title":"玄幻/奇幻"],
            ["title":"武侠/仙侠"],
            ["title":"都市/职业"],
            ["title":"历史/军事"],
        ];
        self.NetworkArray2 = [
            ["title":"游戏/竞技"],
            ["title":"科幻/灵异"],
            ["title":"言情"],
        ];
    }
     
    /**
    *  初始化segment
    */
    func initSegment(){
        let buttonArray1 = [
            ["image":"ledger","title":"文学","font":MY_FONT],
            ["image":"drama masks","title":"人文社科","font":MY_FONT],
            ["image":"aperture","title":"生活","font":MY_FONT],
        ]
        self.segmentController1 = AKSegmentedControl(frame: CGRectMake(10,60,SCREEN_WIDTH-20,37))
        self.segmentController1?.initButtonWithTitleandImage(buttonArray1)
        self.view.addSubview(self.segmentController1!)
        
        let buttonArray2 = [
            ["image":"atom","title":"经管","font":MY_FONT],
            ["image":"alien","title":"科技","font":MY_FONT],
            ["image":"fire element","title":"网络流行","font":MY_FONT],
        ]
        self.segmentController2 = AKSegmentedControl(frame: CGRectMake(10,60+50,SCREEN_WIDTH-20,37))
        self.segmentController2?.initButtonWithTitleandImage(buttonArray2)
        self.view.addSubview(self.segmentController2!)

        self.segmentController1?.addTarget(self, action: Selector("segmentControllerAction:"), forControlEvents: .ValueChanged)
        self.segmentController2?.addTarget(self, action: Selector("segmentControllerAction:"), forControlEvents: .ValueChanged)
    }
    
    /**
    *  segment的点击事件
    */
    
    func segmentControllerAction(segment: AKSegmentedControl){
        var index = segment.selectedIndexes.firstIndex
        self.type = ((segment.buttonsArray[index] as? UIButton)?.currentTitle)!
        
        print(index)
        if segment == self.segmentController1{
            self.segmentController2?.setSelectedIndex(3)
        }else{
            self.segmentController1?.setSelectedIndex(3)
            index += 3
        }
        
        if self.dropDownMenu1 != nil{
            self.dropDownMenu1?.resetParams()
        }
        if self.dropDownMenu2 != nil{
            self.dropDownMenu2?.resetParams()
        }
        
        switch (index){
        case 0:
            self.createDropMenu(self.literatureArray1, array2: self.literatureArray2)
            break
        case 1:
            self.createDropMenu(self.humanitiesArray1, array2: self.humanitiesArray2)
            break
        case 2:
            self.createDropMenu(self.livelihoodArray1, array2: self.livelihoodArray2)
            break
        case 3:
            self.createDropMenu(self.economiesArray1, array2: self.economiesArray2)
            break
        case 4:
            self.createDropMenu(self.technologyArray1, array2: self.technologyArray2)
            break
        case 5:
            self.createDropMenu(self.NetworkArray1, array2: self.NetworkArray2)
            break
        default:
            break
            
        }
    }
    
    /**
     初始化dropDownMenu
     */
    func createDropMenu(array1:Array<NSDictionary>,array2:Array<NSDictionary>){
        let dropDownItem1 = NSMutableArray()
        for var i=0;i<array1.count;i++ {
            let dict = array1[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem1.addObject(item)
        }
        let dropDownItem2 = NSMutableArray()
        for var i=0;i<array2.count;i++ {
            let dict = array2[i]
            let item = IGLDropDownItem()
            item.text = dict["title"] as? String
            dropDownItem2.addObject(item)
        }
        
        self.dropDownMenu1?.removeFromSuperview()
        self.dropDownMenu1 = IGLDropDownMenu()
        self.dropDownMenu1?.menuText = "点我。展开详细列表"
        self.dropDownMenu1?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu1?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        self.dropDownMenu1?.paddingLeft = 15
        self.dropDownMenu1?.delegate = self
        self.dropDownMenu1?.type = .Stack
        self.dropDownMenu1?.itemAnimationDelay = 0.1
        self.dropDownMenu1?.gutterY = 5
        self.dropDownMenu1?.dropDownItems = dropDownItem1 as [AnyObject]
        self.dropDownMenu1?.frame = CGRectMake(20,150,SCREEN_WIDTH/2-30,(SCREEN_HEIGHT-200)/7)
        self.view.addSubview(self.dropDownMenu1!)
        self.dropDownMenu1?.reloadView()
        
        self.dropDownMenu2?.removeFromSuperview()
        self.dropDownMenu2 = IGLDropDownMenu()
        self.dropDownMenu2?.menuText = "点我。展开详细列表"
        self.dropDownMenu2?.menuButton.textLabel.adjustsFontSizeToFitWidth = true
        self.dropDownMenu2?.menuButton.textLabel.textColor = RGB(38, g: 82, b: 67)
        self.dropDownMenu2?.paddingLeft = 15
        self.dropDownMenu2?.delegate = self
        self.dropDownMenu2?.type = .Stack
        self.dropDownMenu2?.itemAnimationDelay = 0.1
        self.dropDownMenu2?.gutterY = 5
        self.dropDownMenu2?.dropDownItems = dropDownItem2 as [AnyObject]
        self.dropDownMenu2?.frame = CGRectMake(SCREEN_WIDTH/2+10,150,SCREEN_WIDTH/2-30,(SCREEN_HEIGHT-200)/7)
        self.view.addSubview(self.dropDownMenu2!)
        self.dropDownMenu2?.reloadView()
    }
    
    /**
    *  IGLDropDownMenuDelegate
    */
    func dropDownMenu(dropDownMenu: IGLDropDownMenu!, selectedItemAtIndex index: Int) {
        if dropDownMenu == self.dropDownMenu1 {
            print("dropDownMenu1")
            let item = self.dropDownMenu1?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu2?.menuButton.text = self.detailType
        }else{
            print("dropDownMenu2")
            let item = self.dropDownMenu2?.dropDownItems[index] as? IGLDropDownItem
            self.detailType = (item?.text)!
            self.dropDownMenu1?.menuButton.text = self.detailType
        }
    }
}
