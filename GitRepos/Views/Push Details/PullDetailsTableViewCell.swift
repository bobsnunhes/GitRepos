//
//  PullDetailsTableViewCell.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 21/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import UIKit

class PullDetailsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bottonMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
