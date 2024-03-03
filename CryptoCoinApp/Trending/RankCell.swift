//
//  RankTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class RankCell: BaseView {
    let viewModel = TrendingViewModel()
    weak var delegate: ViewTransitionProtocol?
    let rankTitleLabel = UILabel()
    let rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setRankCollectionViewLayout())

    static func setRankCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.19, height: 60)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: UIScreen.main.bounds.width / 3)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.inputFetchDataTrigger.value = ()
        viewModel.outputData.bind { _ in
            self.rankCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        addSubview(rankTitleLabel)
        addSubview(rankCollectionView)
    }
    
    override func configureLayout() {
        rankTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(15)
        }
        rankCollectionView.snp.makeConstraints { make in
            make.top.equalTo(rankTitleLabel.snp.bottom)
            make.height.equalTo(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        rankTitleLabel.font = .boldTitle
        
        rankCollectionView.delegate = self
        rankCollectionView.dataSource = self
        rankCollectionView.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.id)
        rankCollectionView.showsHorizontalScrollIndicator = false
        rankCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
    }

}

extension RankCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = viewModel.outputData.value else { return 0 }
        if viewModel.inputWhatKindOfCell.value == 1 {
            return data.coins.count
        } else {
            return data.nfts.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RankCollectionViewCell.id, for: indexPath) as! RankCollectionViewCell
        guard let data = viewModel.outputData.value else { return UICollectionViewCell() }
        let coinSortData = data.coins.sorted {
            $0.item.marketRank ?? 0 < $1.item.marketRank ?? 0
        }
        if viewModel.inputWhatKindOfCell.value == 1 {
            cell.configureCell(item: coinSortData[indexPath.item].item, index: indexPath.item)
        } else {
            cell.configureCell(item: data.nfts[indexPath.item], index: indexPath.item)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let value = viewModel.outputData.value else { return }
        if viewModel.inputWhatKindOfCell.value == 1 {
            self.delegate?.selecteCell(id: value.coins.sorted(by: {
                $0.item.marketRank ?? 0 < $1.item.marketRank ?? 0
            })[indexPath.item].item.id)
        }
    }
}

extension RankCell: UIScrollViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let cv = scrollView as? UICollectionView {
            let layout = cv.collectionViewLayout as! UICollectionViewFlowLayout
            let cellWidth = layout.itemSize.width + layout.minimumLineSpacing
            
            var offset = targetContentOffset.pointee
            var index = round((offset.x + cv.contentInset.left) / cellWidth)
            
            if cv.contentOffset.x > targetContentOffset.pointee.x {
                index = floor(index)
            } else {
                index = ceil(index)
            }
            
            offset = CGPoint(x: index * cellWidth, y: -cv.contentInset.top)
            targetContentOffset.pointee = offset
            
        }
    }
}
