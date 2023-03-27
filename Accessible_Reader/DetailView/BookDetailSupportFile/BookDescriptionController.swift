//
//  BookDescriptionViewController.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/17.
//

import UIKit



class BookDescriptionViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let backImageView = UIImageView()
    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    private let authorLabel = UILabel()
    private let translatorLabel = UILabel()
    private let publisherLabel = UILabel()
    private let abstractLabel = UILabel()
    private let abstractLabelWhiteBackground = UIView()
    
    private let viewOfhideBackImage = UIView()
    
    private var isScrollUP: CGFloat = 0 {
        didSet {
            if isScrollUP < 10 {
                viewOfhideBackImage.isHidden = true
            } else {
                viewOfhideBackImage.isHidden = false
            }
        }
    }
    
//    var image = UIImage(named: "4high")
    
    var value: Book = Book() {
        didSet {
            //图片需要在实例化imageView的时候就赋值
            titleLabel.text = value.title
            if value.subTitle != "空" {
                subTitleLabel.text = value.subTitle
            }
            authorLabel.text = "作者："+value.author
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale.init(identifier: "zh_CN")
            if value.translator != "空" {
                translatorLabel.text = "译者："+value.translator
                publisherLabel.text = value.publisher + "/" + formatter.string(from: value.publicationDate)
            } else {
                translatorLabel.text = "出版社："+value.publisher
                publisherLabel.text = "出版时间：" + value.publisher + "/" + formatter.string(from: value.publicationDate)
            }
        }
    }
    
    //MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
                
        view.backgroundColor = .systemCyan
        viewOfhideBackImage.backgroundColor = .white
        viewOfhideBackImage.isHidden = true
        viewOfhideBackImage.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-500)
        
        self.title = "书籍"
        self.view.backgroundColor = .white
        scrollView.delegate = self
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        
        let rect = CGRect(x: view.frame.minX, y: view.frame.minY, width: view.frame.width, height: view.frame.height)

        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = rect
        blurView.layer.masksToBounds = true
      
        backImageView.image = UIImage(named: value.highPicture)
        backImageView.contentMode = .scaleAspectFill
        backImageView.frame = rect
        backImageView.layer.masksToBounds = true
        backImageView.addSubview(blurView)
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(backImageView)
         
        
        //MARK: - 设置属性
        imageView.image = UIImage(named: value.highPicture)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 14
        imageView.layer.cornerCurve = .continuous
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        
//        titleLabel.text = "你一定爱读的极简欧洲史"
        titleLabel.font = .systemFont(ofSize: 26, weight: .bold)
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.textColor = .white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        
//        subTitleLabel.text = "为什么欧洲对现代文明的影响这么深"
        subTitleLabel.font = .systemFont(ofSize: 18)
        subTitleLabel.textAlignment = .center
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textColor = .white
        subTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
//        authorLabel.text = "作者： 约翰·赫斯特"
        authorLabel.textColor = .white
        authorLabel.translatesAutoresizingMaskIntoConstraints = false

//        translatorLabel.text = "译者： 席玉萍"
        translatorLabel.textColor = .white
        translatorLabel.translatesAutoresizingMaskIntoConstraints = false

