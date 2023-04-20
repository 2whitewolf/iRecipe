//
//  UIApplication + Ext.swift
//  iRecipe
//
//  Created by Bogdan Sevcenco on 20.04.2023.
//

import Foundation
import SwiftUI
import UIKit
extension UIApplication {
    func dismissKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
