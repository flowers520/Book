//
//  MainTabBarVC.swift
//  Book
//
//  Created by jim on 16/12/5.
//  Copyright © 2016年 jim. All rights reserved.
//

import UIKit

class MainTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initTabBar()
    }


    /**
        初始化工具栏
     let tabbarItem1 = UITabBarItem(title: "排行榜", image: UIImage(named: "bio"), selectedImage: UIImage(named: "bio_red"))
     let tabbarItem2 = UITabBarItem(title: "发现", image: UIImage(named: "timer 2"), selectedImage: UIImage(named: "timer 2_red"))
     let tabbarItem3 = UITabBarItem(title: "", image: UIImage(named: "pencil"), selectedImage: UIImage(named: "pencil_red"))
     let tabbarItem4 = UITabBarItem(title: "圈子", image: UIImage(named: "users two-2_red"), selectedImage: UIImage(named: "users two-2"))
     let tabbarItem5 = UITabBarItem(title: "更多", image: UIImage(named: "more"), selectedImage: UIImage(named: "more_red"))
     rankController.tabBarItem = tabbarItem1
     searchController.tabBarItem = tabbarItem2
     pushController.tabBarItem = tabbarItem3
     circleController.tabBarItem = tabbarItem4
     moreController.tabBarItem = tabbarItem5

    */
    func initTabBar(){
        self.view.backgroundColor = UIColor.whiteColor()
        let rankItem = self.initTabBarItem("排行榜", normalImg: "bio", SelectedImg: "bio_red", tabItemVC: rankViewController())
        let searchItem = self.initTabBarItem("发现", normalImg: "timer 2", SelectedImg: "timer 2_red", tabItemVC: searchViewController())
        let pushItem = self.initTabBarItem("", normalImg: "pencil", SelectedImg: "pencil_red", tabItemVC: pushViewController())
        let circleItem = self.initTabBarItem("圈子", normalImg: "users two-2", SelectedImg: "users two-2_red", tabItemVC: circleViewController())
        let tabbarItem = self.initTabBarItem("更多", normalImg: "more", SelectedImg: "more_red", tabItemVC: moreViewController())
        self.viewControllers = [rankItem,searchItem,pushItem,circleItem,tabbarItem]
    }
    /**
     初始化工具栏按钮
     
     - parameter title:       标题
     - parameter normalImg:   默认图片
     - parameter SelectedImg: 选中图片
     - parameter tabItemVc:   tabItem对应的控制器
     
     - returns: 包含TabItem的导航条视图控制器
     */
    func initTabBarItem(title:String, normalImg:String, SelectedImg:String, tabItemVC: UIViewController) -> UINavigationController{
        
        //UIImage.settingRenderingMode 设置图片总是以原图渲染(默认为蓝色)
        let tabBarItem = UITabBarItem(title: title, image: UIImage.settingRenderingMode(normalImg), selectedImage: UIImage.settingRenderingMode(SelectedImg))
        //设置选中按钮是的字体颜色
        tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : MainFontColor], forState: UIControlState.Selected)
        //设置界面标题
        tabItemVC.title = title
        //设置对应控制控制器的tabBarItem
        tabItemVC.tabBarItem = tabBarItem
        
        return UINavigationController(rootViewController: tabItemVC)
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

extension UIImage {
    /**
     渲染
     - parameter imageName: 图片名称
     */
    static func settingRenderingMode(imageName: String) -> UIImage{
        return UIImage(named: imageName)!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
    }
}
