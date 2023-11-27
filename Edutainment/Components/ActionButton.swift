//
//  ActionButton.swift
//  Edutainment
//
//  Created by Damien Chailloleau on 26/11/2023.
//

import SwiftUI

struct ActionButton: View {
    
    typealias ActionHandler = () -> Void
    
    var textLabel: String
    var imageLabel: String
    var backgroundColor: Color
    var handler: ActionHandler
    
    init(textLabel: String, imageLabel: String, backgroundColor: Color, handler: @escaping ActionButton.ActionHandler) {
        self.textLabel = textLabel
        self.imageLabel = imageLabel
        self.backgroundColor = backgroundColor
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler) {
            Label(textLabel, systemImage: imageLabel)
        }
        .font(.title2)
        .foregroundStyle(.white)
        .frame(width: 300, height: 55)
        .background(backgroundColor)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black, radius: 3, x: 2, y: -2)
    }
}

#Preview {
    ActionButton(textLabel: "Answer", imageLabel: "hand.thumbsup", backgroundColor: .blue) { }
}
