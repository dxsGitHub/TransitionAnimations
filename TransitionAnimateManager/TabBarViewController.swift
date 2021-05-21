//
//  TabBarViewController.swift
//  TransitionAnimateManager
//
//  Created by High on 2021/5/19.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    let tabDelegate = TransitionAnimateDelegate.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = tabDelegate
    }

}
