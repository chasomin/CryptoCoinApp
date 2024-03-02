//
//  TrendingTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class FavoriteCell: BaseView {
    var viewModel: FavoriteViewModel?
    weak var delegate: ViewTransitionProtocol?

    let favoriteTitleLabel = UILabel()
    let favoriteCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setFavoriteCollectionViewLayout())
    
    static func setFavoriteCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.8, height: 180)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 0, right: UIScreen.main.bounds.width/2)
        layout.scrollDirection = .horizontal
        return layout
    }

    override func configureHierarchy() {
        addSubview(favoriteTitleLabel)
        addSubview(favoriteCollectionView)
    }
    
    override func configureLayout() {
        favoriteTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(15)
        }
        favoriteCollectionView.snp.makeConstraints { make in
            make.top.equalTo(favoriteTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        favoriteTitleLabel.font = .boldTitle
        favoriteTitleLabel.text = Constants.TrendingCellTitle.favorite.title
        favoriteCollectionView.delegate = self
        favoriteCollectionView.dataSource = self
        favoriteCollectionView.register(TrendingFavoriteCollectionViewCell.self, forCellWithReuseIdentifier: TrendingFavoriteCollectionViewCell.id)
        favoriteCollectionView.showsHorizontalScrollIndicator = false
        favoriteCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel else { return }
        delegate?.selecteCell(id: viewModel.outputData.value[indexPath.item].id)
    }
}

extension FavoriteCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrolledOffsetX = targetContentOffset.pointee.x + scrollView.contentInset.left
        let cellWidth = Const.itemSize.width + Const.itemSpacing
        let index = round(scrolledOffsetX / cellWidth)
        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
}
private enum Const {
    static let itemSize = CGSize(width: UIScreen.main.bounds.width / 1.8, height: 180)
    static let itemSpacing = 15.0

    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - Self.itemSize.width) / 2.0
    }
}
