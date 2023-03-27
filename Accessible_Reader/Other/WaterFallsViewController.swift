//
//  File.swift
//  ReadAndThink
//
//  Created by Master Lu on 2022/4/1.
//

import UIKit


class WaterFallsViewController: UIViewController {
    
    var collectionView: UICollectionView!

    var colors: [UIColor] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemPink
        let layout = WaterFallsLayout()
        collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)

        layout.delegate = self
        collectionView.dataSource = self
        colors = DataManager2.shared.generalColors(30)
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        collectionView.register(BasicsCell.self, forCellWithReuseIdentifier: BasicsCell.reuseID)

        view.addSubview(collectionView)
    }
}

  // MARK: - UICollectionViewDataSource

  extension WaterFallsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicsCell.reuseID, for: indexPath) as! BasicsCell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicsCell.reuseID, for: indexPath)
      cell.backgroundColor = colors[indexPath.row]
      return cell
    }
  }


  // MARK: - WaterFallsLayoutDelegate

  extension WaterFallsViewController: WaterFallsLayoutDelegate {
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath) -> CGFloat {
      let random = arc4random_uniform(4) + 2
      return CGFloat(random * 50)
    }
    
  }

