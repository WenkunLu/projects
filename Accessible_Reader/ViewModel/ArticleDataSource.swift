//
//  ArticleDataSource.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/6/7.
//

import UIKit


class ArticleDataSouce {

    private var articleList: Array<Article> = []
     
    //存储tag ID的数组
    private var remainedIndexInArticleList: [Int] = []
        
    var sections: [SectionModel] {
        return _sections
    }
    private var _sections: [SectionModel] = []
    
    init() {
        self.loadData(fileName: "ArticleModel", model: Article(), arrayOfModel: &articleList)
        
        fillIndexInArray(sourceArray: articleList, targetArray: &remainedIndexInArticleList)
        
        self._sections = generateSections()
    }
    
    //从json文件读取对象（Book类型，或者Article类型）
    private func loadData<T: Codable>(fileName: String, model: T, arrayOfModel: inout Array<T>) {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .custom({ (decodeProtocl) -> Date in
            let data = try decodeProtocl
                .singleValueContainer()
                .decode(String.self)

            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.calendar = Calendar(identifier: .iso8601)
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            formatter.locale = Locale(identifier: "zh_CN")

            return formatter.date(from: data)!
        })
        
        guard !fileName.isEmpty else {
            print("文件名为空")
            return
        }
        guard let path = Bundle.main.path(forResource: fileName, ofType: "json") else {
            print("There is no file named \(fileName)")
            return
        }
        
        let localData = NSData.init(contentsOfFile: path)! as Data
        
        do {
            let books = try decoder.decode([T].self, from: localData)
            for item in books {
                arrayOfModel.append(item)
            }
        } catch {
            print(error)
        }
    }
    
    
    
    //MARK: - 随机产生不重复的tag数组

    //取出所有id存进remained_数组，用于记录被查找剩下的tag
    private func fillIndexInArray<T: TagProtocol>(sourceArray: Array<T>, targetArray: inout [Int]) {
        for item in sourceArray {
            targetArray.append(item.id)
        }
    }
    
    //产生需要数量的随机ID，用于把相关ID的tag取出来
    private func randomIDs(neededTagCount: Int, remainedList list: inout [Int]) -> [Int] {
        var howManyLeft: Int = 0
        var tagIDs: [Int] = []
        var tempIntArray: [Int] = []
        
        //数组中数比需要的量多时
        if neededTagCount <= list.count {
            howManyLeft = neededTagCount
        //数组中数不够时
        } else {
            howManyLeft = list.count
        }
        
        for _ in 0 ..< list.count {
            let randomId = Int.random(in: 0 ..< list.count)
            tempIntArray.append(list[randomId])
            
            //限定只产生需要的个数
            guard tagIDs.count < howManyLeft else {
                //print("超过数组了")
                break
            }
            tagIDs = Array(Set(tempIntArray))
            //从remainedList中删除id
            for tagID in tagIDs {
                list.removeAll { item -> Bool in
                    return item == tagID
                }
            }
        }
        
        return tagIDs
    }
    
    func generateTags<T: TagProtocol>(neededTagCount: Int, tagType: T) -> [T] {
        var tagsNeedBeSelected: [T] = []
        var IDs: [Int] = []
        var tagList: Array<T> = []
        
        IDs = randomIDs(neededTagCount: neededTagCount, remainedList: &remainedIndexInArticleList)
        //将json中的所有Article类tag导入
        tagList = articleList as! [T]
        
        //用随机产生的ID来选取json中的tag
        for id in IDs {
            for item in  tagList {
                if item.id == id {
                    tagsNeedBeSelected.append(item)
                }
            }
        }
        
        return tagsNeedBeSelected
    }
    
        
    //MARK: - 内部章节Struct
    struct SectionModel {
        let cellType: CellType
        
        var articles: [Article] = []
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
    
    
    //MARK: - 产生章节
    func generateSections() -> [SectionModel]{
        
        var tempSections: [SectionModel] = []
        
        
        //第三章 文章 6个
        var section3 = SectionModel(cellType: .oneColumn)
        section3.articles = generateTags(neededTagCount: 6, tagType: Article())
        section3.header = Header(id: 2, title: "今日短文", secondTitle: "更新于7:23")
        
        //第六章 文章 6个
        var section6 = SectionModel(cellType: .oneColumn)
        section6.articles = generateTags(neededTagCount: 6, tagType: Article())
        section6.header = Header(id: 5, title: "News", secondTitle: "前沿热点文章")
        
        //第十章 文章 6个
        var section10 = SectionModel(cellType: .oneColumn)
        section10.articles = generateTags(neededTagCount: 6, tagType: Article())
        section10.header = Header(id: 9, title: "News", secondTitle: "更新于8:44")
        
       
        tempSections.append(section3)
        
        tempSections.append(section6)
        
        tempSections.append(section10)

        
        return tempSections
    }
    
}
