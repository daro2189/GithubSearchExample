//
//  GithubSearchResponse.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import ObjectMapper


class GithubSearchResponse {
    public var total_count: Int = 0
    public var incomplete_results: Bool = false
    
    public var items: [GithubRepository]? = nil
    
    
    required init?(map: Map) {
        mapping(map: map)
    }
}

extension GithubSearchResponse: Mappable {
    
    func mapping(map: Map) {
        total_count <- map["total_count"]
        incomplete_results <- map["incomplete_results"]
        items <- map["items"]
    }
}





class GithubRepository {
//    "2019-05-14T11:03:46Z"
    static let dateFormatterGet: DateFormatter = DateFormatter(withFormat: "yyyy-MM-dd'T'HH:mm:ssZ", locale: Locale.current.identifier)
    static let dateFormatterPrint: DateFormatter = DateFormatter(withFormat: "MMM dd,yyyy", locale: Locale.current.identifier)
    
    var name: String = ""
    public var stargazers_count: Int = 0
    var updated_at: String = ""
    var language: String = ""
    var owner: GithubOwner? = nil
    
    public var repositoryLanguage: String {
        get {
            return language
        }
    }
    
    public var repositoryUpdatedAt: String {
        get {
            if let date = GithubRepository.dateFormatterGet.date(from: updated_at) {
                return "Updated at ".localized + GithubRepository.dateFormatterPrint.string(from: date)
            }
            return ""
        }
    }
    
    public var repositoryName: String {
        get {
            if let o = owner {
                return "\(o.login)/\(name)"
            }
            return ""
        }
    }
    
    public var repositoryOwnerName: String {
        get {
            if let o = owner {
                return o.login
            }
            return ""
        }
    }
    
    public var repositoryURL: String {
        get {
            if let o = owner {
                return "\(o.html_url)/\(name)"
            }
            return ""
        }
    }
    
    required init?(map: Map) {
        
    }
}



extension GithubRepository: Mappable {
    
    func mapping(map: Map) {
        stargazers_count <- map["stargazers_count"]
        name <- map["name"]
        owner <- map["owner"]
        updated_at <- map["updated_at"]
        language <- map["language"]
    }
}



class GithubOwner {
    public var id: Int = 0
    public var login: String = ""
    public var avatar_url: String = ""
    public var gravatar_id: String = ""
    
    public var url: String = ""
    public var html_url: String = ""
  
    
    required init?(map: Map) {
        
    }
}

extension GithubOwner: Mappable {
    
    func mapping(map: Map) {
        id <- map["id"]
        login <- map["login"]
        avatar_url <- map["avatar_url"]
        gravatar_id <- map["gravatar_id"]
        url <- map["url"]
        html_url <- map["html_url"]
    }
}
