import SwiftUI

struct GameView: View {
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
    @State private var gridColors: [[Color]] = Array(repeating: Array(repeating: Color.gray, count: 5), count: 6)
    @State private var keyboardKeys: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    @State private var keyColors: [Character: Color] = [:]
    @State private var currentRow = 0
    @State private var currentColumn = 0
    @State private var wordToGuess = fiveLetterWords.randomElement()!
    @State private var winOrLose = 0
    
    var body: some View {
        ZStack {
            // Background image
            Image("ocean_cloud")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .alignmentGuide(.leading) { _ in 0 }  // Align to show the left side of the image
                .edgesIgnoringSafeArea(.all)
                .opacity(0.925)
            
            VStack {
                Text("Wordtle 🐢")
                    .textCase(.uppercase)
                    .padding()
                    .font(.custom("Helvetica Neue", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                
                Spacer()
                
                GridView(grid: $grid, gridColors: $gridColors)
                    .padding(.bottom, 20)
                
                Spacer()
                
                KeyboardView(keyboardKeys: $keyboardKeys, keyColors: $keyColors, handleKeyPress: handleKeyPress)
                
                Spacer()
            }
            
            if winOrLose != 0 {
                EndGamePopup(winOrLose: winOrLose, wordToGuess: wordToGuess, resetState: resetState)
                    .transition(.opacity)  // Add transition for smooth appearance
                    .animation(.easeInOut)  // Animate the transition
            }
        }
        .padding()
        .navigationTitle(" ")
    }
    
    private func handleKeyPress(key: String) {
        if key == "Enter" {
            if currentColumn == 5 {
                for (index, letter) in grid[currentRow].enumerated() {
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
                            keyColors[Character(letter)] = Color.gray
                        }
                    }
                }
                if gridColors[currentRow].allSatisfy({ $0 == Color.green }) {
                    winOrLose = 1
                } else if currentRow == 5 {
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
        } else if currentRow < 6 && currentColumn < 5 {
            grid[currentRow][currentColumn] = key
            currentColumn += 1
        }
        
        if currentRow >= 6 {
            resetState()
        }
    }
    
    func resetState() {
        grid = Array(repeating: Array(repeating: "", count: 5), count: 6)
        gridColors = Array(repeating: Array(repeating: Color.gray, count: 5), count: 6)
        keyboardKeys = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
        keyColors = [:]
        currentRow = 0
        currentColumn = 0
        wordToGuess = fiveLetterWords.randomElement()!
        winOrLose = 0
    }
}

#Preview {
    GameView()
}
