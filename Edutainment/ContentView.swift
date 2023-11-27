//
//  ContentView.swift
//  Edutainment
//
//  Created by Damien Chailloleau on 18/11/2023.
//

import SwiftUI

struct ContentView: View {
    
    let denominator = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    
    @State private var choices = Set<Int>()
    
    @State private var questions = [Question]()
    
    @State private var listPosition: Int = 0
    @State private var score: Int = 0
    @State private var questionsLeft: Int = 10
    
    @State private var entryAnswer: String = ""
    @State private var gameStatusText: String = ""
    
    @State private var questionsLimit: Bool = false
    @State private var isGameStarted: Bool = false
    
    @State private var isPageOpened: Bool = false
    @State private var isAtLeastThreeTables: Bool = false
    
    @State private var editSelection: EditMode = .inactive
    
    @FocusState private var isAnswerEntered: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.red, .orange, .yellow], startPoint: .top, endPoint: .bottom).ignoresSafeArea()
                VStack {
                    
                    VStack {
                        SelectTablesButton(textStatus: "Tables Selected: \(choices.isEmpty ? "Empty" : choices.description)") {
                            self.isPageOpened = true
                        }
                        
                        Text("\(defineDefficulty)")
                            .font(.headline)
                            .foregroundStyle(choices.isEmpty ? .black : .white)
                            .frame(width: 300, height: 55)
                            .background(colorDifficulty)
                            .clipShape(.capsule)
                    }
                    .padding(.vertical, 5)
                    
                    Spacer().frame(height: 30)
                    
                    VStack {
                        HStack {
                            Text("Score: \(score)/10")
                            
                            Spacer()
                            
                            Text("Questions Left: \(questionsLeft)")
                        }
                        .font(.headline)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 10)
                        
                        Text(questions.isEmpty ? "" : "\(questions[listPosition].questionText)")
                            .font(.headline)
                        
                        TextField("Enter your Answer", text: $entryAnswer)
                            .keyboardType(.decimalPad)
                            .frame(width: 300, height: 65)
                            .textFieldStyle(.roundedBorder)
                            .focused($isAnswerEntered)
                        
                        ActionButton(textLabel: "Answer", imageLabel: "hand.thumbsup", backgroundColor: entryAnswer.isEmpty || questions.isEmpty ? .gray : .blue) {
                            answerQuestion()
                        }
                        .disabled(entryAnswer.isEmpty || questions.isEmpty)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.regularMaterial)
                    .clipShape(.rect(cornerRadius: 20))
                    
                    Spacer()
                    
                    ActionButton(textLabel: isGameStarted ? "Stop" : "Play", imageLabel: isGameStarted ? "square" : "play", backgroundColor: isGameStarted ? Color(red: 0.9, green: 0, blue: 0) : Color(red: 0, green: 0.9, blue: 0)) {
                        if isGameStarted {
                            resetQuestions()
                        } else {
                            generateQuestions()
                        }
                    }
                    
                }
                .navigationTitle("Edutainment")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Button {
                            self.isAnswerEntered = false
                        } label: {
                            Text("Close")
                                .foregroundStyle(.red.gradient)
                        }
                    }
                }
                .sheet(isPresented: $isPageOpened) {
                    ChooseTablesView(isPageOpened: $isPageOpened, choices: $choices)
                        .environment(\.editMode, $editSelection)
                }
                .alert("Not enough tables", isPresented: $isAtLeastThreeTables) {
                    Button("Ok") {}
                } message: {
                    Text("You need at least 3 tables selected")
                }
                .alert("\(gameStatusText)", isPresented: $questionsLimit) {
                    Button("Ok") { resetQuestions() }
                } message: {
                    Text("Your final score is \(score)/10")
                }
                .padding()
            }
            .ignoresSafeArea(.keyboard)
        }
    }
}

#Preview {
    ContentView()
}

// MARK: Functions & Computed Properties
extension ContentView {
    
    func generateQuestions() {
        var uniqueAnswers = Set<String>()
        
        if choices.count < 3 {
            self.isAtLeastThreeTables = true
        } else {
            while questions.count < 10 {
                let first = choices.randomElement()!
                let second = denominator.randomElement()!
                let answers = "\(first * second)"
                
                if uniqueAnswers.insert(answers).inserted {
                    questions.append(Question(questionText: "\(first) x \(second) is equal to", answerText: answers))
                }
            }
            self.isGameStarted = true
        }
    }
    
    func resetQuestions() {
        self.score = 0
        questionsLeft = 10
        listPosition = 0
        self.entryAnswer = ""
        self.choices.removeAll(keepingCapacity: false)
        questions.removeAll(keepingCapacity: false)
        questionsLimit = false
        self.isGameStarted = false
        self.isAnswerEntered = false
        
    }
    
    func answerQuestion() {
        questionsLeft -= 1
        if entryAnswer == questions[listPosition].answerText {
            self.score += 1
        } else {
            self.score = score + 0
        }
        if listPosition < 9 {
            listPosition += 1
        } else {
            questionsLimit = true
            gameStatusText = "Thank you for playing"
        }
        entryAnswer = ""
    }
    
    var defineDefficulty: String {
        switch choices.count {
        case 3...3:
            return "Easy"
        case 3..<7:
            return "Moderate"
        case 7..<9:
            return "Hard"
        case 9...9:
            return "Insane"
        default:
            return ""
        }
    }
    
    var colorDifficulty: Color {
        switch choices.count {
        case 3...3:
            return .green
        case 3..<7:
            return .yellow
        case 7..<9:
            return .red
        case 9...9:
            return .purple
        default:
            return .gray.opacity(0.3)
        }
    }
    
}
