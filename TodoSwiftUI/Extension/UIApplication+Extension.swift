//
//  UIApplication+Extension.swift
//  TodoSwiftUI
//
//  Created by Taishi Kusunose on 2021/02/04.
//

import SwiftUI

extension UIApplication {
    func closeKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder),
                   to: nil,
                   from: nil,
                   for: nil)
    }
}
