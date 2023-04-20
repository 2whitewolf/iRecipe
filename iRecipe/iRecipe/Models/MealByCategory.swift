//
//  MealByCategory.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation

struct MealCategoryData: Decodable{
    var meals: [MealCategory]
    enum CodingKeys: CodingKey {
        case meals
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.meals = try container.decode([MealCategory].self, forKey: .meals)
    }
}

struct MealCategory: Identifiable, Decodable {

    let id: UUID = UUID()
    let name: String
    let imageUrlString: String
    let idMeal: String
}

extension MealCategory {

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)

        name = mealDictionary["strMeal"] as? String ?? ""
        imageUrlString = mealDictionary["strMealThumb"] as? String ?? ""
        idMeal = mealDictionary["idMeal"] as? String ?? ""
    }

}


