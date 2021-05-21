//
//  ViewController.swift
//  TransitionAnimateManager
//
//  Created by High on 2021/4/28.
//

import UIKit

class ViewController: UIViewController {

    private var tapBtn: UIButton!
    
    private var transitionDelegate = TransitionAnimateDelegate.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .gray
        
        tapBtn = UIButton.init(type: .custom)
        tapBtn.backgroundColor = .red
        tapBtn.frame = CGRect.init(x: 30, y: 100, width: 60, height: 60)
        tapBtn.layer.masksToBounds = true
        tapBtn.layer.cornerRadius = 30
        tapBtn.addTarget(self, action: #selector(tapBtnClickAction), for: .touchUpInside)
        self.view.addSubview(tapBtn)
        
    }


    
    @objc func tapBtnClickAction() {
        
        let isPush = false
        
        let detailVc = DetailViewController.init()
        
        if isPush {
            self.navigationController?.delegate = transitionDelegate
            self.navigationController?.pushViewController(detailVc, animated: true)
        } else {
            detailVc.transitioningDelegate = transitionDelegate
            self.present(detailVc, animated: true, completion: nil)
        }
    }
    
}

