//
//  RankTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class RankCell: UIView {
    let viewModel = TrendingViewModel()

    let rankTitleLabel = UILabel()
    let rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setRankCollectionViewLayout())

    static func setRankCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.2, height: 60)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewModel.inputFetchDataTrigger.value = ()
        viewModel.outputData.bind { _ in
            self.rankCollectionView.reloadData()
        }
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierarchy() {
        addSubview(rankTitleLabel)
        addSubview(rankCollectionView)
    }
    
    func configureLayout() {
        rankTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(safeAreaLayoutGuide).inset(15)
//            make.height.equalTo(30)
        }
        rankCollectionView.snp.makeConstraints { make in
            make.top.equalTo(rankTitleLabel.snp.bottom)
            make.height.equalTo(200)
            make.horizontalEdges.equalTo(safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        rankTitleLabel.font = .boldTitle
        
        rankCollectionView.delegate = self
        rankCollectionView.dataSource = self
        rankCollectionView.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.id)
        rankCollectionView.showsHorizontalScrollIndicator = false
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
        if viewModel.inputWhatKindOfCell.value == 1 {
            cell.configureCell(item: data.coins[indexPath.item].item, index: indexPath.item)
        } else {
            cell.configureCell(item: data.nfts[indexPath.item], index: indexPath.item)
        }
        return cell
    }
}
