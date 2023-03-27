//
//  SinglePageController.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/29.
//


import UIKit



class SinglePageController: UIViewController {
    
    var id: Int
    
    var textView: UITextView? {
        didSet {
            layout()
        }
    }
    var label = UILabel()
    var textViewBottomOffset: CGFloat = 25
    //MARK: - INIT
    init(id: Int) {
        self.id = id
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView?.isScrollEnabled = false
        textView?.translatesAutoresizingMaskIntoConstraints = false
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "\(id)/4673"
        label.layer.zPosition = 2
        label.font = .preferredFont(forTextStyle: .footnote)
        label.alpha = 0.6
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40),
        ])
    }
    
    
    
    func layout() {
        if let textView = textView {
            view.addSubview(textView)

            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                textView.topAnchor.constraint(equalTo: guide.topAnchor),
                textView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
                textView.bottomAnchor.constraint(equalTo: guide.bottomAnchor, constant: -textViewBottomOffset),
            ])
        }
    }
    
}
