//
//  Question.swift
//  Edutainment
//
//  Created by Damien Chailloleau on 19/11/2023.
//

import Foundation

struct Question: Identifiable {
    var id: String = UUID().uuidString
    var questionText: String
    var answerText: String
}
