//
//  Category.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import Foundation

// MARK: - Welcome
struct CategoryData: Decodable {
    let categories: [Category]
}

// MARK: - Category
struct Category: Identifiable,Decodable {
    var id = UUID()
    let strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}

extension Category {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let categoryDictionary = try container.decode([String: String?].self)
        

        id = UUID()
        strCategory = categoryDictionary["strCategory"] as? String ?? ""
        strCategoryThumb = categoryDictionary["strCategoryThumb"] as? String ?? ""
        strCategoryDescription = categoryDictionary["strCategoryDescription"] as? String ?? ""
    }
    
}
