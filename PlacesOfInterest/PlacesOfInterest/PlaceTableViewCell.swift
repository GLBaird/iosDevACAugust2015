//
//  PlaceTableViewCell.swift
//  PlacesOfInterest
//
//  Created by Leon Baird on 28/08/2015.
//  Copyright (c) 2015 Leon Baird. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {
    
    // outlets
    @IBOutlet weak var imagePreview: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
