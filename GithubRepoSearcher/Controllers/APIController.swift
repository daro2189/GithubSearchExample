//
//  APIController.swift
//  GithubRepoSearcher
//
//  Created by Dariusz Mazur on 25/01/2021.
//  Copyright © 2021 eRapid Studio. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


protocol APIProtocole {

    func onSuccessResponse<T>(responseObj: T)
    
    func onFailedResponse()
}

class APIController {
    
    private static var SERVER_URL = "https://api.github.com"
    private static var SEARCH = "/search/repositories"
    
    class func defaultHeaders() -> HTTPHeaders {
        let headers: HTTPHeaders = [
            "Authorization": "Basic ZGFybzIxODk6OTlzZXpZeCZrR1dq",
            "Content-Type": "application/json",
            "Accept" : "application/vnd.github.v3+json"
        ]
        return headers
    }

    static func searchGithub(search: String, page: Int = 0, responseDelegate: APIProtocole) {
        let params : [String: Any] = [
            "q" : search,
            "per_page" : "30",
            "page" : page
        ]
        
        let request = AF.request(SERVER_URL + SEARCH, method: .get, parameters: params, encoding: URLEncoding.default, headers: defaultHeaders())
        request.responseJSON { (response) in
            switch response.result {
            case .success:
               //your success code
                if let JSON = response.value {
//                    print("JSON: \(JSON)")
                    responseDelegate.onSuccessResponse(responseObj: GithubSearchResponse(JSON: JSON as! [String : AnyObject]))
                }
                break
                
            case .failure:
                responseDelegate.onFailedResponse()
                break
            }
        }
    }
}
