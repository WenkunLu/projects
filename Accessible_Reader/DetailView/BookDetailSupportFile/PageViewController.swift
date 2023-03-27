//
//  PageViewController.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/29.
//



import UIKit



class PageViewController: UIPageViewController, UIPageViewControllerDelegate {
    
    private var textStorage: NSTextStorage?
    private var layoutManager: NSLayoutManager?

    private let boundTextView = UITextView()
    private var textViews: [UITextView] = []
    
    var attributeText = NSMutableAttributedString()
    
    private let textViewBottomOffset: CGFloat = 20
    private let customLineFragmentPadding: CGFloat = 18

    //MARK: - INIT
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: style, navigationOrientation: navigationOrientation)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        readRTFDFile()

        self.dataSource = self
        self.delegate = self
        
        //1.创建textStorage
        textStorage = NSTextStorage(attributedString: attributeText)
        
        //2.创建layoutManager
        layoutManager = NSLayoutManager()
        textStorage?.addLayoutManager(layoutManager!)
    }
    
   
    //MARK: - didAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        createTextViews()
    
        let firstPage = SinglePageController(id: 0)
        firstPage.textView = textViews[0]
        self.setViewControllers([firstPage], direction: .forward, animated: true)
        
    }
    
    //MARK: - 创建textViews
    func createTextViews() {
        var glyphRange: Int = 0
        var numberOfGlyphs: Int = 0
        
        let safeAreaInsets = view.safeAreaInsets
        
        repeat {
            let textContainer = NSTextContainer(size: CGSize(
                width: view.frame.width-safeAreaInsets.left-safeAreaInsets.right,
                height: view.frame.height-safeAreaInsets.top-safeAreaInsets.bottom-textViewBottomOffset
            ))
            layoutManager?.addTextContainer(textContainer)
            
            let textView = UITextView(
                frame: CGRect(x: 0,
                    y: safeAreaInsets.top,
                    width: view.frame.width-safeAreaInsets.left-safeAreaInsets.right,
                    height: view.frame.height-safeAreaInsets.top-safeAreaInsets.bottom-textViewBottomOffset),
                textContainer: textContainer)
            textView.textContainerInset = UIEdgeInsets.zero
            textView.textContainer.lineFragmentPadding = customLineFragmentPadding
            textViews.append(textView)
            
            glyphRange = NSMaxRange((layoutManager?.glyphRange(for: textContainer))!)
            numberOfGlyphs = layoutManager!.numberOfGlyphs
            
        } while glyphRange < numberOfGlyphs - 1
        
    }
}


//MARK: - 读取RTFD文件
extension PageViewController {
    
    func readRTFDFile() {

        guard let url = Bundle.main.url(forResource: "AttRTFD", withExtension: "rtfd") else {
            print("没有该rtfd文件")
            return
        }
                
        let options = [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.rtfd]
        
        do {
            let nsAttributeString = try NSMutableAttributedString(url: url, options: options, documentAttributes: nil)

            attributeText = nsAttributeString
        } catch {
            print(error)
        }
        
        //枚举富文本的属性，取出attachment，判断其所在的NSRange
        attributeText.enumerateAttributes(in: NSRange(location: 0, length: attributeText.length)) { attributes, range, point in
            
            let safeAreaWidth = UIScreen.main.bounds.width-view.safeAreaInsets.left-view.safeAreaInsets.right-customLineFragmentPadding*2
            let safeAreaHeight = UIScreen.main.bounds.height-view.safeAreaInsets.top-view.safeAreaInsets.bottom-textViewBottomOffset
            let safeAreaRatio = safeAreaWidth / safeAreaHeight
            var imageWidth: CGFloat = 0
            var imageHeight: CGFloat = 0
            var aspectRatio: CGFloat = 0
            var attachRange = NSRange()
            
            for i in attributes {
                if i.key == NSAttributedString.Key.attachment {
                    
                    let attach = i.value as! NSTextAttachment
                    
                    if let img = attach.image(
                        forBounds: self.boundTextView.bounds,
                        textContainer: boundTextView.textContainer,
                        characterIndex: range.location)
                    {
                        
                        let aspect = img.size.width / img.size.height
                        imageWidth = img.size.width
                        imageHeight = img.size.height

                        aspectRatio = aspect
                    }
             
                    
                    if aspectRatio >= safeAreaRatio {
                        if imageWidth > safeAreaWidth {
                            let attachBounsWidth = safeAreaWidth
                            let attachBounsHeight = attachBounsWidth / aspectRatio
                            attach.bounds = CGRect(x: 0, y: 0, width: attachBounsWidth, height: attachBounsHeight)
                        } else {
                            attach.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
                        }
                    } else {
                        if imageHeight > safeAreaHeight {
                            let attachBounsHeight = safeAreaHeight
                            let attachBounsWidth = attachBounsHeight * aspectRatio
                            attach.bounds = CGRect(x: 0, y: 0, width: attachBounsWidth, height: attachBounsHeight)
                        } else {
                            attach.bounds = CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight)
                        }
                    }
                    
                    //取出NSRange供下文设置段落属性（图片居中）
                    attachRange = range
                }
            }
            
            //给所在NSRange处的附件添加paragraphStyle
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            paragraphStyle.lineBreakMode = .byTruncatingHead

            attributeText.addAttributes([NSAttributedString.Key.paragraphStyle:paragraphStyle], range: attachRange
            )
            
        }

    }
}



//MARK: - DataSource
extension PageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let controller = viewController as? SinglePageController else {
            return nil
        }
        
        var currentIndex = controller.id

        if currentIndex == 0 {
            return nil
        }
        currentIndex -= 1
        
        let vc: SinglePageController = SinglePageController(id: currentIndex)
        vc.textView = textViews[currentIndex]

        return vc
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let controller = viewController as? SinglePageController else {
            return nil
        }
        
        var currentIndex = controller.id
        
        if currentIndex >= self.textViews.count - 1 {
            return nil
        }

        currentIndex += 1


        let vc: SinglePageController = SinglePageController(id: currentIndex)
        vc.textView = textViews[currentIndex]

        return vc
    }
    
    //与UIPageControl的显示有关，与page数量无关
    /*
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return textViews.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
     */
}
