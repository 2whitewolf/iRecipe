//
//  SavedVM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation
import Combine

class SavedVM : ObservableObject {
    @Published var recipes: [Meal] = []
    private let realm = RealmService()
    private var cancellables: Set<AnyCancellable> = []
    init() {
    }
    func getRecipes() {
        realm.getRecipe()
            .sink(receiveCompletion: { result in
                   switch result {
                   case .failure(let error):
                       print("Failed to get : \(error.localizedDescription)")
                   case .finished:
                       break
                   }
               }, receiveValue: { [weak self] recipe in
                   self?.recipes = recipe.map{ $0.toMain()}
               })
               .store(in: &cancellables)
    }
    
    func deleteReceipt(receipt: Meal) {
      
        realm.delete(receipt: receipt.toRealm())
            .sink {[weak self] completion in
                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print("Error deleting object: \(error.localizedDescription)")
                            case .finished:
                                break
                            }
                        } receiveValue: { _ in
                        }
            .store(in: &cancellables)
    }
}
