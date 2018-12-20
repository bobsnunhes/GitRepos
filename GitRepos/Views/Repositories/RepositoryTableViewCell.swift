//
//  RepositoryTableViewCell.swift
//  GitRepos
//
//  Created by roberto fernandes filho on 19/12/2018.
//  Copyright © 2018 Betocorporation. All rights reserved.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {

    @IBOutlet weak var branchName: UILabel!
    @IBOutlet weak var branchDescription: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
