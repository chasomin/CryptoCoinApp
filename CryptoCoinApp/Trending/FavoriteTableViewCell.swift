//
//  TrendingTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class FavoriteTableViewCell: BaseTableViewCell {
    let viewModel = FavoriteViewModel()

    let favoriteTitleLabel = UILabel()
    let favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFavoriteCollectionViewLayout())
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewModel.inputViewWillAppearTrigger.value = ()
        viewModel.outputData.bind { _ in
            self.favoriteCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func setFavoriteCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.5, height: 200)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: 15)
        layout.scrollDirection = .horizontal
        return layout
    }

    override func configureHierarchy() {
        contentView.addSubview(favoriteTitleLabel)
        contentView.addSubview(favoriteCollectionView)
    }
    
    override func configureLayout() {
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        favoriteTitleLabel.font = .boldTitle
        favoriteTitleLabel.text = TrendingCell.favorite.title

        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(TrendingFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: TrendingFavoriteCollectionViewCell.id)
        favoriteCollectionView.showsHorizontalScrollIndicator = false
    }
    
}

extension FavoriteTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.outputData.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingFavoriteCollectionViewCell.id, for: indexPath) as! TrendingFavoriteCollectionViewCell
        cell.configureCell(data: viewModel.outputData.value[indexPath.item])
        return cell
    }
}
