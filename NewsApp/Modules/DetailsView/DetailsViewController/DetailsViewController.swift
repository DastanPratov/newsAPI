//
//  DetailsViewController.swift
//  NewsApp
//
//  Created by Dastan on 13/2/23.
//

import UIKit
import SnapKit

class DetailsViewController: ViewController {
    
    private lazy var imageView: UIImageView = {
        let i = UIImageView()
        i.contentMode = .scaleToFill
        
        return i
    }()
    
    private lazy var newsNameText: UILabel = {
        let n = UILabel()
        n.font = UIFont.systemFont(ofSize: 20, weight: .black)
        n.numberOfLines = 0
        
        return n
    }()
    
    private lazy var detailNewsText: UILabel = {
        let d = UILabel()
        d.font = UIFont.systemFont(ofSize: 16, weight: .light)
        d.textAlignment = .left
        d.textColor = .black
        d.backgroundColor = .clear
        d.numberOfLines = 0
        
        return d
    }()
    
    var article: Arcticle
    
    var newsName: String
    
    let imageDownloader = ImageNetworkSevice.shared
    
    init(newsName: String, article: Arcticle) {
        self.newsName = newsName
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let color = UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1)
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.backgroundColor = .black
        self.navigationController?.navigationBar.tintColor = color
        
        view.backgroundColor = color
        
        setupInitial()
    }
    
    override func setupSubviews() {
        view.addSubview(newsNameText)
        view.addSubview(detailNewsText)
        view.addSubview(imageView)
    }
    
    override func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.leading.equalToSuperview().offset(0)
            $0.trailing.equalToSuperview().offset(0)
            $0.height.equalTo(200)
        }
        
        newsNameText.snp.makeConstraints {
            $0.top.equalTo(imageView.safeAreaLayoutGuide.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
        
        detailNewsText.snp.makeConstraints {
            $0.top.equalTo(newsNameText.safeAreaLayoutGuide.snp.bottom).offset(14)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func setupInitial() {
        newsNameText.text = article.title
        detailNewsText.text = article.description
        if let urlImage = article.urlToImage {
            imageDownloader.createImgaeRequest(imageURL: urlImage) { [weak self] (data) in
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