//        publisherLabel.text = "广西师范大学出版社/2011-11-13"
        publisherLabel.textColor = .white
        publisherLabel.alpha = 0.4
        publisherLabel.font = .systemFont(ofSize: 10)
        publisherLabel.translatesAutoresizingMaskIntoConstraints = false

        abstractLabelWhiteBackground.backgroundColor = .white
        abstractLabelWhiteBackground.translatesAutoresizingMaskIntoConstraints = false
        
        abstractLabel.text = text
        abstractLabel.font = .preferredFont(forTextStyle: .body)
        abstractLabel.numberOfLines = 0
        abstractLabel.backgroundColor = .white
        abstractLabel.translatesAutoresizingMaskIntoConstraints = false

        //MARK: - 添加子视图

        view.addSubview(viewOfhideBackImage)
        view.addSubview(scrollView)


        scrollView.addSubview(imageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(subTitleLabel)
        scrollView.addSubview(authorLabel)
        scrollView.addSubview(translatorLabel)
        scrollView.addSubview(publisherLabel)
        scrollView.addSubview(abstractLabelWhiteBackground)
        scrollView.addSubview(abstractLabel)
        
        layoutSubviews()
    }
    
    
    //MARK: - 设置布局
    func layoutSubviews() {
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            backImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backImageView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            backImageView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            backImageView.widthAnchor.constraint(equalTo: guide.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: guide.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10),
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width*(180/399)),
            imageView.heightAnchor.constraint(equalToConstant: imageViewHeightAnchorConstant())
        ])
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 18),
            titleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            subTitleLabel.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
        ])
        NSLayoutConstraint.activate([
            authorLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30),
            authorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40)
        ])
        NSLayoutConstraint.activate([
            translatorLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 4),
            translatorLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
        ])
        NSLayoutConstraint.activate([
            publisherLabel.topAnchor.constraint(equalTo: translatorLabel.bottomAnchor, constant: 30),
            publisherLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 40),
        ])
        NSLayoutConstraint.activate([
            abstractLabelWhiteBackground.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 50),
            abstractLabelWhiteBackground.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            abstractLabelWhiteBackground.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            abstractLabelWhiteBackground.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            abstractLabelWhiteBackground.widthAnchor.constraint(equalTo: scrollView.widthAnchor)

        ])
        NSLayoutConstraint.activate([
            abstractLabel.topAnchor.constraint(equalTo: publisherLabel.bottomAnchor, constant: 64),
            abstractLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
            abstractLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -12),
            abstractLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
        ])
    }
    
    
    func imageViewHeightAnchorConstant() -> CGFloat {
        return 670/1080 * self.view.frame.width
    }
    
}


//MARK: - Delegate
extension BookDescriptionViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y
        isScrollUP = scrollView.contentOffset.y
        viewOfhideBackImage.frame = CGRect(x: 0, y: UIScreen.main.bounds.height-offset, width: view.frame.width, height: UIScreen.main.bounds.height+offset)
       
    }
}





let text = """
内容简介  · · · · · ·
澳大利亚知名历史学家约翰·赫斯特在本书中所作的引人入胜的探索，为我们勾勒出欧洲文明的前世今生，及其所以能改变世界的诸多特质。
作者以三大元素（古希腊罗马文化、基督教教义以及日耳曼战士文化）开篇，描述了这三大元素如何彼此强化，又相互对立，最终形塑为欧洲文明的内核；继而在诸多世纪以来催生帝国与城邦，激发征服与内省，造就出许多性格分明的人物，如仁慈的皇帝、好斗的教皇、侠义的骑士，乃至世上第一批享受繁荣和启蒙果实的公民。
本书增加了从工业革命至二次大战这一部分的探讨，表达了对于欧洲文明演进的忧思：某种欧洲精神能够发展到维持一个欧洲联邦吗？在一个由多种混合起源汇聚而成的文明中，关于它应该包含什么，从来都是聚讼纷纭。
本书虽是写给澳大利亚年轻读者的启蒙书，但在中国自2011年引进以来已印刷三十余次，成为现象级畅销书。作者于2016年2月3日逝世，谨以此增订版作为纪念！
作者简介  · · · · · ·
约翰•赫斯特（John Hirst，1942—2016），澳大利亚与英联邦权威的社会暨政治历史学家、欧洲史专家。现任墨尔本的拉筹伯大学（La Trobe University）历史系教授。赫斯特教授曾是澳大利亚首相咨询委员会、澳大利亚国家博物馆评议会成员，并担任澳大利亚联邦公民教育委员会主席至今，常在澳大利亚各大报章杂志为文，对公民教育的提升着力甚深。著作包括《极简欧洲史》、《澳大利亚人：1770年以来的民族精神知情者与局外人》、《命运海岸上的自由：澳大利亚的第一块殖民地》、《澳大利亚史上的睿识与胡言》和《寻找澳大利亚》等。
"""
