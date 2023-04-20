//
//  RealmService.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

//import Foundation
//import RealmSwift
//
//class RealmService {
//
//    static let shared = RealmService()
//    let realm = try! Realm()
//
//    func save<T: Object>(_ object: T) {
//        do {
//            try realm.write {
//                realm.add(object)
//            }
//        } catch {
//            print("Error saving object: \(error.localizedDescription)")
//        }
//    }
//
//    func delete<T: Object>(_ object: T) {
//        do {
//            try realm.write {
//                realm.delete(object)
//            }
//        } catch {
//            print("Error deleting object: \(error.localizedDescription)")
//        }
//    }
//
//    func deleteAll() {
//        do {
//            try realm.write {
//                realm.deleteAll()
//            }
//        } catch {
//            print("Error deleting all objects: \(error.localizedDescription)")
//        }
//    }
//
//    func fetch<T: Object>(_ objectType: T.Type) -> Results<T> {
//        return realm.objects(objectType)
//    }
//
//}

import Foundation
import RealmSwift
import Combine

enum RealmError{
    case FailToSave
    case FailToLoad
    case FailToDelete
}

class RealmService {
    private var realm: Realm?
    
    init() {
        do {
            realm = try Realm()
        } catch {
            print("Failed to open Realm: \(error.localizedDescription)")
        }
    }
    
    func addRecipe(_ recipe: RMMeal) -> AnyPublisher<Void, Error> {
        guard let realm = realm else {
            return Fail(error: NSError(domain: "realm.not.initialized", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        do {
            
            if  realm.objects(RMMeal.self).filter({ $0.id == recipe.id }).count > 0 {
                return Fail(error: NSError(domain: "error to save", code: 0, userInfo: nil))
                    .eraseToAnyPublisher()
            }
            try realm.write {
                realm.add(recipe)
            }
            return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
    
    func getRecipe() -> AnyPublisher<Results<RMMeal>, Error> {
        guard let realm = realm else {
            return Fail(error: NSError(domain: "realm.not.initialized", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        let receipts = realm.objects(RMMeal.self)
        return Just(receipts).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    func delete(receipt: RMMeal) -> AnyPublisher<Void, Error> {
        guard let realm = realm else {
            return Fail(error: NSError(domain: "realm.not.initialized", code: 0, userInfo: nil))
                .eraseToAnyPublisher()
        }
        
        do {
           let item =  realm.objects(RMMeal.self).filter{ $0.id == receipt.id}
            try realm.write{
                realm.delete(item)
            }
            return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        } catch {
            return Fail(error: error).eraseToAnyPublisher()
        }
    }
}
