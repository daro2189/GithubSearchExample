//
//  ViewsProtocoles.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit


protocol TableViewProtocole {
    
    static func getCellIdentifier() -> String
    
    static func registerCell(_ tableView: UITableView)

    static func create<T : UITableViewCell>(_ tableView: UITableView, indexPath: IndexPath) -> T
}
