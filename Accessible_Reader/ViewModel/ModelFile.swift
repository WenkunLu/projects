//
//  ModelFile.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/15.
//

import Foundation




protocol TagProtocol: Hashable, Codable {
    var id: Int { get }
}

struct Header: TagProtocol  {
    var id: Int = 0
    var title: String = ""
    var secondTitle: String = ""
}

struct Book: TagProtocol {
    let id: Int
    let highPicture: String
    let widePicture: String
    let title: String
    let subTitle: String
    let author: String
    let translator: String
    let publisher: String
    let publicationDate: Date
    var lastOpenTime: Date
    var introduction: String
    init() {
        self.id = 0
        self.highPicture = "1high"
        self.widePicture = "1wide"
        self.title = ""
        self.subTitle = ""
        self.author = ""
        self.translator = ""
        self.publisher = ""
        self.publicationDate = Date()
        self.lastOpenTime = Date()
        self.introduction = ""
    }
    init(id: Int, highPicture: String, widePicture: String, title: String, subTitle: String, author: String, translator: String, publisher: String, publicationDate: Date, lastOpenTime: Date, introduction: String) {
        self.id = id
        self.highPicture = highPicture
        self.widePicture = widePicture
        self.title = title
        self.subTitle = subTitle
        self.author = author
        self.translator = translator
        self.publisher = publisher
        self.publicationDate = publicationDate
        self.lastOpenTime = lastOpenTime
        self.introduction = introduction
    }
}

struct Article: TagProtocol {
    let id: Int
    let logoName: String
    let imageName: String
    let title: String
    let institution: String
    let publicationDate: Date
    
    init() {
        self.id = 0
        self.logoName = ""
        self.imageName = ""
        self.title = ""
        self.institution = ""
        self.publicationDate = Date()
    }
    
    init(id: Int, logoName: String, imageName: String, title: String, institution: String, publicationDate: Date) {
        self.id = id
        self.logoName = logoName
        self.imageName = imageName
        self.title = title
        self.institution = institution
        self.publicationDate = publicationDate
    }
}

