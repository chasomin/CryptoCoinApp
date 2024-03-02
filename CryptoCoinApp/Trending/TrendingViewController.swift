//
//  TrendingViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

final class TrendingViewController: BaseViewController {
    let favoriteViewModel = FavoriteViewModel()
    
    let scrollView = UIScrollView()
    let vStack = UIStackView()
    let favoriteCell = FavoriteCell()
    let rankCoinCell = RankCell()
    let rankNFTCell = RankCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.NavigationTitle.trending.rawValue
        
        favoriteViewModel.outputData.bind { value in
            if value.count < 2 {
                self.favoriteCell.isHidden = true
            } else {
                self.favoriteCell.isHidden = false
                self.favoriteCell.favoriteCollectionView.reloadData()
            }
        }
        favoriteViewModel.outputError.bind { value in
            guard let value else { return }
            self.showToast(text: value)
        }
        favoriteCell.delegate = self
        rankCoinCell.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        favoriteViewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func configureHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(vStack)
        vStack.addArrangedSubview(favoriteCell)
        vStack.addArrangedSubview(rankCoinCell)
        vStack.addArrangedSubview(rankNFTCell)
    }
    
    override func configureLayout() {
        scrollView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(rankNFTCell.snp.bottom)
        }
        vStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview()
        }
        rankCoinCell.snp.makeConstraints { make in
            make.height.equalTo(240)
        }
        rankNFTCell.snp.makeConstraints { make in
            make.height.equalTo(240)
        }
    }
    
    override func configureView() {
        vStack.axis = .vertical
        vStack.spacing = 10
        vStack.distribution = .fillEqually
        favoriteCell.viewModel = self.favoriteViewModel
        rankCoinCell.rankTitleLabel.text = Constants.TrendingCellTitle.topCoin.title
        rankCoinCell.viewModel.inputWhatKindOfCell.value = 1
        rankNFTCell.rankTitleLabel.text = Constants.TrendingCellTitle.topNFT.title
    }

}

extension TrendingViewController: ViewTransitionProtocol {
    func selecteCell(id: String) {
        let vc = ChartViewController()
        vc.viewModel.id = id
        navigationController?.pushViewController(vc, animated: true)
    }
}
