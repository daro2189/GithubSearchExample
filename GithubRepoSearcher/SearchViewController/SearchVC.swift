//
//  SearchVC.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import UIKit
import Foundation

class SearchVC : UIViewController {
    @IBOutlet weak var mainTable: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var dialogLoading: ActivityVC? = nil
    var searchedRepositories: Array<GithubRepository> = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SearchCell.registerCell(mainTable)
        mainTable.estimatedRowHeight = 85
        searchBar.delegate = self
    }

}


extension SearchVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        APIController.searchGithub(search: searchBar.text!, page: 0, responseDelegate: self)
        dialogLoading = ActivityVC.showProgressDialog("")
    }
}

extension SearchVC : APIProtocole {
    
    func onSuccessResponse<T>(responseObj: T) {
        if let obj = responseObj as? GithubSearchResponse, let items = obj.items {
            searchedRepositories = items
            
        } else {
            searchedRepositories = []
        }
        
        mainTable.reloadData()
        ActivityVC.hideDialog(dialogLoading)
    }
    
    func onFailedResponse() {
        searchedRepositories = []
        mainTable.reloadData()
        
        ActivityVC.hideDialog(dialogLoading)
        
        //here we can print error or so
        DialogUtils.showOKDialog("Error occured", message: "")
    }
    
    func openRepository(repoURL: String) {
        if let vc: WebViewVC = storyboard?.instantiateViewController(identifier: "WebViewVC") as? WebViewVC {
            vc.pageLink = repoURL
            present(vc, animated: true) { }
        }
    }
}

extension SearchVC : UITableViewDelegate, UITableViewDataSource {
    
    func getValueFor(position: Int) -> GithubRepository? {
        if position < 0 || position >= searchedRepositories.count {
            return nil
        }
        return searchedRepositories[position]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedRepositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchCell = SearchCell.create(tableView, indexPath: indexPath)
        if let value = getValueFor(position: indexPath.row) {
            cell.setup(value)
        } else {
            cell.setupAsError()
        }
        return cell
    }
 
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let value = getValueFor(position: indexPath.row) {
            openRepository(repoURL: value.repositoryURL)
            
        } else {
            //here we can print error or so
            DialogUtils.showOKDialog("Error occured", message: "")
        }
    }
}

