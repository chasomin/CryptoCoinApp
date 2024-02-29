//
//  SearchViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/27/24.
//

import UIKit
import SnapKit
import Kingfisher

protocol PassDataProtocol {
    func buttonTapped(tag: Int)
}

//TODO: 네트워트 할 때 로딩 뷰
final class SearchViewController: BaseViewController {
    let viewModel = SearchViewModel()
    let searchBar = UISearchBar()
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Constants.NavigationTitle.search.rawValue
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        searchBar.delegate = self
        viewModel.outputCoinList.bind { data in
            self.tableView.reloadData()
        }
        viewModel.outputError.bind { value in
            guard let value else { return }
            self.showToast(text: value)
        }
        viewModel.outputFavoriteButtonTapped.bind { value in
            guard let value else { return }
            self.tableView.reloadData()
            self.showToast(text: value)
        }
        viewModel.inputViewWillAppearTrigger.bind { _ in
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = ()
    }
    
    override func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
    }
    
    override func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        searchBar.placeholder = "코인 검색"
        searchBar.searchBarStyle = .minimal
        
        tableView.backgroundColor = .clear
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }

}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.outputCoinList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as! SearchTableViewCell
        let data = viewModel.outputCoinList.value[indexPath.row]
        let searchText = searchBar.text?.lowercased()
        cell.configureCell(data: data, searchText: searchText)
        cell.delegate = self
        cell.favoriteButton.tag = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.viewModel.id = viewModel.outputCoinList.value[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchButtonTapped.value = searchBar.text
    }
}


extension SearchViewController: PassDataProtocol {
    func buttonTapped(tag: Int) {
        viewModel.inputFavoriteButtonTapped.value = tag
        
    }
}
