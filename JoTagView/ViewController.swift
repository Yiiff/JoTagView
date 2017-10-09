//
//  ViewController.swift
//  JoTagView
//
//  Created by Shayen on 2017/9/29.
//  Copyright © 2017年 Centling Technologies Co., Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var titleLab: UILabel!
    @IBOutlet weak var contentHeightLab: UILabel!
    var tagView: JoTagView?
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // height value
        tagView = JoTagView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0))
        
        tagView?.isTagCanTouch = true
        
        tagView?.isNeedFlipColor = true
        
        /// If u need call back
        tagView?.delegate = self
        
        tagView?.dataSource = ["tag1","tag2","tag3","tag4","tag5","tag6","tag7"]
        
        /// Important!!
        /// Property must set befor you setupTagView, Otherwise it setup with default property value
        tagView?.setupTagView()
        
        self.contentView.addSubview(tagView!)
        
        /// Get Tag View Height
        contentViewHeight.constant = CGFloat((tagView?.getContentViewHeight())!)
        
        contentHeightLab.text = "Tag Content View Height: " + String((tagView?.getContentViewHeight())!)
        
    }

    @IBAction func switching(_ sender: UISwitch) {
        switch sender.tag {
        case 1:
            tagView?.isTagCanTouch = sender.isOn
        case 2:
            tagView?.isNeedFlipColor = sender.isOn
        default:
            tagView?.isSingleTap = sender.isOn
        }
        tagView?.reloadTag()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: JoTagViewDelegate {
    func didSelectTag(sender: UIButton, index: Int) {
        titleLab.text = "Select Tag: " + (sender.currentTitle ?? "No Data")
    }
    
}

