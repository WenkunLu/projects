//
//  ViewModel.swift
//  HowToUseCoreData
//
//  Created by Master Lu on 2023/1/17.
//

import Foundation



//MARK: - BookManager
class BookManager: ObservableObject {
    
    @Published var shelfs: [Shelf] = [
        Shelf(shelfName: .math, bookList: [
            Book(bookTitle: "高等数学", author: "薛志纯", publicDate: .now, category: .math),
            Book(bookTitle: "线性代数", author: "陈殿友", publicDate: .now, category: .math)
        ]),
        
        Shelf(shelfName: .history, bookList: [
            Book(bookTitle: "中国近代史", author: "蒋廷黻", publicDate: .now, category: .history),
            Book(bookTitle: "极简欧洲史", author: "约翰·赫斯特", publicDate: .now, category: .history)
        ])
    ]
    
    
    //增
    func addBook(book: Book) {
        var isMatching: Bool = false
        
        for (index, shelf) in shelfs.enumerated() {
            if shelf.shelfName == book.category {
                shelfs[index].bookList.append(book)
                isMatching = true
            }
        }
        
        if isMatching == false {
        
            //如果遍历数组没有匹配到，要新建一个Shelf对象
            var newShelf = Shelf(shelfName: .normal, bookList: [book])
            switch book.category {
            case .normal:
                newShelf.shelfName = .normal
                shelfs.append(newShelf)
            case .science:
                newShelf.shelfName = .science
                shelfs.append(newShelf)
            case .history:
                newShelf.shelfName = .history
                shelfs.append(newShelf)
            case .math:
                newShelf.shelfName = .math
                shelfs.append(newShelf)
            case .novel:
                newShelf.shelfName = .novel
                shelfs.append(newShelf)
            }
        }
        
    }
    
    //删
    func deleteBook(book: Book) {
        for (shelfIndex, shelf) in shelfs.enumerated() {
            if shelf.shelfName == book.category {
                
                for (bookIndex, bookInShelf) in shelf.bookList.enumerated() {
                    if book.id == bookInShelf.id {
                        shelfs[shelfIndex].bookList.remove(at: bookIndex)
                        if shelfs[shelfIndex].bookList.isEmpty {
                            shelfs.remove(at: shelfIndex)
                        }
                    }
                
                }
                
            }
        }
    }
    
    
    //改
    func editBook(newBook: Book) {
        for (shelfIndex, shelf) in shelfs.enumerated() {
                
            for (bookIndex, bookInShelf) in shelf.bookList.enumerated() {
                if newBook.id == bookInShelf.id {

                    //没有改种类
                    if newBook.category == shelf.shelfName {
                        shelfs[shelfIndex].bookList.remove(at: bookIndex)
                        shelfs[shelfIndex].bookList.insert(newBook, at: bookIndex)
                    //改了种类
                    } else {
                        deleteBook(book: bookInShelf)
                        addBook(book: newBook)
                    }
                    
                }
                
            }
                 
                            
        }//遍历[shelfs]
    }
    
    
    //查
    func searchBook(byTitle: String) -> [Book] {
        var searchResult: [Book] = []
        
        for (_, shelf) in shelfs.enumerated() {
            
            for (_, book) in shelf.bookList.enumerated() {
                if book.bookTitle == byTitle {
                    searchResult.append(book)
                } else {
                    continue
                }
            }
                
        }
        return searchResult
    }
    
    
    func searchBook(byAuthor: String) -> [Book] {
        var searchResult: [Book] = []
        
        for (_, shelf) in shelfs.enumerated() {
            
            for (_, book) in shelf.bookList.enumerated() {
                if book.bookTitle == byAuthor {
                    searchResult.append(book)
                } else {
                    continue
                }
            }
                
        }
        return searchResult
    }
    

    
}
