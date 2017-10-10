# JoTagView

> Just a button tag view, support single &amp; multiple choice, color flip...

**Gif Demo:**

![](https://github.com/ZX-ZhouXiao/MarkDown-Photos/blob/master/JoTagView.gif)


### Feature

- Support single and multiple choice.
- Support color flip effect.
- Support custom of rows.
- Support custom color for normal or selected.
- Can get TagView height easily to reload content view.

### How to use?

Drag `JoTagView.swift` into your project

### Initialize


```

    // ...

    var tagView: JoTagView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // The height value is not matter, you can input any value
        tagView = JoTagView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 0))
        
        // Default Value: 3
        tagView?.numberOfRow = 2
        
        // Default Value: false
        tagView?.isTagCanTouch = true
        
        // Default Value: false
        tagView?.isNeedFlipColor = true
        
        /// If u need call back
        tagView?.delegate = self
        
        tagView?.dataSource = ["tag1","tag2","tag3","tag4","tag5","tag6","tag7"]
        
        /// Important!!
        /// Property must set befor you setupTagView, Otherwise it setup with default property value
        tagView?.setupTagView()
        
        self.contentView.addSubview(tagView!)
        
        /// Get Tag View Height to Reload ContentView or heightForRow in TableViewCell
        contentViewHeight.constant = CGFloat((tagView?.getContentViewHeight())!)        
    }
    
    // ...
```

### Delegate

You can get callback easily for your next work

```
extension ViewController: JoTagViewDelegate {
    func didSelectTag(sender: UIButton, index: Int) {
        // do something
    }
}
```

#### It's will update for some new function later

**Have a nice day!**

