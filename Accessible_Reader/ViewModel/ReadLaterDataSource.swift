//
//  ReadLaterDataSource.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/3.
//

import UIKit


class ReadLaterDataSource {
    
    var sectionsOfBook: [SectionOfBook] {
        return _sectionsOfBook
    }
    var sectionsOfArticle: [SectionOfArticle] {
        return _sectionsOfArticle
    }
    
    private var _sectionsOfBook: [SectionOfBook] = []
    private var _sectionsOfArticle: [SectionOfArticle] = []
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var booksInShelf: [Book] = [] {
        didSet {
            generateSectionsOfBook()
        }
    }

  
    init() {
        self.booksInShelf = []
        
        for item in loadBookInUserDefaults() {
            self.booksInShelf.append(item)
            generateSectionsOfBook()
        }
    }
    
    func loadBookInUserDefaults() -> [Book] {
        var output: [Book] = []
        if let dataStored = UserDefaults.standard.object(forKey: "ReadLater") as? Data {
            
            let data = try! decoder.decode([Book].self, from: dataStored)
            for item in data {
                output.append(item)
            }
        }
        return output
    }
    //MARK: - 内部类
    struct SectionOfBook {
        let cellType: CellType
        
        var books: [Book] = []
        var header: Header = Header()
        
        init(cellType: CellType) {
            self.cellType = cellType
        }
        
        enum CellType {
            case oneColumn
            case twoColumn
            case threeColumn
        }
    }
    
    struct SectionOfArticle {
        var articles: [Article] = []
        var header: Header = Header()
    }

    //MARK: - 产生数据源数组
    private func generateSectionsOfBook() {
        var tempSections: [SectionOfBook] = []
        
        var tempBooks = booksInShelf.sorted(by: { (s1, s2) in
            return s1.lastOpenTime > s2.lastOpenTime
        })

        var section1 = SectionOfBook(cellType: .oneColumn)
        if !booksInShelf.isEmpty {
            section1.books = [tempBooks[0]]
            section1.header = Header(id: 1, title: "最近打开", secondTitle: "")
            tempSections.append(section1)
        }

        var section2 = SectionOfBook(cellType: .threeColumn)
        let _ = tempBooks.remove(at: 0)
        section2.books = tempBooks
        if section2.books.count > 0 {
            section2.header = Header(id: 2, title: "书架", secondTitle: "共\(booksInShelf.count)本书")
            tempSections.append(section2)

        }
        

        self._sectionsOfBook = tempSections
    }
    
    private func generateSectionsOfArticle() -> [SectionOfArticle]{
        var tempSections: [SectionOfArticle] = []

        var section1 = SectionOfArticle()
//        section1.articles = articles1
        section1.header = Header(id: 1, title: "4月16日 星期六", secondTitle: "")

        var section2 = SectionOfArticle()
//        section2.articles = articles2
        section2.header = Header(id: 2, title: "4月15日 星期五", secondTitle: "")
        
        tempSections.append(section1)
        tempSections.append(section2)

        return tempSections
    }
    
    func addToBookshelf(value:inout Book) {
        var count: Int = 0
        if value.title != "" {
            
            //检查id，防止重复添加
            for item in booksInShelf {
                if item.id == value.id {
                    count += 1
                }
            }
            
            if !(count > 0) {
                value.lastOpenTime = Date.now
                booksInShelf.append(value)
                dataStore()
            }
        }
    }
    
