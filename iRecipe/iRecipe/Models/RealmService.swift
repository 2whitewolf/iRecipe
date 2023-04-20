//
//  RealmService.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation
import RealmSwift

class RealmService {
    
    static let shared = RealmService()
    let realm = try! Realm()

    func save<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            print("Error saving object: \(error.localizedDescription)")
        }
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print("Error deleting object: \(error.localizedDescription)")
        }
    }

    func deleteAll() {
        do {
            try realm.write {
                realm.deleteAll()
            }
        } catch {
            print("Error deleting all objects: \(error.localizedDescription)")
        }
    }

    func fetch<T: Object>(_ objectType: T.Type) -> Results<T> {
        return realm.objects(objectType)
    }

}
