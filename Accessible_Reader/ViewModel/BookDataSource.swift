//
//  BookDataSource.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/6/7.
//

import UIKit




class BookDataSource {

    private var bookList: Array<Book> = []
     
    //存储tag ID的数组
    private var remainedIndexInBookList: [Int] = []
        
    var sections: [SectionModel] {
        return _sections
    }
    private var _sections: [SectionModel] = []
    
    init() {
        self.loadData(fileName: "BookModel", model: Book(), arrayOfModel: &bookList)
        fillIndexInArray(sourceArray: bookList, targetArray: &remainedIndexInBookList)
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
        
        IDs = randomIDs(neededTagCount: neededTagCount, remainedList: &remainedIndexInBookList)
        //将json中的所有Book类tag导入
        tagList = bookList as! [T]
        
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
    
    //MARK: - 用作者名作为过滤条件生成tag数组
    func generateTagsWithAuthor() -> [Book] {
        var tagsNeedBeSelected: [Book] = []
        var IDs: [Int] = []
        
        //选出需要的id
        for item in bookList {
            if item.subTitle == "美国迪士尼公司" {
                IDs.append(item.id)
                tagsNeedBeSelected.append(item)
            }
        }
        
        for ID in IDs {
            remainedIndexInBookList.removeAll { inde -> Bool in
                return ID == inde
            }
        }
        
        return tagsNeedBeSelected
    }
    
    
    //MARK: - 内部章节Struct
    struct SectionModel {
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
    
    
    //MARK: - 产生章节
    func generateSections() -> [SectionModel]{
        
        var tempSections: [SectionModel] = []
        
        //第一章 书籍 2列 2个
        var section1 = SectionModel(cellType: .twoColumn)
        section1.books = generateTags(neededTagCount: 2, tagType: Book())
        section1.header = Header(id: 0, title: "今日推荐", secondTitle: "每日超人气推荐")
        
        //第二章 书籍 3列 6个
        var section2 = SectionModel(cellType: .threeColumn)
        section2.books = generateTagsWithAuthor()
        section2.header = Header(id: 1, title: "大电影小说", secondTitle: "迪士尼电影小说")
        
        
        
        
        //第四章 书籍 1列 1个
        var section4 = SectionModel(cellType: .oneColumn)
        section4.books = generateTags(neededTagCount: 1, tagType: Book())
        section4.header = Header(id: 3, title: "阅读经典", secondTitle: "首选之荐")
        
        //第五章 书籍 2列 6个
        var section5 = SectionModel(cellType: .twoColumn)
        section5.books = generateTags(neededTagCount: 6, tagType: Book())
        section5.header = Header(id: 4, title: "新书速递", secondTitle: "本周人气新书")
        

        
                
        //第七章 书籍 3列 6个
        var section7 = SectionModel(cellType: .threeColumn)
        section7.books = generateTags(neededTagCount: 6, tagType: Book())
        section7.header = Header(id: 6, title: "畅销图书榜", secondTitle: "本周人气书单")
        
        //第八章 书籍 1列 1个
        var section8 = SectionModel(cellType: .oneColumn)
        section8.books = generateTags(neededTagCount: 1, tagType: Book())
        section8.header = Header(id: 7, title: "与大师对话", secondTitle: "阅读top1")
        
        //第九章 书籍 2列 6个
        var section9 = SectionModel(cellType: .twoColumn)
        section9.books = generateTags(neededTagCount: 2, tagType: Book())
        section9.header = Header(id: 8, title: "最受关注图书", secondTitle: "”太阳总有办法照到我们“")
        
        
        
        tempSections.append(section1)
        tempSections.append(section2)

        tempSections.append(section4)
        tempSections.append(section5)

        tempSections.append(section7)
        tempSections.append(section8)
        tempSections.append(section9)

        
        return tempSections
    }
    
}
