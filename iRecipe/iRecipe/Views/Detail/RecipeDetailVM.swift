//
//  RecipeDetailVM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//


import Foundation
import Combine
import SwiftUI

class RecipeDetailVM : ObservableObject {
    @Binding var recipe: Meal?
    
    init(recipe: Binding<Meal?>){
        self._recipe = recipe
    }
}
