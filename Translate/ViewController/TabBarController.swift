//
//  TabBarController.swift
//  Translate
//
//  Created by Terry on 2022/03/10.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let translateViewController = translateViewController()
        translateViewController.tabBarItem = UITabBarItem(title: "번역",
                                                          image: UIImage(systemName: "mic"),
                                                          selectedImage: UIImage(systemName: "mic.fill"))
        let bookMarkViewController = UIViewController()
        bookMarkViewController.tabBarItem = UITabBarItem(title: "즐겨찾기",
                                                         image: UIImage(systemName: "star"),
                                                         selectedImage: UIImage(systemName: "star,fill"))
        viewControllers = [
            translateViewController,
            bookMarkViewController
        ]
    }
}
