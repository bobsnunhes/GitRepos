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
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var webURL: UITextView!
    @IBOutlet weak var language: UILabel!
    @IBOutlet weak var defaultBranch: UILabel!
    @IBOutlet weak var creationDate: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
