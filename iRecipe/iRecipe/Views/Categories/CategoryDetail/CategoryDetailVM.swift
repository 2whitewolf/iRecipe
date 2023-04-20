//
//  CategoryDetailVM.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//
import Foundation
import Combine

class CategoryDetailVM : ObservableObject {
    @Published var meals: [MealCategory] = []
    
    private var cancellables: Set<AnyCancellable> = []
    private let networking: APIProtocol = APIManager()
    
    init() {
//        getCategories()
    }
    
    func getMeals(name: String) {
        networking.findByCategory(name: name)
            .sink {[weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .failure(let error):
                    print(error)
                case .finished:
                    break
                }
            } receiveValue: { meals in
                self.meals = meals.meals
            }
            .store(in: &cancellables)
    }
    
    func getMealByid(id: String)  {
       
    }
}
