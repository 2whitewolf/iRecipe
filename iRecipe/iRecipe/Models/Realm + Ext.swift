//
//  Realm + Ext.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation
import RealmSwift
//import RxSwift


extension Object {
  static func build<O: Object>(_ builder: (_ object: O) -> () ) -> O {
    let object = O()
    builder(object)
    return object
  }
}
