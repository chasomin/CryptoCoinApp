//
//  TrendingViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

enum TrendingCell: Int, CaseIterable {
    case favorite
    case topCoin
    case topNFT
    
    var title: String {
        switch self {
        case .favorite:
            "My Favorite"
        case .topCoin:
            "Top 15 Coin"
        case .topNFT:
            "Top 7 NFT"
        }
    }
}


final class TrendingViewController: BaseViewController {
    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.NavigationTitle.trending.rawValue
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.id)
        tableView.register(RankTableViewCell.self, forCellReuseIdentifier: RankTableViewCell.id)
        tableView.separatorStyle = .none
        tableView.rowHeight = 250
    }

}

extension TrendingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        TrendingCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch TrendingCell(rawValue: indexPath.row) {
        case .favorite :
            let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.id, for: indexPath) as! FavoriteTableViewCell
            return cell

        case .topCoin:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.id, for: indexPath) as! RankTableViewCell
            cell.rankTitleLabel.text = TrendingCell.topCoin.title
            cell.viewModel.inputWhatKindOfCell.value = indexPath.row
            return cell

        case .topNFT:
            let cell = tableView.dequeueReusableCell(withIdentifier: RankTableViewCell.id, for: indexPath) as! RankTableViewCell
            cell.rankTitleLabel.text = TrendingCell.topNFT.title
            cell.viewModel.inputWhatKindOfCell.value = indexPath.row
            return cell

        case .none:
            return UITableViewCell()
        }
    }
}
