//
//  CategoryVM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation
import Combine

class CategoryVM : ObservableObject {
    @Published var categories: [Category] = []
    @Published var finded: [Meal] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    
    init() {
        getCategories()
    }
    
    func getCategories() {
        networking.getCategories()
            .sink {[weak self] completion in
                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print(error)
                            case .finished:
                                break
                            }
                        } receiveValue: { categories in
                
                self.categories = categories.categories
            }
            .store(in: &cancellables)
    }
    
    func findByName(name: String){
        networking.findByName(name: name)
            .sink {[weak self] completion in
//                            guard let self = self else { return }
                            switch completion {
                            case .failure(let error):
                                print(error)
                            case .finished:
                                break
                            }
                        } receiveValue: { meals in
                            self.finded = meals.meals
            }
            .store(in: &cancellables)
    }
}
