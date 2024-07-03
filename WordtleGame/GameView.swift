import SwiftUI

struct GameView: View {
    @State private var lengthOfWord: Int
    @State private var numCols = 5
    @State private var numRows = 6
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 8), count: 9)
    @State private var gridColors: [[Color]] = Array(repeating: Array(repeating: Color.gray, count: 8), count: 9)
    @State private var keyboardKeys: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    @State private var keyColors: [Character: Color] = [:]
    @State private var currentRow = 0
    @State private var currentColumn = 0
    @State private var wordToGuess : String
    @State private var winOrLose = 0
    
    
    init(lengthOfWord: Int) { // initialize numCols and numRows according to word length
        self.lengthOfWord = lengthOfWord
        wordToGuess = (words[lengthOfWord - 4].randomElement()!).uppercased() //this looks at the value of the level that user chose from content view and then gets a random word from the corresponding array
        _numCols = State(initialValue: wordToGuess.count )
        _numRows = State(initialValue: wordToGuess.count + 1 )
        
    }
    
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
                Spacer() //so that title doesnt show behind camera hole
                Text("Wordtle 🐢")
                    .textCase(.uppercase)
                    .padding()
                    .font(.custom("Futura", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .shadow(radius: 10)
                
                Spacer()
                
                
                
                GridView(grid: $grid, gridColors: $gridColors, numCols: $numCols, numRows: $numRows)
                    .padding(.bottom, 20)
                
                Spacer()
                
                KeyboardView(keyboardKeys: $keyboardKeys, keyColors: $keyColors, handleKeyPress: handleKeyPress)
                
                Spacer()
            }
            .onAppear {wordToGuess = (words[lengthOfWord - 4].randomElement()!).uppercased()}
            
            if winOrLose != 0 {
                EndGamePopup(winOrLose: winOrLose, wordToGuess: wordToGuess, resetState: resetState)
                    
            }
        }
        .padding()
        .navigationTitle(" ")
    }
    
    private func handleKeyPress(key: String) {
        if key == "Enter" {
            if currentColumn == numCols { //validate that numCols have been filled
                for (index, letter) in grid[currentRow].enumerated(){
                    if index<numCols { //to avoid array overflow on words less than 8
                        if  Array(wordToGuess)[index] == Character(letter) {
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
                // temp array to validate green. only validate "numCols"
                var arrayToCheck = Array(gridColors[currentRow][0..<numCols])
                if arrayToCheck.allSatisfy({ $0 == Color.green }) {
                    winOrLose = 1
                } else if currentRow == numCols {
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
    
    func resetState() {
        grid = Array(repeating: Array(repeating: "", count: 8), count: 9)
        gridColors = Array(repeating: Array(repeating: Color.gray, count: 8), count: 9)
        keyboardKeys = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
        keyColors = [:]
        currentRow = 0
        currentColumn = 0
        wordToGuess = (words[lengthOfWord - 4].randomElement()!).uppercased()
        numCols = wordToGuess.count
        numRows = wordToGuess.count + 1
        
        winOrLose = 0
    }
    
    
}

#Preview {
    GameView(lengthOfWord:6)
}
