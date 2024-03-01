//
//  TrendingTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class FavoriteCell: UIView {
    var viewModel: FavoriteViewModel?

    let favoriteTitleLabel = UILabel()
    let favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFavoriteCollectionViewLayout())
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    static func setFavoriteCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.8, height: 180)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .horizontal
        return layout
    }

    func configureHierarchy() {
        addSubview(favoriteTitleLabel)
        addSubview(favoriteCollectionView)
    }
    
    func configureLayout() {
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(15)
        }
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        favoriteTitleLabel.font = .boldTitle
        favoriteTitleLabel.text = TrendingCell.favorite.title

        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(TrendingFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: TrendingFavoriteCollectionViewCell.id)
        favoriteCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension FavoriteCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel else { return 0 }
        return viewModel.outputData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingFavoriteCollectionViewCell.id, for: indexPath) as! TrendingFavoriteCollectionViewCell
        guard let viewModel else { return UICollectionViewCell() }
        cell.configureCell(data: viewModel.outputData.value[indexPath.item])
        return cell
    }
}
