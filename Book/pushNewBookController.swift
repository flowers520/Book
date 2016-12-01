//
//  pushNewBookController.swift
//  Book
//
//  Created by jim on 16/10/15.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class pushNewBookController: UIViewController ,BookTitleDelegate,PhotoPickerDelegate,VPImageCropperDelegate,UITableViewDataSource,UITableViewDelegate{
    
    var BookTitle: BookTitleView?
    var tableView: UITableView?
    var titleArray: Array<String> = []
    var Book_Title=""
    var Score: LDXScore?
    
    var type="文学"
    var detailType="小说"
    var Book_Description=""
/// 编辑
    var bookObject:AVObject!
    var fixType: String = ""
    
    
    /**
     表示是否显示星星
     */
    var showScore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.BookTitle = BookTitleView(frame: CGRectMake(0,40,SCREEN_WIDTH,160))
        self.BookTitle?.delegate = self
        self.view.addSubview(self.BookTitle!)
        
        self.tableView = UITableView(frame: CGRectMake(0, 200, SCREEN_WIDTH, SCREEN_HEIGHT-200), style: .Grouped)
        /*
            使没有内容的线条消失
        */
        self.tableView!.tableFooterView = UIView()
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        self.tableView!.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "cell")
        self.tableView!.backgroundColor = UIColor(colorLiteralRed: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.view.addSubview(self.tableView!)
        
        self.titleArray = ["标题","评分","分类","书评"]
        
        self.Score = LDXScore(frame: CGRectMake(100,10,100,22))
        self.Score?.isSelect = true
        self.Score?.normalImg = UIImage(named: "btn_star_evaluation_normal")
        self.Score?.highlightImg = UIImage(named: "btn_star_evaluation_press")
        self.Score?.max_star = 5
        self.Score?.show_star = 5
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("pushBookNotifition:"), name: "pushBookNotifition", object: nil)

    }
    
    /**
     编辑
     */
    func fixBook(){
        if self.fixType == "fix"{
            self.BookTitle?.BooKName?.text = self.bookObject["BookName"] as! String
            self.BookTitle?.BookEdite?.text = self.bookObject["BookEditor"] as! String
            let coverFile = self.bookObject["cover"] as! AVFile
            coverFile.getDataInBackgroundWithBlock({ (data, error) -> Void in
                self.BookTitle?.BookCover?.setImage(UIImage(data: data), forState: .Normal)
            })
            self.Book_Title = self.bookObject["title"] as! String
            self.type = self.bookObject["type"] as! String
            self.detailType = self.bookObject["detailType"] as! String
            self.Book_Description = self.bookObject["description"] as! String
            self.Score?.show_star = (Int)(self.bookObject["score"] as! String)!
            if self.Book_Description != ""{
                self.titleArray.append("")
            }
        }
    }
    
    /**
     析构函数
     */
    deinit{
        print("pushNewBookController reallse")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    /**
     pushCallBack
     */
    func pushCallBack(notification: NSNotification){
        let dict = notification.userInfo
        if String(dict!["success"]) == "true"{
            if self.fixType == "fix"{
                ProgressHUD.showSuccess("修改成功")
            }else{
                ProgressHUD.showSuccess("上传成功")
            }
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            ProgressHUD.showSuccess("上传失败")
        }
        
    }
    /**
     pushBookNotifition
     */
    func pushBookNotifition(notifition:NSNotification){
        let dict = notifition.userInfo
        print("\(dict!["success"]!)..................")
        if String(dict!["success"]!) == "true"{
            ProgressHUD.showSuccess("上传成功")
            self.dismissViewControllerAnimated(true, completion: nil)
        }else{
            ProgressHUD.showError("上传失败")
        }
    }
    /*
    BookTitleDelegate
    */

    func choiceCover() {
        let vc = PhotoPickerViewController()
        vc.delegate = self
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    /*
        PhotoPickerDelegate
    */
    func getImageFramePicker(image: UIImage) {
        let CroVC = VPImageCropperViewController(image: image, cropFrame: CGRectMake(0, 100, SCREEN_WIDTH, SCREEN_HEIGHT*1.273), limitScaleRatio: 3)
        CroVC.delegate = self
        self.presentViewController(CroVC, animated: true, completion: nil)
    }
    
    func close(){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func sure(){
        print("///////\(String((self.Score?.show_star)!))")
        let dict = [
            "BookName":(self.BookTitle?.BooKName?.text)!,
            "BookEditor":(self.BookTitle?.BookEdite?.text)!,
            "BookCover":(self.BookTitle?.BookCover?.currentImage)!,
            "title":self.Book_Title,
            "score":String((self.Score?.show_star)!),
            "type":self.type,
            "detailType":self.detailType,
            "description":self.Book_Description
        ]
        print("///////\(String((self.Score?.show_score)!))")
        
        ProgressHUD.show("")
        if self.fixType == "fix"{
            pushBook.pushBookInBack(dict, object: self.bookObject!)
        }else{
            let object = AVObject(className: "Book")
            pushBook.pushBookInBack(dict, object: object)
        }

    }

    /*
        VPImageDelegate
    */
    
    func imageCropperDidCancel(cropperViewController: VPImageCropperViewController!) {
        cropperViewController.dismissViewControllerAnimated(true, completion: nil)
    }

    func imageCropper(cropperViewController: VPImageCropperViewController!, didFinished editedImage: UIImage!) {
        self.BookTitle?.BookCover?.setImage(editedImage, forState: .Normal)
        cropperViewController.dismissViewControllerAnimated(true, completion: nil)
    }
    
   /*
        UITableViewDelegate && UItableViewDataSource
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.titleArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "cell")
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        //右边箭头
        if(indexPath.row != 1){
            cell.accessoryType = .DisclosureIndicator
        }
        cell.textLabel?.text = self.titleArray[indexPath.row]
        cell.textLabel?.font = UIFont(name: MY_FONT, size: 15)
        cell.detailTextLabel?.font = UIFont(name: MY_FONT, size: 13)
        
        var row = indexPath.row
        if self.showScore && row>1 {
            row--
        }
        
        switch row {
        case 0:
            cell.detailTextLabel?.text = self.Book_Title
            break
        case 2:
            cell.detailTextLabel?.text = self.type+"->"+self.detailType
            break
        case 4:
            cell.accessoryType = .None
            let commentView = UITextView(frame: CGRectMake(4, 4, SCREEN_WIDTH-4-4, 80))
            commentView.text = self.Book_Description
            commentView.font = UIFont(name: MY_FONT, size: 14)
            commentView.editable = false
            cell.contentView.addSubview(commentView)
            break
        default:
            break
        }
        /**
        判断是否在第二行添加小星星
        */
        if self.showScore && indexPath.row == 2{
            cell.contentView.addSubview(self.Score!)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if showScore && indexPath.row>=5 {
            return 88
        }else if !self.showScore && indexPath.row>=4 {
            return 88
        }else{
            return 44
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView?.deselectRowAtIndexPath(indexPath, animated: true)
        var row = indexPath.row
        if self.showScore && row==1{
            row -= 1
        }
        switch indexPath.row{
        case 0:
            self.tableViewSelectTitle()
            break
        case 1:
            self.tableViewSelectScore()
            break
        case 2:
            self.tableViewSelectType()
            break
        case 3:
            self.tableviewSelectDescription()
            break
        default:
            break
        }
    }
     
    /*
        选择标题
    */
    func tableViewSelectTitle(){
        let vc = Push_TitleController()
        GeneralFactory.addTitleWithTitle(vc)
        vc.callBack = ({(Title: String) -> Void in
            self.Book_Title = Title
            self.tableView?.reloadData()
        })
        self.presentViewController(vc, animated: true, completion: nil)
    }
    /**
    *  选择评分
    */
    func tableViewSelectScore(){
        self.tableView?.beginUpdates()
        
        let tempIndexPath = [NSIndexPath(forRow: 2, inSection: 0)]
        
        if self.showScore{
            self.titleArray.removeAtIndex(2)
            self.tableView?.deleteRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Right)
            self.showScore = false
        }else{
            self.titleArray.insert("", atIndex: 2)
            self.tableView?.insertRowsAtIndexPaths(tempIndexPath, withRowAnimation: .Left)
            self.showScore = true
        }
        self.tableView?.endUpdates()
    }
    /**
    *  选择分类
    */
    func tableViewSelectType(){
        let vc = Push_typeController()
        GeneralFactory.addTitleWithTitle(vc)
        
        let btn1 = vc.view.viewWithTag(1234) as? UIButton
        let btn2 = vc.view.viewWithTag(1235) as? UIButton
        btn1?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        btn2?.setTitleColor(RGB(38, g: 82, b: 67), forState: .Normal)
        
        vc.type = self.type
        vc.detailType = self.detailType
        vc.callBack = ({(type:String,detailType:String)->Void in
            self.type = type
            self.detailType = detailType
            self.tableView?.reloadData()
        })
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    /**
    *  选择书评
    */
    func tableviewSelectDescription(){
        let vc = Push_DescriptionController()
        GeneralFactory.addTitleWithTitle(vc)
        vc.textView?.text = self.Book_Description
        vc.callBack = ({(description:String)->Void in
            self.Book_Description = description
            if self.titleArray.last == ""{
                self.titleArray.removeLast()
            }
            if description != ""{
                self.titleArray.append("")
            }
            self.tableView?.reloadData()
        })
        
        self.presentViewController(vc, animated: true) { () -> Void in
            
        }
    }

}
