//
//  SelectTablesButton.swift
//  Edutainment
//
//  Created by Damien Chailloleau on 26/11/2023.
//

import SwiftUI

struct SelectTablesButton: View {
    
    typealias ActionHandler = () -> Void
    
    var textStatus: String
    var handler: ActionHandler
    
    init(textStatus: String, handler: @escaping SelectTablesButton.ActionHandler) {
        self.textStatus = textStatus
        self.handler = handler
    }
    
    var body: some View {
        Button(action: handler) {
            Text(textStatus)
        }
        .font(.headline)
        .foregroundStyle(.black)
        .frame(width: 300, height: 55)
        .background(.thinMaterial)
        .clipShape(.capsule)
        .shadow(color: .black, radius: 3, x: 2, y: -2)
    }
}

#Preview {
    SelectTablesButton(textStatus: "Empty") { }
}
