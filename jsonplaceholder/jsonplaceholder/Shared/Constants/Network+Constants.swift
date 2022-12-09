//
//  Network+Constants.swift
//  jsonplaceholder
//
//  Created by dmatiaz on 30/11/22.
//

import Foundation

// define the base urls used in the app in the case we have multiple enviroments
enum BaseURL {
    case production
    case development

    var url: String {
        switch self {
        case .production:
            return "https://jsonplaceholder.typicode.com/"
        case .development:
            return "https://jsonplaceholder.typicode.com/"
        }
    }
}

// define the endpoinds used in the app
enum Endpoint {
    case getPosts
    case getComments

    var url: String {
        switch self {
        case .getPosts:
            return "\(BaseURL.production.url)posts"
        case .getComments:
            return "\(BaseURL.production.url)comments?postId="
        }
    }
}

// this is a convenient error type just for the example
enum ServiceError: Error {
    case httpError // we could add as many as we want
    case defaultError // a default error in case something else happens
}

// this is a convenient error type just for the example
enum DataBaseError: Error {
    case errorSavingData // we could add as many as we want
    case defaultError // a default error in case something else happens
}
