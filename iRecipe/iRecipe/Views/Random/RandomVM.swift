//
//  RandomVM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import Foundation
import Combine
import SwiftUI

class RandomVM : ObservableObject {
    
    @Published var recipe: Meal?
    @Published var saved: [Meal] = []
    private var cancellables: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    private let realm = RealmService()
    @Published var showAlert: Bool = false
    
    init() {
//        getRandomRecipe()
    }
    
     func getRandomRecipe() {
        networking.getRandomRecipe()
            .sink {[weak self] completion in
                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print(error)
                            case .finished:
                                break
                            }
                        } receiveValue: {[weak self] value in
                            guard let self = self else { return }
                            self.recipe = value.meals.first

                        }
            .store(in: &cancellables)
    }
    func getRecipes() {
        realm.getRecipe()
            .sink(receiveCompletion: { result  in
                switch result {
                case .failure(let error):
                    print("Failed to save: \(error.localizedDescription)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] recipes in
                self?.saved = recipes.map{ $0.toMain()}
            })
            .store(in: &cancellables)
    }
    
    func saveRecipe() {
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
