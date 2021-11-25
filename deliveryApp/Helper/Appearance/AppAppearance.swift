//
//  AppAppearance.swift
//  deliveryApp
//
//  Created by Vladimir Ratskevich on 23.11.21.
//

import UIKit

class AppAppearance {
    
    class func configure(){
        AppAppearance.configureNavBar()
        //AppAppearance.configureSegmentedControl()
        AppAppearance.configureTabBar()
        //AppAppearance.configureToolBar()
    }
    
    class func configureTabBar(){
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            //appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            //setTabBarItemColors(appearance.compactInlineLayoutAppearance)
            UITabBar.appearance().standardAppearance = appearance
        } else {
            setTabBarItemColors()
        }
        
    }
    
    private class func setTabBarItemColors() {
        UITabBar.appearance().tintColor = .gray
        UITabBar.appearance().unselectedItemTintColor = .blue
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().backgroundImage = UIImage()
    }
    
//    @available(iOS 13.0, *)
//    private class func setTabBarItemColors(_ itemAppearance: UITabBarItemAppearance) {
//        itemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "tabBarSelectedColor") as Any]
//        itemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "tabBarUnselectedColor") as Any]
//    }
    
    class func configureNavBar(){
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = .white
            //appearance.shadowColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().tintColor = .blue
        } else {
            UINavigationBar.appearance().tintColor = UIColor(named: "itemBarColor")
            UINavigationBar.appearance().barTintColor = UIColor(named: "backgroundNavBarColor")
            UINavigationBar.appearance().isTranslucent = false
            UINavigationBar.appearance().isOpaque = true
            UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "textMain") as Any]
        }
    }
    
//    class func configureSegmentedControl(){
//        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12)], for: .normal)
//
//        if #available(iOS 13.0, *) {
//            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(named: "backgroundNavBarColor")
//        } else {
//            UISegmentedControl.appearance().tintColor = UIColor(named: "orangeColor")
//            UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(named: "backgroundNavBarColor") as Any], for: .selected)
//        }
//    }
    
//    class func configureToolBar(){
//        if #available(iOS 13.0, *) {
//            let appearance = UIToolbarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundColor = UIColor(named: "backgroundNavBarColor")
//            UIToolbar.appearance().standardAppearance = appearance
//        } else {
//            UIToolbar.appearance().barTintColor = UIColor(named: "backgroundNavBarColor")
//        }
//    }
}



