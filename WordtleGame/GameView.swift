import SwiftUI

struct GameView: View {
    // Defines the grid for the letters it is 6 rows and 5 columns
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
    @State private var gridColors: [[Color]] = Array(repeating: Array(repeating: Color.gray.opacity(0.35) , count: 5), count: 6)
    @State private var keyboardKeys: [String] = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
    
    
    // Tracks the current row and column
    @State private var currentRow = 0
    @State private var currentColumn = 0
    @State private var wordToGuess = fiveLetterWords.randomElement()!
    
    var body: some View {
        ZStack {
            // Background image
            Image("1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .rotationEffect(.degrees(90))
                .opacity(0.925)
            VStack {
                Spacer()
                Text("Guess the 5 Letter Word")
                    .textCase(.uppercase)
                    .padding()
                    .bold()
                    .font(.custom("Courier", size: 25))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text("GREEN = CORRECT PLACE, CORRECT LETTER")
                
                    .bold()
                    .font(.custom("Courier", size: 16))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text("YELLOW = WRONG PLACE, CORRECT LETTER")
                
                    .bold()
                    .font(.custom("Courier", size: 16))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                Text("GREY = WRONG PLACE, WRONG LETTER")
                
                    .bold()
                    .font(.custom("Courier", size: 16))
                    .fontWeight(.heavy)
                    .foregroundColor(.black)
                
                Spacer()
                Spacer()
                // Display the grid of letter boxes
                VStack(spacing: 15) {
                    ForEach(0..<6, id: \.self) { row in
                        HStack(spacing: 10) {
                            ForEach(0..<5, id: \.self) { column in
                                Text(grid[row][column])
                                    .frame(width: 45, height: 45)
                                    .background(
                                        RoundedRectangle(cornerRadius: 5)
                                            .stroke(Color.black, lineWidth: 3)
                                            .background(gridColors[row][column])
                                    )
                                    .font(.title)
                                    .bold()
                                    .multilineTextAlignment(.center)
                            }
                        }
                    }
                }
                
                Spacer()
                Spacer()
                
                //this diplays the keybaord
                VStack(spacing: 10) { //
                    ForEach(keyboardKeys, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(row.map { String($0) }, id: \.self) { key in
                                Button(action: {
                                    handleKeyPress(key: key)
                                }) {
                                    Text(key)
                                        .frame(width: 32, height: 44)
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .cornerRadius(5)
                                }
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle(" ")
    }
    
    //handles when a key is pressed and also the color effect on the board. also resets the game when the rows are completed.
    private func handleKeyPress(key: String){
        if currentRow < 6 && currentColumn < 5 {
            grid[currentRow][currentColumn] = key
            currentColumn += 1
            
            // Move to next row if the current row is filled
            if currentColumn == 5 {
                for (index,letter) in grid[currentRow].enumerated(){
                    
                    if Array(wordToGuess)[index] == Character(letter) {
                        gridColors[currentRow][index] = Color.green
                        
                    }
                    
                    else if wordToGuess.contains(letter){
                        gridColors[currentRow][index] = Color.yellow
                    }
                    
                    else{
                        gridColors[currentRow][index] = Color.gray.opacity(0.5)
                    }
                    
                    
                }
                currentColumn = 0
                currentRow += 1
            }
        }
        
        else{
            resetState()
        }
    }
    
    
    
    
    func resetState() {
        //reset everything
        grid = Array(repeating: Array(repeating: "", count: 5), count: 6)
        gridColors = Array(repeating: Array(repeating: Color.gray.opacity(0.35) , count: 5), count: 6)
        keyboardKeys = ["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]
        currentRow = 0
        currentColumn = 0
        wordToGuess = fiveLetterWords.randomElement()!
    }
    
}

#Preview {
    GameView()
}
