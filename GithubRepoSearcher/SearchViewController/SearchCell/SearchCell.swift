//
//  SearchCell.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import UIKit

class SearchCell: UITableViewCell {
    @IBOutlet weak var lRepoName: UILabel!
    @IBOutlet weak var lUserName: UILabel!
    @IBOutlet weak var lLanguage: UILabel!
    @IBOutlet weak var lUpdatedAt: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    // MARK: creating view

    public func setup(_ value: GithubRepository) {
        lRepoName.text = value.repositoryName
        lUserName.text = value.repositoryOwnerName
        lLanguage.text = value.repositoryLanguage
        lUpdatedAt.text = value.repositoryUpdatedAt
    }
    
    public func setupAsError() {
        lRepoName.text = "???"
        lUserName.text = "???"
        lLanguage.text = "???"
        lUpdatedAt.text = "???"
    }
}



extension SearchCell : TableViewProtocole {
    
    static func getCellIdentifier() -> String {
        return "SearchCell"
    }
    
    static func create<T>(_ tableView: UITableView, indexPath: IndexPath) -> T where T : UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: getCellIdentifier(), for: indexPath) as! T
    }
    
    static func registerCell(_ tableView: UITableView) {
        tableView.register(UINib(nibName: getCellIdentifier(), bundle: nil), forCellReuseIdentifier: getCellIdentifier())
    }
}



