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
    func findByName() -> AnyPublisher<MealData, AFError>
}

struct APIManager: APIProtocol {
    func findByName() -> AnyPublisher<MealData, AFError> {
        let url = makeUrl(make: .getCategories)
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
//        return URL(string: "\(make.baseURL)\(make.path)")!
        var urlComponent = URLComponents()

        urlComponent.scheme = "https"
        urlComponent.host = make.baseURL
        urlComponent.path = make.baseURL + make.path
        
        return urlComponent.url!
    }
}


