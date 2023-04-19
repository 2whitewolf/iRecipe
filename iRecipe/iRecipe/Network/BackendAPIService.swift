//
//  BackendAPIService.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import Foundation
enum BackendAPIService {
    case getCategories
    case getRandom
    case findByname(name: String)
    var baseURL: String {
      return  "www.themealdb.com/api/json/v1/1"
    }

    var path: String {
        switch self {
        case .getRandom:
            return "/random.php"
        case .getCategories:
            return "/categories.php"
        case .findByname(name: let name):
            return "/search.php?s=\(name)"
        }
    }
}
