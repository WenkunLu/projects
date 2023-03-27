//
//  DetailView.swift
//  HowToUseCoreData
//
//  Created by Master Lu on 2023/2/16.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let tableView = UITableView()
    private let uiPicker = UIPickerView()
    private let datePicker = UIDatePicker()
    private var rightButton = UIBarButtonItem()
    private var bookTitleTextField: UITextField?
    private var authorTextField: UITextField?
    private var publicDateTextField: UITextField?
    
    private var bookTitle: String!
    private var author: String!
    private var publicDate: Date!
    private var category: Book.Categorie!
    
    var book: Book
    var addDelegate: ((Book) -> Void)?
    
    init(book: Book) {
        self.book = book
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        let book = Book(bookTitle: "", author: "", publicDate: .now, category: .normal)
        self.book = book
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemCyan
        
        //tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .systemPink
        
        tableView.register(InputTableViewCell.self, forCellReuseIdentifier: "inputcell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
        
        
        //rightButtonItem
        rightButton = UIBarButtonItem(title: "保存", style: .plain, target: self, action: #selector(saveButtonAction))
        navigationItem.rightBarButtonItem = rightButton
        
        //datePicker
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.backgroundColor = .systemGray6
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange), for: .valueChanged)
        
        view.addSubview(datePicker)
        NSLayoutConstraint.activate([
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        //MARK: - uiPicker
        uiPicker.dataSource = self
        uiPicker.delegate = self
        uiPicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(uiPicker)
        
        NSLayoutConstraint.activate([
            uiPicker.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
            uiPicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            uiPicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])

            
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        bookTitleTextField?.text = book.bookTitle
        bookTitle = book.bookTitle
        authorTextField?.text = book.author
        author = book.author
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "zh_cn")
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        publicDateTextField?.text = dateFormatter.string(from: book.publicDate)
        publicDate = book.publicDate
        datePicker.setDate(book.publicDate, animated: true)
        
        switch book.category {
        case .normal:
            uiPicker.selectRow(0, inComponent: 0, animated: true)
        case .science:
            uiPicker.selectRow(1, inComponent: 0, animated: true)
        case .history:
            uiPicker.selectRow(2, inComponent: 0, animated: true)
        case .math:
            uiPicker.selectRow(3, inComponent: 0, animated: true)
        case .novel:
            uiPicker.selectRow(4, inComponent: 0, animated: true)
        }
        category = book.category
        
        
    }
    
    
    //MARK: - rightButtonAction
    @objc func saveButtonAction() {
        
        guard let bookTitle else {
            print("请输入标题")
            return
        }
        guard let author else {
            print("请输入作者")
            return
        }
        guard let publicDate else {
            print("请输入日期")
            return
        }
        guard let category  else {
            print("请输入种类")
            return
        }
           
        
        book.bookTitle = bookTitle
        book.author = author
        book.publicDate = publicDate
        book.category = category
        guard let addDelegate else {
            print("no delegate")
            return
        }

        print("saveButtonbook", book)
        addDelegate(book)
        navigationController?.popViewController(animated: true)
    }

    
}


extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    //MARK: - 添加cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let inputcell = tableView.dequeueReusableCell(withIdentifier: "inputcell") as? InputTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.item == 0 {
            inputcell.textField.placeholder = "书籍名称"
            bookTitleTextField = inputcell.textField
        } else if indexPath.item == 1 {
            inputcell.textField.placeholder = "作者"
            authorTextField = inputcell.textField
        } else if indexPath.item == 2 {
            inputcell.textField.placeholder = "出版时间"
            publicDateTextField = inputcell.textField
        }
        inputcell.textField.delegate = self
        inputcell.textField.tag = indexPath.item
        return inputcell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

//MARK: - UITextFieldDelegate
extension DetailViewController: UITextFieldDelegate {
   
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            bookTitle = textField.text
        case 1:
            author = textField.text
        default :
            break
        }

    }
    
    
    
}

//MARK: - PickerViewDelegate
extension DetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component: Int) -> Int {
        5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch row {
        case 0:
            return "normal"
        case 1:
            return "science"
        case 2:
            return "history"
        case 3:
            return "math"
        case 4:
            return "novel"
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch row {
        case 0:
            category = .normal
        case 1:
            category = .science
        case 2:
            category = .history
        case 3:
            category = .math
        case 4:
            category = .novel
        default:
            break
        }
        print("第\(uiPicker.selectedRow(inComponent: 0))行")
    }
    
    //MARK: - DatePicker
    @objc func dateChange(_ sender: UIDatePicker) {
        guard let publicDateTextField else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        let formaterString = dateFormatter.string(from: sender.date)
        print(formaterString)
        publicDateTextField.text = formaterString
        publicDate = sender.date

    }

}
