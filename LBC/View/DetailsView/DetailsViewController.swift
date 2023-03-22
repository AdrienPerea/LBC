//
//  DetailsViewController.swift
//  LBC
//
//  Created by Adrien PEREA on 21/03/2023.
//

import UIKit

class DetailsViewController: UIViewController {

    // MARK: - Init

    init(viewModel: DetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private properties

    private var viewModel: DetailsViewModel

    private lazy var likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 16
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.white
        button.layer.cornerRadius = 16
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        return button
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor.darkGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var createdOnLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var siretLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14)
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
        imageView.backgroundColor = UIColor.white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private lazy var proLabel: UILabel = {
        let label = UILabel()
        label.text = "PRO"
        label.textAlignment = .center
        label.layer.cornerRadius = 6
        label.layer.borderColor = CGColor.init(red: 0, green: 0, blue: 0, alpha: 1)
        label.layer.borderWidth = 1
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    // MARK: - ViewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupScrollView()
    }
    
    // MARK: - Private Methods

    @objc private func closeView() {
        self.dismiss(animated: true)
    }

    private func configure() {
        let annonce = viewModel.annonce
        self.annonceImageView.downloaded(from: annonce.imagesURL.thumb ?? "")
        self.titleLabel.text = annonce.title
        self.priceLabel.text = "\(annonce.price) €"
        self.categoryLabel.text = "\(annonce.category)"
        self.createdOnLabel.text = annonce.creationDate.toDate().timeAgoSinceDate()
        self.descriptionLabel.text = annonce.description
        self.siretLabel.text = "N° SIRET: " + (annonce.siret ?? "")
    }

    private func setupScrollView() {
        view.backgroundColor = UIColor.white
        view.addSubview(scrollView)
        scrollView.addSubview(annonceImageView)
        scrollView.addSubview(likeButton)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(priceLabel)
        scrollView.addSubview(categoryLabel)
        scrollView.addSubview(createdOnLabel)
        scrollView.addSubview(closeButton)
        scrollView.addSubview(descriptionLabel)
        scrollView.backgroundColor = .white
        if viewModel.annonce.siret != nil {
            scrollView.addSubview(siretLabel)
            scrollView.addSubview(proLabel)
        }
        if viewModel.annonce.isUrgent {
            scrollView.addSubview(urgentLabel)
            urgentLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
            urgentLabel.widthAnchor.constraint(equalToConstant: 65).isActive = true
            urgentLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
            urgentLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
            if viewModel.annonce.siret != nil {
                urgentLabel.leftAnchor.constraint(equalTo: siretLabel.rightAnchor, constant: 8).isActive = true
            } else {
                urgentLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
            }
        }
        if viewModel.annonce.siret != nil {
            proLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
            proLabel.rightAnchor.constraint(equalTo: siretLabel.leftAnchor, constant: -8).isActive = true
            proLabel.widthAnchor.constraint(equalToConstant: 40).isActive = true
            proLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
            if !viewModel.annonce.isUrgent {
                siretLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8).isActive = true
            }
            siretLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 5).isActive = true
            siretLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        } else if !viewModel.annonce.isUrgent {
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 5).isActive = true
        }

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.isScrollEnabled = true

        annonceImageView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        annonceImageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        annonceImageView.heightAnchor.constraint(equalToConstant: (UIScreen.main.bounds.height/2)).isActive = true

        titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: annonceImageView.bottomAnchor, constant: 5).isActive = true

        categoryLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
        categoryLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8).isActive = true
        categoryLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16).isActive = true
        categoryLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true

        priceLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
        priceLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8).isActive = true
        priceLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16).isActive = true
        priceLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 5).isActive = true

        createdOnLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
        createdOnLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8).isActive = true
        createdOnLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16).isActive = true
        createdOnLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 5).isActive = true

        descriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 8).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -8).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 16).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: createdOnLabel.bottomAnchor, constant: 5).isActive = true

        likeButton.rightAnchor.constraint(equalTo: annonceImageView.rightAnchor, constant: -16).isActive = true
        likeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        likeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        likeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true

        closeButton.leftAnchor.constraint(equalTo: annonceImageView.leftAnchor, constant: 16).isActive = true
        closeButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: 32).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 32).isActive = true
    }

}
