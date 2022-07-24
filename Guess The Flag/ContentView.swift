//
//  ContentView.swift
//  Guess The Flag
//
//  Created by leila on 23.07.2022.
//

import SwiftUI

struct FlagImage: View {
    var name: String
    
    var body: some View {
        Image(name)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var showingFinal = false
    @State private var finalTitle = ""
    @State private var scoreTitle = ""
    @State private var score = 0
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "US"].shuffled()
    
    @State private var correntAnswer = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location:  0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location:  0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess The Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        
                        Text(countries[correntAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(name: countries[number])
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Ok", action: askQuestion)
        } message: {
            Text("Your score \(score)")
        }
        
        .alert(finalTitle, isPresented: $showingFinal) {
            Button("Done", action: reset)
        } message: {
            Text("Your score \(score)")
        }
        
        
    }
    
    func flagTapped(_ number: Int) {
        if number == correntAnswer {
            scoreTitle = "Correct"
            score += 1
        } else {
            scoreTitle = "Wrong , this flag is \(countries[number])"
            score -= 1
        }
        
        if score != 8 {
            showingScore = true
        } else {
            showingFinal = true
            finalTitle = "You win"
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correntAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        askQuestion()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

//MARK - homework
struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func totleStyle() -> some View {
        modifier(Title())
    }
}
