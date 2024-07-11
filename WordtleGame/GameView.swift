import SwiftUI

struct GameView: View {
    @State private var lengthOfWord: Int
    @State private var numCols = 0
    @State private var numRows = 0
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 8), count: 9)
    @State private var gridColors: [[Color]] = Array(repeating: Array(repeating: Color.white, count: 8), count: 9)
    @State private var keyboardKeys: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    @State private var keyColors: [Character: Color] = [:]
    @State private var currentRow = 0
    @State private var currentColumn = 0
    @State private var wordToGuess: String
    @State private var winOrLose = 0
    private var numberOfTries = Int()
    @State private var timeRemaining = 0
    @State private var timeOption = 0
    @State private var timer: Timer?
    @State private var imageOpac = 1.00
    
    
    
    
    init(lengthOfWord: Int, numberOfTries: Int, timeRemaining: Int) {
        self.lengthOfWord = lengthOfWord
        self.numberOfTries = numberOfTries
        self.timeRemaining = timeRemaining
        self.timeOption = timeRemaining
        wordToGuess = (words[lengthOfWord - 4].randomElement()!).uppercased()
        _numCols = State(initialValue: wordToGuess.count)
        _numRows = State(initialValue: numberOfTries)
    }
    
    
    
    
    
    
    var body: some View {
        ZStack {
            // Background image
            Image("ocean_cloud")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .alignmentGuide(.leading) { _ in 0 }
                .edgesIgnoringSafeArea(.all)
                .opacity(imageOpac)
            
            
            
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Text("Wordtle 🐢")
                    .textCase(.uppercase)
                    .padding()
                    .font(.custom("Futura", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 10)
                
                Text("Hurry, Guess the word to defuse \n the atom bomb!")
                    .textCase(.uppercase)
                    .font(.custom("Futura", size: 14))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 10)
                
                
                
                Text("Detonating in: \(timeRemaining) seconds")                    .font(.custom("Futura", size: 15))
                    .bold()
                    .font(.headline)
                    .padding()
                    .foregroundColor(.red)
                
                Spacer()
                
                GridView(grid: $grid, gridColors: $gridColors, numCols: $numCols, numRows: $numRows)
                    .padding(.bottom, 20)
                
                //Spacer() // too much space pushes out Enter and backspace
                //Spacer()
                Spacer()
                
                KeyboardView(keyboardKeys: $keyboardKeys, keyColors: $keyColors, handleKeyPress: handleKeyPress)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                
            }
            .onAppear {
                wordToGuess = (words[lengthOfWord - 4].randomElement()!).uppercased()
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
            
            
            
            
            if winOrLose != 0 {
                EndGamePopup(winOrLose: winOrLose, wordToGuess: wordToGuess, resetState: resetState)
            }
        }
        .padding()
        .navigationTitle(" ")
    }
    
    private func handleKeyPress(key: String) {
        if winOrLose>0 {
            return
        }
        if key == "Enter" {
            if currentColumn == numCols {
                for (index, letter) in grid[currentRow].enumerated() {
                    if index < numCols {
                        if Array(wordToGuess)[index] == Character(letter) {
                            gridColors[currentRow][index] = Color.green
                            keyColors[Character(letter)] = Color.green
                        } else if wordToGuess.contains(letter) {
                            gridColors[currentRow][index] = Color.yellow
                            if keyColors[Character(letter)] != Color.green {
                                keyColors[Character(letter)] = Color.yellow
                            }
                        } else {
                            gridColors[currentRow][index] = Color.gray
                            if keyColors[Character(letter)] != Color.green && keyColors[Character(letter)] != Color.yellow {
                                keyColors[Character(letter)] = Color.black
                            }
                        }
                    }
                }
                let arrayToCheck = Array(gridColors[currentRow][0..<numCols])
                if arrayToCheck.allSatisfy({ $0 == Color.green }) {
                    winOrLose = 1
                } else if currentRow == numRows - 1 {
                    winOrLose = 2
                } else {
                    currentColumn = 0
                    currentRow += 1
                }
            }
        } else if key == "Backspace" {
            if currentColumn > 0 {
                currentColumn -= 1
                grid[currentRow][currentColumn] = ""
            }
        } else if currentRow < numRows && currentColumn < numCols {
            grid[currentRow][currentColumn] = key
            currentColumn += 1
        }
        
        if currentRow >= numRows {
            resetState()
        }
    }
    
    
    
    
    
    
    
    
    
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if winOrLose == 0 {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    imageOpac = imageOpac - (1.00/Double(timeOption))
                }
                else {
                    timer?.invalidate()
                    winOrLose = 2
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    func resetState() {
        grid = Array(repeating: Array(repeating: "", count: 8), count: 9)
        gridColors = Array(repeating: Array(repeating: Color.white, count: 8), count: 9)
        keyboardKeys = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
        keyColors = [:]
        currentRow = 0
        currentColumn = 0
        wordToGuess = (words[lengthOfWord - 4].randomElement()!).uppercased()
        numRows = numberOfTries
        winOrLose = 0
        timeRemaining = self.timeOption
        imageOpac = 1
        startTimer()
    }
}

#Preview {
    GameView(lengthOfWord: 8, numberOfTries: 8, timeRemaining: 45)
}
