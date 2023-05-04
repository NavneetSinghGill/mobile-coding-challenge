//
//  PodcastsTableViewCell.swift
//  mobile-coding-challenge
//
//  Created by Navneet Singh Gill on 2023-05-03.
//

import UIKit

struct PodcastsTableViewCellConstants {
    let identifier = "PodcastsTableViewCell"
    let height: CGFloat = 100
    
    let cornerRadiusOfThumbnail: CGFloat = 5
}

class PodcastsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var publisherNameLabel: UILabel!
    @IBOutlet weak var favouriteLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        thumbnailImageView.layer.cornerRadius = PodcastsTableViewCellConstants().cornerRadiusOfThumbnail
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        //TODO: make text italic
    }
    
}
