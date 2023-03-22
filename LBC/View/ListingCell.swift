//
//  ListingCellView.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import UIKit

class ListingCell: UICollectionViewCell {

    // MARK: - Private properties

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createdOnLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var proLabel: UILabel = {
        let label = UILabel()
        label.text = "PRO"
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.borderWidth = 1
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var urgentLabel: UILabel = {
        let label = UILabel()
        label.text = "URGENT"
        label.textAlignment = .center
        label.backgroundColor = .white
        label.clipsToBounds = true
        label.layer.cornerRadius = 8
        label.layer.borderColor = UIColor.orange.cgColor
        label.layer.borderWidth = 2
        label.textColor = UIColor.orange
        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var annonceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor.white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.image = UIImage(systemName: "photo")
        return imageView
    }()

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Methods

    func configure(annonce: Annonce) {
        configureImageView(imagesURL: annonce.imagesURL)
        self.titleLabel.text = annonce.title
        self.priceLabel.text = "\(annonce.price) €"
        self.categoryLabel.text = annonce.category
        self.createdOnLabel.text = annonce.creationDate.toDate().timeAgoSinceDate()
        addViews(annonce: annonce)
    }

    // MARK: - Private methods

    private func configureImageView(imagesURL: ImagesURL) {
        annonceImageView.image = UIImage(systemName: "photo")
        if let url = imagesURL.thumb {
            annonceImageView.downloaded(from: url)
        }
    }

    private func addViews(annonce: Annonce) {
        for view in self.subviews{
            view.removeFromSuperview()
        }
        addSubview(annonceImageView)
        addSubview(likeButton)
        addSubview(titleLabel)
        addSubview(priceLabel)
        addSubview(categoryLabel)
        addSubview(createdOnLabel)

        if annonce.isUrgent {
            addSubview(urgentLabel)
            urgentLabel.leftAnchor.constraint(equalTo: annonceImageView.leftAnchor, constant: 8).isActive = true
            urgentLabel.topAnchor.constraint(equalTo: annonceImageView.topAnchor, constant: 8).isActive = true
            urgentLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
            urgentLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true
        }

        if annonce.siret != nil {
            addSubview(proLabel)
            proLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
            proLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
            proLabel.topAnchor.constraint(equalTo: annonceImageView.bottomAnchor, constant: 5).isActive = true
            proLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -30).isActive = true
        } else {
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        }

        annonceImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        annonceImageView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        annonceImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.width - 24) / 2 * 1.22).isActive = true

        titleLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: annonceImageView.bottomAnchor, constant: 5).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        priceLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true

        categoryLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        categoryLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true

        createdOnLabel.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        createdOnLabel.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        createdOnLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        createdOnLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5).isActive = true

        likeButton.rightAnchor.constraint(equalTo: annonceImageView.rightAnchor, constant: -8).isActive = true
        likeButton.topAnchor.constraint(equalTo: annonceImageView.topAnchor, constant: 8).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 24).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 24).isActive = true
    }

}
