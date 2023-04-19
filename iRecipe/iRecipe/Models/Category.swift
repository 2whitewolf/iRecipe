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
struct Category: Decodable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
}
