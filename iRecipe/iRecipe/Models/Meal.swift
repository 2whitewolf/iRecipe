//
//  Meal.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import Foundation

struct MealData: Decodable{
    let meals: [Meal]
}

struct Meal: Identifiable, Decodable {
    let id: UUID
    let name: String
    let imageUrlString: String
    let country: String
    let ingredients: [Ingredient]
    let instructions: String
    let youtubeLink: String
    
    init(id: UUID = UUID() ,name: String, imageUrlString: String, country: String, ingredients: [Ingredient], instructions: String, youtubeLink: String) {
        self.id = id
        self.name = name
        self.imageUrlString = imageUrlString
        self.country = country
        self.ingredients = ingredients
        self.instructions = instructions
        self.youtubeLink = youtubeLink
    }
}

extension Meal {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)
        
        var index = 1
        var ingredients: [Ingredient] = []
        
        while let ingredient = mealDictionary["strIngredient\(index)"] as? String,
              let measure = mealDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            
            ingredients.append(.init(name: ingredient, measure: measure))
            index += 1
        }
    id = UUID()
        self.ingredients = ingredients
//        id = mealDictionary["idMeal"] as? Int ?? 0
        name = mealDictionary["strMeal"] as? String ?? ""
        country = mealDictionary["strArea"] as? String ?? ""
        imageUrlString = mealDictionary["strMealThumb"] as? String ?? ""
        instructions = mealDictionary["strInstructions"] as? String ?? ""
        youtubeLink = mealDictionary["strYoutube"] as? String ?? ""
    }
    
}

struct Ingredient: Decodable, Hashable {
    let name: String
    let measure: String
}

extension Meal: Equatable {
    static func == (lhs: Meal, rhs: Meal) -> Bool {
      if let statusLHS = lhs as? Meal,
         let statusRHS = rhs as? Meal {
        return statusLHS.id == statusRHS.id && statusLHS.name == statusRHS.name
      } else {
        return lhs.id == rhs.id
      }
    }
}
