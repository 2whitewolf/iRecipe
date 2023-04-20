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
//    @Binding var recipe: Meal?
    private var cancellables: Set<AnyCancellable> = []
    private let realm = RealmService()
    init(){
    }
    
    
    func saveRecipe(recipe: Meal?) {
        guard let recipe = recipe else { return }
       
            
            realm.addRecipe(recipe.toRealm())
                .sink(receiveCompletion: { result in
                    switch result {
                    case .failure(let error):
                        print("Failed to save: \(error.localizedDescription)")
                    case .finished:
                        break
                    }
                }, receiveValue: {  _ in
                })
                .store(in: &cancellables)
        
    }
}
