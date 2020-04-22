//
//  CheckListTableViewCell.swift
//  Checklist
//
//  Created by Maid Mehic on 22/04/2020.
//  Copyright © 2020 Maid Mehic. All rights reserved.
//

import UIKit

class CheckListItemTableViewCell: UITableViewCell {

    @IBOutlet weak var checkItemLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
