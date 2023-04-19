//
//  RandomVM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import Foundation
import Combine

class RandomVM : ObservableObject {
    
    @Published var recipe: Meal?
    private var subscriptions: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    init() {
        getRandomRecipe()
    }
    
    private func getRandomRecipe() {
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
            .store(in: &subscriptions)
    }
}
