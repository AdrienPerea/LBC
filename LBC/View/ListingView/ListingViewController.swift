//
//  ViewController.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import UIKit

class ListingViewController: UICollectionViewController {

    // MARK: - Private properties

    private var repository: AnnonceRepositoryProtocol!
    private let viewModel: ListingViewModel = ListingViewModel()

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
        self.collectionView.register(ListingCell.self, forCellWithReuseIdentifier: "cell")
        configureViewModel()
        configurePullToRefresh()
        viewModel.fetchDatas()
        collectionView.refreshControl?.beginRefreshing()
    }

    // MARK: - Private methods

    private func configureViewModel() {
        viewModel.reloadHandler = { [weak self] in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.collectionView.reloadData()
                me.collectionView.refreshControl?.endRefreshing()
            }
        }
    }

    private func configurePullToRefresh() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(reloadDatas), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }

    @objc private func reloadDatas() {
        collectionView.refreshControl?.beginRefreshing()
        viewModel.fetchDatas()
    }

    // MARK: - LoadView

    override func loadView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 24) / 2, height: (UIScreen.main.bounds.width - 24) / 2 * 1.92)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    // MARK: - CollectionView methods

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListingCell
        collectionCell.backgroundColor = .white
        collectionCell.configure(annonce: viewModel.annonces[indexPath.item])
        return collectionCell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVM = DetailsViewModel(annonce: viewModel.annonces[indexPath.item])
        let viewController = DetailsViewController(viewModel: detailsVM)
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true, completion: nil)
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.annonces.count
    }
}
