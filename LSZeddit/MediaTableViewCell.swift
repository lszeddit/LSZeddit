//
//  MediaTableViewCell.swift
//  LSZeddit
//
//  Created by Carlos Acosta on 4/9/19.
//  Copyright © 2019 LSZTech. All rights reserved.
//

import UIKit

class MediaTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var postTitleLabel: UILabel!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var postAuthorLabel: UILabel!
    @IBOutlet weak var postTimeLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
