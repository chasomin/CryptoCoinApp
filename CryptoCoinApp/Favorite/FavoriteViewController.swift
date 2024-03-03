//
//  FavoriteViewController.swift
//  CryptoCoinApp
//
//  Created by 차소민 on 2/28/24.
//

import UIKit
import SnapKit

final class FavoriteViewController: BaseViewController {
    let viewModel = FavoriteViewModel()
    
    let emptyView = EmptyView()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
    let refreshControl = UIRefreshControl()
    private static func setCollectionViewLayout() -> UICollectionViewLayout{
        let layout = UICollectionViewFlowLayout()
        let space: CGFloat = 20
        let width = (UIScreen.main.bounds.width - (space * 3)) / 2
        layout.itemSize = CGSize(width: width, height: width)
        layout.minimumLineSpacing = space
        layout.minimumInteritemSpacing = space
        layout.sectionInset = UIEdgeInsets(top: space, left: space, bottom: space, right: space)
        layout.scrollDirection = .vertical
        return layout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Constants.NavigationTitle.favorite.rawValue
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: CircleUserImageBarButton())
        setCollectionView()
        viewModel.outputError.bind { value in
            guard let value else { return }
            self.showToast(text: value)
        }
        viewModel.outputData.bind { value in
            self.collectionView.reloadData()
            if value.isEmpty {
                self.collectionView.isHidden = true
            } else {
                self.collectionView.isHidden = false
            }
            
        }
        viewModel.outputRefresh.bind { value in
            guard let value else { return }
            self.collectionView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.inputViewWillAppearTrigger.value = ()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    override func configureHierarchy() {
        view.addSubview(emptyView)
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        emptyView.snp.makeConstraints { make in
            make.width.height.equalTo(300)
            make.center.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.backgroundColor = .backgroundColor
    }
}

extension FavoriteViewController {
    func setCollectionView() {
        collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshCell), for: .valueChanged)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        collectionView.register(FavoriteCollectionViewCell.self, forCellWithReuseIdentifier: FavoriteCollectionViewCell.id)
    }
    @objc func refreshCell() {
        viewModel.inputRefreshControl.value = ()
    }

}

extension FavoriteViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.outputData.value.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FavoriteCollectionViewCell.id, for: indexPath) as! FavoriteCollectionViewCell
        cell.configureCell(data: viewModel.outputData.value[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ChartViewController()
        vc.viewModel.id = viewModel.outputData.value[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, canHandle session: UIDropSession) -> Bool {
        return true
    }

    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let categoryCell = self.viewModel.outputData.value[sourceIndexPath.row]

        self.viewModel.outputData.value.remove(at: sourceIndexPath.row)
        self.viewModel.outputData.value.insert(categoryCell, at: destinationIndexPath.row)
//        self.viewModel.inputCellDragAndDrop.value = (categoryCell.id, destinationIndexPath.row)
    }
}
// TODO: 셀 순서 옮긴 거 저장 어떻게 하지
// realm에 regDate 를 Date()로 수정하고 sort 해도 network할 때 일정한 순서로 보내줌

extension FavoriteViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension FavoriteViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }

        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else { return }
            let categoryCell = self.viewModel.outputData.value[sourceIndexPath.row]

            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                self.viewModel.outputData.value.remove(at: sourceIndexPath.row)
                self.viewModel.outputData.value.insert(categoryCell, at: destinationIndexPath.row)
//                self.viewModel.inputCellDragAndDrop.value = (categoryCell.id, destinationIndexPath.row)
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
            })

        }

    }
    
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
    }

    
}
