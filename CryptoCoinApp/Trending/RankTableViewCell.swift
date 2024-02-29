//
//  RankTableViewCell.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 3/1/24.
//

import UIKit
import SnapKit

final class RankTableViewCell: BaseTableViewCell {
    let viewModel = TrendingViewModel()

    let rankTitleLabel = UILabel()
    let rankCollectionView = UICollectionView(frame: .zero, collectionViewLayout: setRankCollectionViewLayout())

    static func setRankCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 1.2, height: 65)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.scrollDirection = .horizontal
        return layout
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        viewModel.inputFetchDataTrigger.value = ()
        viewModel.outputData.bind { _ in
            self.rankCollectionView.reloadData()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configureHierarchy() {
        contentView.addSubview(rankTitleLabel)
        contentView.addSubview(rankCollectionView)
    }
    
    override func configureLayout() {
        rankTitleLabel.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView.safeAreaLayoutGuide).inset(15)
        }
        rankCollectionView.snp.makeConstraints { make in
            make.top.equalTo(rankTitleLabel.snp.bottom)
            make.horizontalEdges.bottom.equalTo(contentView.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        rankTitleLabel.font = .boldTitle

        rankCollectionView.delegate = self
        rankCollectionView.dataSource = self
        rankCollectionView.register(RankCollectionViewCell.self, forCellWithReuseIdentifier: RankCollectionViewCell.id)
        rankCollectionView.showsHorizontalScrollIndicator = false
    }

}

extension RankTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
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
