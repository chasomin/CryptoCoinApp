//
//  FavoriteViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

final class FavoriteViewController: BaseViewController {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    
    private static func setCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 20
        let width = (UIScreen.main.bounds.width - (space * 3)) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.NavigationTitle.favorite.rawValue
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.id)
    }

    override func configureHierarchy() {
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .clear

    }

}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        11
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.id, for: indexPath) as! FavoriteCollectionViewCell
        cell.iconImageView.image = UIImage(systemName: "heart")
        cell.nameLabel.text = "qweq"
        cell.symbolLabel.text = "123"
        cell.priceLabel.text = "₩12,947,918"
        cell.percentageLabel.text = "+14.24%"
        return cell
    }
}
