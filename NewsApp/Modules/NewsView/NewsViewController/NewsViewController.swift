//
//  NewsViewController.swift
//  NewsApp
//
//  Created by Dastan on 12/2/23.
//

import UIKit
import SnapKit

class NewsViewController: ViewController {
    
    private lazy var newsTableView: UITableView = {
        let n = UITableView()
        
        n.backgroundColor = .clear
        
        n.delegate = self
        n.dataSource = self
        
        n.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        n.rowHeight = UITableView.automaticDimension
        n.estimatedRowHeight = 300
        
        
        return n
    }()
    
    var news: [Arcticle] = []
    
    let network = NetworkManager.shared
    
    let spaceBetweenTables: CGFloat = 2
    
    private var searchNewsText = ""
    
    private var searchLanguage = "ru"
    
    init(searchNewsText: String) {
        self.searchNewsText = searchNewsText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        network.getNewsDetails(keyWord: searchNewsText, language: searchLanguage)
        network.networkDelegate = self
        
        print("second: \(searchNewsText)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let color = UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.title = "News"
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.backgroundColor = color
        self.navigationController?.navigationBar.barTintColor = color
        
    }
    
    override func setupSubviews() {
        view.addSubview(newsTableView)
    }
    
    override func setupConstraints() {
        
        newsTableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(0)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(0)
        }
    }
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        news.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let arcticleName = news[indexPath.section]
        print("articleName:", arcticleName)
        cell.initialSetup(article: arcticleName)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        newsTableView.deselectRow(at: indexPath, animated: true)
        
        let article = news[indexPath.section]
        
        let detailVC = DetailsViewController(newsName: article.title, article: article)
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return spaceBetweenTables
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        return headerView
    }
}

extension NewsViewController: NetworkManagerDelegate {
    func fetchNews(name: NewsModelAPI) {
        self.news = name.articles
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    func errorFetch(error: Error) {
        print(error)
    }
}
