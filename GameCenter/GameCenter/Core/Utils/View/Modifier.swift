//
//  CardModifier.swift
//  Game Center
//
//  Created by Dicoding Reviewer on 18/08/21.
//

import SwiftUI

struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}

struct ImageDetailModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 0)
    }
}
