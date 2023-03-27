//
//  ArticleDetailController.swift
//  ReadAnd
//
//  Created by Master Lu on 2022/4/18.
//

import UIKit



class ArticleDetailController: BasicDetailViewController {
    
    private let scrollView = UIScrollView()
    private let titleLabel = UILabel()
    private let logoImageView = UIImageView()
    private let institutionLabel = UILabel()
    private let line = UIView()
    private let publicationDateView = UILabel()
    private let bodyLabel = UILabel()
    
    var value: Article = Article() {
        didSet {
            titleLabel.text = value.title
            logoImageView.image = UIImage(named: value.logoName)
            institutionLabel.text = value.institution
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.locale = Locale.init(identifier: "zh_CN")
            publicationDateView.text = formatter.string(from: value.publicationDate)
        }
    }
    
    //MARK: - Life circle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = value.institution
        
        
        let leftButton = LeftBarButton()
        self.navigationItem.leftBarButtonItem = leftButton
        leftButton.backButton.addTarget(self, action: #selector(leftBarButtonItemAction), for: .touchDown)
        
        let rightImage = UIImage(systemName: "star")
        let rightButton = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(rightBarButtonItemAction))
        self.navigationItem.rightBarButtonItem = rightButton
         
        
        self.view.backgroundColor = .white
        
        scrollView.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.text = "Return to the Office? Not in This Housing Market"
        titleLabel.font = .preferredFont(forTextStyle: .title2)
        titleLabel.numberOfLines = 0
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let image = UIImage(named: "WangyiNews")
        logoImageView.image = image
        logoImageView.contentMode = .scaleAspectFill
        logoImageView.layer.cornerCurve = .continuous
        logoImageView.layer.cornerRadius = 4
        logoImageView.layer.masksToBounds = true
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        institutionLabel.text = "Time.com"
        institutionLabel.alpha = 0.6
        institutionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        line.backgroundColor = UIColor(named: "mainLightOrange")
        line.translatesAutoresizingMaskIntoConstraints = false

        
        publicationDateView.text = "2020-03-29 08:34:38"
        publicationDateView.alpha = 0.6
        publicationDateView.frame = CGRect(x: 300, y: 0, width: 80, height: 40)
        publicationDateView.translatesAutoresizingMaskIntoConstraints = false
        
        bodyLabel.text = bodyText
        bodyLabel.numberOfLines = 0
        bodyLabel.font = .preferredFont(forTextStyle: .body)
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(logoImageView)
        scrollView.addSubview(institutionLabel)
        scrollView.addSubview(line)
        scrollView.addSubview(publicationDateView)
        scrollView.addSubview(bodyLabel)

        
        layoutSubViews()
    }
    
    @objc func leftBarButtonItemAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightBarButtonItemAction() {

    }
    
    func layoutSubViews() {
        let guide = view.safeAreaLayoutGuide
        let gap: CGFloat = 8
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: guide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: guide.widthAnchor),
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
            titleLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -26),
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30),
            logoImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
            logoImageView.widthAnchor.constraint(equalToConstant: 22),
            logoImageView.heightAnchor.constraint(equalToConstant: 22)
        ])
        NSLayoutConstraint.activate([
            institutionLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: gap),
            institutionLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 2),
            
            line.leadingAnchor.constraint(equalTo: institutionLabel.trailingAnchor, constant: gap),
            line.bottomAnchor.constraint(equalTo: institutionLabel.bottomAnchor, constant: -3),
            line.widthAnchor.constraint(equalToConstant: 3),
            line.heightAnchor.constraint(equalToConstant: 17),
            
            publicationDateView.leadingAnchor.constraint(equalTo: line.trailingAnchor, constant: gap),
            publicationDateView.bottomAnchor.constraint(equalTo: institutionLabel.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            bodyLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 20),
            bodyLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 14),
            bodyLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            bodyLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -28),
        ])
    }
    
    
    //MARK: - 眼动追踪
    override func performingNavigation() {
        navigationController?.popViewController(animated: true)
    }
    
}




let bodyText: String = """
In May of 2021, Sara Corcoran got a great job as an assistant project manager for a construction company in Dallas, working from home. Because the position was fully remote, she and her husband bought a 3-bedroom mobile home in Wylie, a lake community about 30 miles northeast of Dallas, in November. She loved the affordability of Wylie, where they paid $500 a month, less than half of what they had paid to rent a two-bedroom apartment in North Dallas, and that she could “smell the lake and see the stars.”
But eight months later, her company suddenly called everyone back to the office and told her she wasn’t remote any more, she says. “They said, ‘We’re going to have everyone come back to the offices, we want to see your smiling faces,’” she says. Its offices are southwest of Dallas, an 80-mile commute one-way. She went in for two days, and after getting home at 8 p.m. and paying $15 per day in tolls, she quit. She had a new job lined up two days later.

Last week, when President Biden called on Americans to “get back to work and fill our great downtowns again,” he joined a cadre of politicians and businesses across the country calling for employees to return to their offices. They may not realize how out of touch they sound to workers like Corcoran, who have seen home prices rise 30%, rents rise roughly 16%, and the price of gas increase 78% over the past two years.

More than a third of jobs—often but not always ones performed by people with a college degree—can be performed from home, according to a University of Chicago analysis. What these workers hear when their employers call them back to the office is that they’re expected to either pay a big chunk of their paychecks to live close to the office or save money on rent and weather longer—and more expensive—commutes, as if the last two years of work-from-home hadn’t happened at all. Around 46% of companies had workers back in their offices in January or February of this year, compared to 29% at the end of 2021, according to a Challenger, Gray & Christmas survey.

Companies say they want workers back to foster collaboration and to help resuscitate the downtown businesses that have struggled with the absence of office workers. Many, like Google and Apple, are allowing employees to adopt a hybrid work structure, in which they come into the office two or three days a week. But that still requires workers who have become accustomed to having breakfast and dinner with their families over the past two years to either spend hours commuting three days a week, or spend the big bucks to live close to the office. In January, the median home prices in Mountain View, where Google has its headquarters, was $1.9 million. Even a family with two workers who make the average annual salary at Google—$134,386—would have to pay more than a third of their income each month to afford such a house.
"""
