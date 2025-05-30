//
//  ArticleTableViewCell.swift
//  ShopList
//
//  Created by RK Adithya on 29/05/25.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    static let identifier = "ArticleTableViewCell"

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var headlineLabel: UILabel!


    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupViews()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    
    private func setupViews() {

        headlineLabel.font = UIFont(name: "Montserrat-SemiBold", size: 18)
        headlineLabel.textColor = .label
        headlineLabel.numberOfLines = 0
        articleImageView.clipsToBounds = true
        articleImageView.layer.masksToBounds = true

    }
    
    func configure(with article: Article) {
        
        let screenWidth = UIScreen.main.bounds.width
        let aspectRatio = article.image.height > 0 ? CGFloat(article.image.width) / CGFloat(article.image.width)  : 1.0
        let adjustedHeight = screenWidth / aspectRatio
        imageHeightConstraint.constant = adjustedHeight
        headlineLabel.text = article.title
        articleImageView.sd_setImage(with: URL(string: article.image.src), placeholderImage: UIImage(named: "preview"))
  
    }

}
