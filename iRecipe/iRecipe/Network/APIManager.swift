//
//  APIManager.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 19.04.2023.
//

import Foundation
import Combine
import Alamofire

protocol APIProtocol {
    func getCategories() -> AnyPublisher<CategoryData, AFError>
    func getRandomRecipe() -> AnyPublisher<MealData, AFError>
    func findByName(name: String) -> AnyPublisher<MealData, AFError>
    func findByCategory(name: String) -> AnyPublisher<MealCategoryData, AFError>
    func getMealById(id: String) -> AnyPublisher<MealData, AFError>
}

struct APIManager: APIProtocol {
    func getMealById(id: String) -> AnyPublisher<MealData,AFError> {
        let url = makeUrl(make: .getMealById(id: id))
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: MealData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func findByCategory(name: String) -> AnyPublisher<MealCategoryData,AFError> {
        let url = makeUrl(make: .findByCategory(name: name))
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: MealCategoryData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func findByName(name: String) -> AnyPublisher<MealData, AFError> {
        let url = makeUrl(make: .findByname(name: name))
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: MealData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getRandomRecipe() -> AnyPublisher<MealData, AFError> {
        let url = makeUrl(make: .getRandom)
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: MealData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getCategories() -> AnyPublisher<CategoryData, AFError> {
        let url = makeUrl(make: .getCategories)
        return AF.request(url, method: .get)
            .validate()
            .publishDecodable(type: CategoryData.self)
            .value()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
extension APIManager{
    private func makeUrl(make: BackendAPIService) -> URL{
        let url = URL(string: "https://\(make.baseURL)\(make.path)")!
        return url
    }
}


