//
//  PodcastsTableViewCell.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import UIKit

struct PodcastsTableViewCellConstants {
    static let identifier = "PodcastsTableViewCell"
    static let height: CGFloat = 100
    
    static let cornerRadiusOfThumbnail: CGFloat = 10
    static let favouritedText = "Favourited"
    static let unFavouritedText = " "
}

struct PodcastsTableViewCellThemeConstants {
    static let headingFontSize: CGFloat = 17
    static let subheadingFontSize: CGFloat = 15
}

class PodcastsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: ImageDownloaderImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var favouriteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUIStyle()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: Private methods
    
    private func setUIStyle() {
        thumbnailImageView.layer.cornerRadius = PodcastsTableViewCellConstants.cornerRadiusOfThumbnail
        
        titleLabel.font = UIFont.systemFont(ofSize: PodcastsTableViewCellThemeConstants.headingFontSize)
        titleLabel.textColor = .black
        
        publisherNameLabel.font = UIFont.italicSystemFont(ofSize: PodcastsTableViewCellThemeConstants.subheadingFontSize)
        publisherNameLabel.textColor = .gray
        
        favouriteLabel.font = UIFont.systemFont(ofSize: PodcastsTableViewCellThemeConstants.subheadingFontSize)
        favouriteLabel.textColor = .red
    }
    
    //MARK: Public methods
    
    func load(podcast: Podcast?) {
        //Reset the UI before filling
        titleLabel.text = ""
        publisherNameLabel.text = ""
        favouriteLabel.text = ""
        thumbnailImageView.image = nil
        
        //Fill the podcast information
        if let podcast = podcast {
            titleLabel.text = podcast.title
            publisherNameLabel.text = podcast.name
            favouriteLabel.text = podcast.isFavourite ? PodcastsTableViewCellConstants.favouritedText: PodcastsTableViewCellConstants.unFavouritedText
            
            if let url = URL(string: podcast.thumbNailUrl) {
                self.thumbnailImageView.load(url: url)
            }
        }
    }
    
    
    
}
