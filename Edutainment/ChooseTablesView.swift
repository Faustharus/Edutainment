//
//  ChooseTablesView.swift
//  Edutainment
//
//  Created by Damien Chailloleau on 24/11/2023.
//

import SwiftUI

struct ChooseTablesView: View {
    
    @Environment(\.editMode) var editMode
    
    @Binding var isPageOpened: Bool
    @Binding var choices: Set<Int>
    let numerator = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    var body: some View {
        VStack {
            Text("Select the Tables")
                .font(.title.bold())
            
            List(numerator, id: \.self, selection: $choices) {
                Text("\($0)")
            }
            .listStyle(.plain)
            
            if editMode?.wrappedValue == .active {
                Button(action: {
                    self.isPageOpened = false
                    editMode?.wrappedValue = .inactive
                }) {
                    Text("Back")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .frame(width: 300, height: 55)
                .background(.blue.gradient)
                .clipShape(.capsule)
            } else {
                Button(action: {
                    editMode?.wrappedValue = editMode?.wrappedValue == .active ? .inactive : .active
                }) {
                    Text(editMode?.wrappedValue == .active ? "" : "Select")
                        .font(.headline)
                        .foregroundStyle(.white)
                }
                .frame(width: 300, height: 55)
                .background(.blue.gradient)
                .clipShape(.capsule)
            }
        }
        .padding()
    }
}

#Preview {
    ChooseTablesView(isPageOpened: .constant(false), choices: .constant([0]))
}
