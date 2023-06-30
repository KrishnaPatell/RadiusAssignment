//
//  FacilitiesCell.swift
//  iosAssignment
//
//  Created by C100-174 on 30/06/23.
//

import UIKit

class FacilitiesCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel! {
        didSet {
            lblName.textColor = kCOLOR_BLACK
            lblName.font = UIFont(name: fFONT_MEDIUM_O, size: calculateForWidth(size: 15.0))
        }
    }
    @IBOutlet weak var imgIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    

    
}
