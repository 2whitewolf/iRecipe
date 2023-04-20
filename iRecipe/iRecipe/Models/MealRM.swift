//
//  MealRM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation
import RealmSwift
class RMMeal: Object{
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var imageURLString: String?
    @Persisted var country: String?
    @Persisted var ingredients: List<RMIngredient>
    @Persisted var instructions: String?
    @Persisted var youtubeLink: String?
}


class RMIngredient: Object{
    @Persisted var id = UUID()
    @Persisted var name : String
    @Persisted var measure : String
}
extension RMMeal {
    func toMain() -> Meal {
        return Meal(
            name: name,
            imageUrlString: imageURLString ?? "",
            country: country ?? "",
            ingredients: Array(ingredients).map{ $0.toMain() },
            instructions: instructions ?? "",
            youtubeLink: youtubeLink ?? ""
        )
    }
}


extension RMIngredient {
    func toMain() -> Ingredient {
        return Ingredient(
            name: name ,
            measure: measure
        )
    }
}




extension Meal {
    func toRealm() -> RMMeal {
        
        let ingredients = ingredients.map{ $0.toRealm() }
        let  rmIngredients = List<RMIngredient>()
        
        rmIngredients.append(objectsIn: ingredients)
        return RMMeal.build { object in
            object.id = id
            object.name = name
            object.imageURLString = imageUrlString
            object.country = country
            object.ingredients = rmIngredients
            object.instructions = instructions
            object.youtubeLink = youtubeLink
        }
    }
}

extension Ingredient {
    func toRealm() -> RMIngredient {
        return RMIngredient.build { object in
            object.name = name
            object.measure = measure
            
        }
    }
}
