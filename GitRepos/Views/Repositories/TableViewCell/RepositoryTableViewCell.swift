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
    @IBOutlet weak var stargazers: UILabel!
    @IBOutlet weak var forks: UILabel!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isUserInteractionEnabled = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.startAnimating()
            self.isUserInteractionEnabled = false
        }
    }
    
    func stopLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.isUserInteractionEnabled = true
        }
    }
    
}
