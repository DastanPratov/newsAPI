//
//  TableViewCell.swift
//  NewsApp
//
//  Created by Dastan on 12/2/23.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var tableView: UIView!
    @IBOutlet weak var newsName: UILabel!
    @IBOutlet weak var newsDetails: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
        layer.borderWidth = 1
        layer.borderColor = UIColor(red: 0.184, green: 0.525, blue: 0.976, alpha: 1).cgColor
        
        setupNewsName()
        setupNewsDetails()
        
        
    }
    
    func setupNewsName() {
        newsName.font = UIFont.systemFont(ofSize: 20, weight: .black)
    }
    
    func setupNewsDetails() {
        newsDetails.font = UIFont.systemFont(ofSize: 16, weight: .light)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initialSetup(article: Arcticle) {
        newsName.text = article.title
        newsDetails.text = article.description
    }
}
