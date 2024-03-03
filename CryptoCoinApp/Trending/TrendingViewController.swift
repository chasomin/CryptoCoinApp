//
//  TrendingViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

import Kingfisher

final class TrendingViewController: BaseViewController {
    var favoriteViewModel = FavoriteViewModel()
    
    let scrollView = UIScrollView()
    let vStack = UIStackView()
    let favoriteCell = FavoriteCell()
    let rankCoinCell = RankCell()
    let rankNFTCell = RankCell()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.NavigationTitle.trending.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: CircleUserImageBarButton())
        favoriteViewModel.outputData.bind { [weak self] value in
            guard let self else { return }
            if value.count < 2 {
                favoriteCell.isHidden = true
            } else {
                favoriteCell.isHidden = false
                favoriteCell.favoriteCollectionView.reloadData()
            }
        }
        favoriteViewModel.outputError.bind { [weak self] value in
            guard let self else { return }
            guard let value else { return }
            showToast(text: value)
        }
        favoriteCell.delegate = self
        rankCoinCell.delegate = self
    }
    
    deinit {
        print("트랜딩 뷰 DEINIT")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
