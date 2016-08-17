//
//  TableViewCell.swift
//  TwiTCast
//
//  Created by Dean Martindale on 9/16/15.
//  Copyright © 2015 Dean Martindale. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    

    @IBOutlet weak var showThumbnailImageView: UIImageView!
    @IBOutlet weak var showTitleLabel: UILabel!
    @IBOutlet weak var tagLineLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }


}
