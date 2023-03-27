//
//  TableViewCell.swift
//  HowToUseCoreData
//
//  Created by Master Lu on 2023/1/15.
//

import UIKit
import SwiftUI


class CustomCell: UITableViewCell {
    
    private let bookNameLable = UILabel()
    private let authorLable = UILabel()
    private let publicDateLable = UILabel()
    
    var bookName: String = "第一" {
        didSet {
            bookNameLable.text = bookName
        }
    }
    var author: String = "作者" {
        didSet {
            authorLable.text = author
        }
    }
    var publicDate: Date = .now {
        didSet {
            publicDateLable.text = formatterDate(date: publicDate)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func formatterDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale(identifier: "zh_cn")
        let str = formatter.string(from: date)
        return str
    }
    
    private func setupView() {
        
        bookNameLable.text = "this is a book!"
        bookNameLable.font = .preferredFont(forTextStyle: .title1)
        bookNameLable.translatesAutoresizingMaskIntoConstraints = false
        
        authorLable.text = "马克吐温"
        authorLable.translatesAutoresizingMaskIntoConstraints = false
        //authorLable.layer.borderWidth = 1
        
        publicDateLable.text = "2022.2.3"
        publicDateLable.textAlignment = .right
        publicDateLable.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.addSubview(bookNameLable)
        self.addSubview(authorLable)
        self.addSubview(publicDateLable)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            bookNameLable.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
            bookNameLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bookNameLable.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            authorLable.topAnchor.constraint(equalTo: bookNameLable.bottomAnchor),
            authorLable.leadingAnchor.constraint(equalTo: bookNameLable.leadingAnchor),
            authorLable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            authorLable.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width/2-20),
            
            publicDateLable.topAnchor.constraint(equalTo: authorLable.topAnchor),
            publicDateLable.leadingAnchor.constraint(equalTo: authorLable.trailingAnchor),
            publicDateLable.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            publicDateLable.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
}


//MARK: - header
class CustomHeader: UITableViewHeaderFooterView {
    
    private let backgrView = UIView()
    private let label = UILabel()
    var sectionTitle: String = "" {
        didSet {
            label.text = sectionTitle
        }
    }
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        
        backgrView.backgroundColor = .systemGray4
        backgrView.frame = self.frame
        backgrView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(backgrView)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            backgrView.topAnchor.constraint(equalTo: self.topAnchor),
            backgrView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backgrView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backgrView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: self.topAnchor),
            label.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}







struct CustomCellRepresentable: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let cell = CustomCell()
        return cell
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        
    }
    
    typealias UIViewType = UIView
}


struct CustomCellRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        CustomCellRepresentable()
            .frame(width:UIScreen.main.bounds.width, height: 70)
            .border(.blue)
    }
}


