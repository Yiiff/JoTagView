//
//  JoTagView.swift
//  JoTagView
//
//  Created by Shayen on 2017/9/29.
//  Copyright © 2017年 Centling Technologies Co., Ltd. All rights reserved.
//

import UIKit

@objc protocol JoTagViewDelegate {
    @objc optional func didSelectTag(sender: UIButton, index: Int)
}

class JoTagView: UIView {

    //* TagViewDataSource */
    var dataSource: [String]?
    var delegate:JoTagViewDelegate?
    private var btnDataSource = [UIButton]()
    
    //* Tag Height */
    public var tagHeight: Int {
        get {
            return 40
        }
        set {
            self.tagHeight = newValue
        }
    }
    
    //* Tag Top Margin */
    public var topMargin: Int {
        get {
            return 8
        }
        set {
            self.topMargin = newValue
        }
    }
    
    //* Tag Bottom Margin */
    public var bottomMargin: Int {
        get {
            return 8
        }
        set {
            self.bottomMargin = newValue
        }
    }
    
    //* Number Of Row In A Line */
    public var numberOfRow: Int {
        get {
            return 3
        }
        set {
            self.numberOfRow = newValue
        }
    }
    
    public var leftMargin: Int {
        get {
            return 8
        }
        set {
            self.leftMargin = newValue
        }
    }
    
    private var bottomMarginWithRowHeight: Int {
        get {
            return tagHeight + bottomMargin
        }
        set {
            self.bottomMarginWithRowHeight = newValue + bottomMargin
        }
    }
    
    public var tagNormalColor: UIColor {
        get {
            return UIColor(red: 0.6, green: 0.4, blue: 0.2, alpha: 1.0)
        }
        set {
            self.tagNormalColor = newValue
        }
    }
    
    public var tagSelectdColor: UIColor {
        get {
            return UIColor.white
        }
        set {
            self.tagSelectdColor = newValue
        }
    }
    
    var isNeedFlipColor = false
    var isTagCanTouch = false
    var isSingleTap = false
    
    private var contentViewHeight = 0.0
    private var lastTapBtn: UIButton?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Init Tag
extension JoTagView {
    
    public func setupTagView() {
        if self.dataSource!.count > 0 {
            for i in 0..<(self.dataSource?.count)! {
                let btn: UIButton = UIButton(type: .custom)
                let tagWidth = (Int(UIScreen.main.bounds.size.width) - leftMargin * (numberOfRow + 1)) / numberOfRow
                btn.frame = CGRect(x: leftMargin + (leftMargin * ( i % numberOfRow )) + (tagWidth) * ( i % numberOfRow),
                                   y: topMargin + ( i / numberOfRow) * bottomMarginWithRowHeight,
                                   width: tagWidth,
                                   height: tagHeight)
                btn.setTitle(self.dataSource![i], for: .normal)
                btn.setTitleColor(tagNormalColor, for: .normal)
                btn.setTitleColor(tagSelectdColor, for: .selected)
                btn.backgroundColor = tagSelectdColor
                btn.layer.masksToBounds = true
                btn.layer.cornerRadius = CGFloat(Double(tagHeight) * 0.5)
                btn.layer.borderWidth = 1
                btn.layer.borderColor = tagNormalColor.cgColor
                btn.tag = i
                btn.isUserInteractionEnabled = isTagCanTouch
                btn.addTarget(self, action: #selector(tagDidClicked(sender:)), for: .touchUpInside)
                addSubview(btn)
                btnDataSource.append(btn)
                
            }
            self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: self.bounds.size.width, height: CGFloat(getContentViewHeight()))
        }
    }
    
    //* Get TagView Height */
    public func getContentViewHeight() -> Double {
        if (self.dataSource?.count)! < 3 {
            contentViewHeight = Double(topMargin + (( numberOfRow - 1 ) / numberOfRow ) * bottomMarginWithRowHeight + bottomMarginWithRowHeight) + Double(bottomMarginWithRowHeight)
        } else {
            contentViewHeight = Double(topMargin + (( self.dataSource!.count - 1 ) / numberOfRow ) * bottomMarginWithRowHeight) + Double(bottomMarginWithRowHeight)
        }
        return contentViewHeight
    }
    
    func reloadTag() {
        for btn in btnDataSource {
            weak var wSelf = self
            btn.isUserInteractionEnabled = isTagCanTouch
            if !isNeedFlipColor {
                btn.isSelected = false
                UIView.animate(withDuration: 0.3, animations: {
                    btn.layer.borderColor = wSelf?.tagNormalColor.cgColor
                    btn.backgroundColor = wSelf?.tagSelectdColor
                })
            }
            if isSingleTap {
                for btn in btnDataSource {
                    btn.isSelected = false
                    UIView.animate(withDuration: 0.3, animations: {
                        btn.layer.borderColor = wSelf?.tagNormalColor.cgColor
                        btn.backgroundColor = wSelf?.tagSelectdColor
                    })
                }
                lastTapBtn?.isSelected = true
                UIView.animate(withDuration: 0.3, animations: {
                    wSelf?.lastTapBtn?.layer.borderColor = wSelf?.tagNormalColor.cgColor
                    wSelf?.lastTapBtn?.backgroundColor = wSelf?.tagNormalColor
                })
            }
        }
    }
    
    @objc func tagDidClicked(sender: UIButton) {
        weak var wSelf = self
        if isSingleTap {
            for btn in btnDataSource {
                btn.isSelected = false
                UIView.animate(withDuration: 0.3, animations: {
                    btn.layer.borderColor = wSelf?.tagNormalColor.cgColor
                    btn.backgroundColor = wSelf?.tagSelectdColor
                })
            }
        }
        if isNeedFlipColor {
            sender.isSelected = !sender.isSelected
            UIView.animate(withDuration: 0.3, animations: {
                if sender.isSelected {
                    sender.layer.borderColor = wSelf?.tagNormalColor.cgColor
                    sender.backgroundColor = wSelf?.tagNormalColor
                } else {
                    sender.layer.borderColor = wSelf?.tagNormalColor.cgColor
                    sender.backgroundColor = wSelf?.tagSelectdColor
                }
            })
        }
        if delegate != nil {
            delegate?.didSelectTag!(sender: sender, index: sender.tag)
        }
        lastTapBtn = sender
    }
}

