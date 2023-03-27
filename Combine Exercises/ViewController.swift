//
//  ViewController.swift
//  HowToUseCoreData
//
//  Created by Master Lu on 2023/1/15.
//

import UIKit
import Combine


class ViewController: UIViewController {
        
    let bookManager = BookManager()
    var list: [Shelf] = []
    
    var tableView = UITableView()
    var dataSource: UITableViewDiffableDataSource<Shelf, Book>!
    let cellIdentifier = "tableViewCell"

    var cancellables = Set<AnyCancellable>()

    //MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.register(CustomHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        
        view.addSubview(tableView)
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addAction))
        navigationItem.rightBarButtonItem = addButton
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        creatDataSource()
        applyInitialSnapshots()
        subscribeData()
    
    }
   
    
    @objc func addAction() {
        let detailVC = DetailViewController()
        //如果detailVC是临时的，不会发生循环引用
        detailVC.addDelegate = { book in
            self.bookManager.addBook(book: book)
        }
        navigationController?.pushViewController(detailVC, animated: true)
                
    }
    
    func subscribeData() {
        bookManager.$shelfs
            .receive(on: DispatchQueue.main)
            .sink { list in
                self.list = self.bookManager.shelfs
                var snapshot = NSDiffableDataSourceSnapshot<Shelf, Book>()
                
                snapshot.appendSections(list)
                for (index, element) in list.enumerated() {
                    snapshot.appendItems(element.bookList, toSection: snapshot.sectionIdentifiers[index])
                }
                
                self.dataSource.apply(snapshot, animatingDifferences: false)
            }
            .store(in: &cancellables)
    }
    
}


//MARK: - UITableViewDataSource
extension ViewController: UITableViewDelegate {
    //行高
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //章节标题
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CustomHeader

        headerView?.sectionTitle = bookManager.shelfs[section].shelfName.rawValue
        return headerView
    }
    
    //MARK: - 响应行选择
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let oldBook = dataSource.itemIdentifier(for: indexPath)
        guard let oldBook else { return }
        
        let detailView = DetailViewController()
        detailView.book = oldBook
        
        detailView.addDelegate = { newBook in
            self.bookManager.editBook(newBook: newBook)
        }
        
        navigationController?.pushViewController(detailView, animated: true)
    }
    
    //右滑删除
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextualAction = UIContextualAction(style: .destructive, title: "删除") { (action, view, completionHandler) in
            
            let book = self.dataSource.itemIdentifier(for: indexPath)
            if let book {
                self.bookManager.deleteBook(book: book)
            }
            completionHandler(true)
        }
        
        contextualAction.image = UIImage(systemName: "trash")
        let swipeAction = UISwipeActionsConfiguration(actions: [contextualAction])
        return swipeAction
    }
    
    //创建DataSource
    func creatDataSource() {
        dataSource = UITableViewDiffableDataSource<Shelf, Book>(tableView: tableView) { [unowned self] (tableView, indexPath, itemIdentifier) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as! CustomCell
            
            cell.bookName = itemIdentifier.bookTitle
            cell.author = itemIdentifier.author
            cell.publicDate = itemIdentifier.publicDate
            
            return cell
        }
    }
    
    //创建初始snapshot
    func applyInitialSnapshots() {
        var snapshot = NSDiffableDataSourceSnapshot<Shelf, Book>()
        
        snapshot.appendSections(bookManager.shelfs)
        for (index, element) in bookManager.shelfs.enumerated() {
            snapshot.appendItems(element.bookList, toSection: snapshot.sectionIdentifiers[index])
        }
        
        dataSource.apply(snapshot)
        
    }
}