    func dataStore() {
        let dataStored = try! encoder.encode(self.booksInShelf)
        UserDefaults.standard.set(dataStored, forKey: "ReadLater")
    }
    
    
    
    
    //MARK: - 测试数据
    /*
    private var books1: [Book] = [
        Book(id: 13, highPicture: "13high", widePicture: "13wide", title: "你一定爱读的极简欧洲史", subTitle: "为什么欧洲对现代文明的影响这么深", author: "[澳]约翰·赫斯特", translator: "席玉苹 / 石晰颋", publisher: "广西师范大学出版社", publicationDate: "2011-03-01", lastOpenTime: "2022-03-20", introduction: "空")
        ]
    private var books2: [Book] = [
        Book(id: 1, highPicture: "1high", widePicture: "1wide", title: "魔法奇缘", subTitle: "美国迪士尼公司", author: "美国迪士尼公司", translator: "人民邮电出版社", publisher: "人民邮电出版社", publicationDate: "2011-03-01", lastOpenTime: "2022-03-20", introduction: "空"),
        Book(id: 2, highPicture: "2high", widePicture: "2wide", title: "美女与野兽", subTitle: "美国迪士尼公司", author: "[法]博蒙夫人", translator: "外语教学与研究出版社", publisher: "外语教学与研究出版社", publicationDate: "2009-06-01", lastOpenTime: "2022-03-21", introduction: "空"),
        Book(id: 3, highPicture: "3high", widePicture: "3wide", title: "海洋奇缘", subTitle: "美国迪士尼公司", author: "美国迪士尼公司", translator: "梁爽", publisher: "中信出版社", publicationDate: "2016-11-01", lastOpenTime: "2022-03-22", introduction: "空"),
        Book(id: 4, highPicture: "4high", widePicture: "4wide", title: "疯狂动物城", subTitle: "美国迪士尼公司", author: "美国迪士尼公司", translator: "华东理工大学出版社", publisher: "华东理工大学出版社", publicationDate: "2015-08-19", lastOpenTime: "2022-03-23", introduction: "空"),
        Book(id: 5, highPicture: "5high", widePicture: "5wide", title: "冰雪奇缘", subTitle: "美国迪士尼公司", author: "美国迪士尼公司", translator: "程喆", publisher: "华东理工大学出版社", publicationDate: "2011-10-24", lastOpenTime: "2022-03-24", introduction: "空"),
        Book(id: 6, highPicture: "6high", widePicture: "6wide", title: "爱丽丝梦游仙境", subTitle: "美国迪士尼公司", author: "[英]刘易斯·卡罗尔", translator: "肖开霖", publisher: "江苏文艺出版社", publicationDate: "2017-08-01", lastOpenTime: "2022-03-25", introduction: "空")
    ]
    */
    
    /*
    private var articles1: [Article] = [
        Article(id: 3, logoName: "Time", imageName: "3picture", title: "Return to the Office? Not in This Housing Market.", institution: "Time", publicationDate: "03/15/2022"),
        Article(id: 14, logoName: "WangyiNews", imageName: "14picture", title: "马斯克的收购让员工感到恐慌 CEO安抚称公司不会被“挟持”", institution: "网易新闻", publicationDate: "03/26/2022")
        ]
    private var articles2: [Article] = [
        Article(id: 3, logoName: "Time", imageName: "3picture", title: "Return to the Office? Not in This Housing Market.", institution: "Time", publicationDate: "03/15/2022"),
        Article(id: 14, logoName: "WangyiNews", imageName: "14picture", title: "马斯克的收购让员工感到恐慌 CEO安抚称公司不会被“挟持”", institution: "网易新闻", publicationDate: "03/26/2022"),
        Article(id: 18, logoName: "FoxNews", imageName: "18picture", title: "Retail sales fall shy of expectations as consumers confront sky-high inflation", institution: "FoxNews", publicationDate: "03/30/2022"),
        Article(id: 4, logoName: "WashingtonPost", imageName: "4picture", title: "Carson Wentz may never again play like an MVP. Analysts say he can still improve the Commanders.", institution: "WashingtonPost", publicationDate: "03/16/2022"),
        Article(id: 9, logoName: "Wallstreetcn", imageName: "9picture", title: "3月70城房价：一线城市房价环比涨幅回落，二三线城市环比持平或降幅收窄", institution: "华尔街见闻", publicationDate: "03/21/2022"),
        Article(id: 10, logoName: "Wallstreetcn", imageName: "10picture", title: "余承东：如不能及时复工复产，5月后疫情所涉供应链会全面停产", institution: "华尔街见闻", publicationDate: "03/22/2022")
    ]
    */
    
    
    
    
}









