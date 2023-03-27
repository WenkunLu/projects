////
////  BookAndArticle.swift
////  UIColl
////
////  Created by Orange on 2022/3/14.
////
//
//import UIKit
//
//
//
//struct BookAndArticle {
//    var logoName: String = ""
//    var imageName: String = ""
//    var title: String = ""
//    var secondTitle: String = ""
//    var footer: String = ""
//}
//
//
//
//class DataManager {
//
//    static let shared = DataManager()
//
//    var disneyBookList: [BookAndArticle] = [
//        BookAndArticle(logoName: "", imageName: "魔发奇缘", title: "魔发奇缘", secondTitle: "美国迪士尼公司"),
//        BookAndArticle(logoName: "", imageName: "美女与野兽", title: "美女与野兽", secondTitle: "美国迪士尼公司"),
//        BookAndArticle(logoName: "", imageName: "海洋奇缘", title: "海洋奇缘", secondTitle: "美国迪士尼公司"),
//        BookAndArticle(logoName: "", imageName: "疯狂动物城", title: "疯狂动物城", secondTitle: "美国迪士尼公司"),
//        BookAndArticle(logoName: "", imageName: "冰雪奇缘", title: "冰雪奇缘", secondTitle: "美国迪士尼公司"),
//        BookAndArticle(logoName: "", imageName: "爱丽丝梦游仙境", title: "爱丽丝梦游仙境", secondTitle: "美国迪士尼公司"),
//    ]
//
//    var articleList: [BookAndArticle] = [
//        BookAndArticle(logoName: "nationalGeographiclogo", imageName: "睡莲", title: "What a huge lily pad can teach us about building design", secondTitle: "NationalGeographic"),
//        BookAndArticle(logoName: "naturelogo", imageName: "鹳", title: "Trade-offs between stability and manoeuvrability in bird flight", secondTitle: "Nature"),
//        BookAndArticle(logoName: "timelogo", imageName: "街道", title: "Return to the Office? Not in This Housing Market", secondTitle: "Time"),
//        BookAndArticle(logoName: "washingtonPostlogo", imageName: "体育", title: "Carson Wentz may never again play like an MVP. Analysts say he can still improve the Commanders.", secondTitle: "WashingtonPost"),
//        BookAndArticle(logoName: "newYorkTimeslogo", imageName: "飞机", title: "Over Ukraine, Lumbering Turkish-Made Drones Are an Ominous Sign for Russia. Over Ukraine, Lumbering Turkish-Made Drones Are an Ominous Sign for Russia", secondTitle: "The New York Times")
//    ]
//
//    var classicBookList: [BookAndArticle] = [
//        BookAndArticle(logoName: "", imageName: "法兰西的陷落", title: "法兰西的陷落", secondTitle: "朱利安·杰克逊"),
//        BookAndArticle(logoName: "", imageName: "美国四百年", title: "美国四百年", secondTitle: "布·斯里尼瓦桑"),
//        BookAndArticle(logoName: "", imageName: "现代中国的形成", title: "现代中国的形成", secondTitle: "李怀印"),
//        BookAndArticle(logoName: "", imageName: "斑马", title: "斑马", secondTitle: "傅真"),
//        BookAndArticle(logoName: "", imageName: "时髦的空话", title: "时髦的空话", secondTitle: "艾伦•索卡尔"),
//        BookAndArticle(logoName: "", imageName: "压裂的底层", title: "压裂的底层", secondTitle: "伊丽莎·格里斯沃尔德"),
//    ]
//
//    var sectionTitleList: [SectionTitle] = [
//        SectionTitle(title: "大电影小说", secondTitle: "迪士尼电影小说"),
//        SectionTitle(title: "今日短文", secondTitle: "更新于23:00"),
//        SectionTitle(title: "阅读经典", secondTitle: "热门书单推荐")
//    ]
//
//
//    func generateSectionTitle() -> [SectionTitle] {
//        return sectionTitleList
//    }
//
//    func generateTags() -> [[BookAndArticle]] {
//        var manager: [[BookAndArticle]] = []
//        manager.append(disneyBookList)
//        manager.append(articleList)
//        manager.append(classicBookList)
//        return manager
//    }
//
//}
//
//
//
