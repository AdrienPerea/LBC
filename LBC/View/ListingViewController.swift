//
//  ViewController.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import UIKit

class ListingViewController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.alwaysBounceVertical = true
        self.collectionView.backgroundColor = .white
        self.collectionView.register(ListingCell.self, forCellWithReuseIdentifier: "cell")
    }

    override func loadView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 24) / 2, height: (UIScreen.main.bounds.width - 24) / 2 * 1.92)
        layout.scrollDirection = .vertical
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ListingCell
        collectionCell.backgroundColor = .white
        collectionCell.configure(annonce: Annonce.mock)
        return collectionCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailsVC = DetailsViewController(annonce: Annonce.mock)
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
}