import SwiftUI

struct GameView: View {
    @State private var lengthOfWord: Int
    @State private var numCols = 0
    @State private var numRows = 0
    @State private var emailLoggedIn: String
    @State private var nWins: Int = 0
    @State private var nPlays: Int = 0
    
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
    
    
    
    
    init(lengthOfWord: Int, numberOfTries: Int, timeRemaining: Int, emailLoggedIn: String) {
        self.lengthOfWord = lengthOfWord
        self.numberOfTries = numberOfTries
        self.emailLoggedIn = emailLoggedIn
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
                //Spacer()
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
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                    .font(.headline)
                    //.padding()
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
                wordToGuess = getRandomWord(lengthOfWord: lengthOfWord) //(words[lengthOfWord - 4].randomElement()!).uppercased()
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
            
            
            
            
            if winOrLose != 0 {
                // adding "1" here because resetstate hasn't been called yet
                EndGamePopup(winOrLose: winOrLose, wordToGuess: wordToGuess, resetState: resetState, lengthOfWord: lengthOfWord, nPlays: nPlays+1, nWins: (nWins + (winOrLose == 1 ? 1 : 0) ) )
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
        // This is now handled by the TIMER event
            //if currentRow >= numRows {
            //    resetState()
            //}
    }
    
    
    private func getOnlineRandomWord(lengthOfWord:Int)->String {
        let wordsURL = "https://ocelot.aul.fiu.edu/~dmath031/words\(lengthOfWord).txt"
        
        guard let url = URL( string: wordsURL)
        else {
            fatalError("Error with url")
        }
        var myword = "-"
        // by default, sess is stopped, must resume
        let sess : Void = URLSession.shared.dataTask(with: url) {
            (sessData, sessResponse, sessError) in
            
            if let error = sessError {
                print(" \(error.localizedDescription) ")
            } else { // get the response content
                if let words = String(data: sessData!, encoding: .utf8) {
                    let arrWords = words.split(separator: "\n")
                    if !arrWords.isEmpty {
                        myword = String(arrWords.randomElement()!)
                        print("\(myword)")
                    }
                } //if
            } //else error
        }.resume() // sess, run it!

        var retries=5
        // let the task run several times until it gets somthing
        while (myword.count < 4) && (retries > 0) {
                sleep(1)
                retries -= 1
        }
        return myword
        } //getOnlineRandomWord
        
    private func getRandomWord(lengthOfWord:Int) -> String {
        var theWord = "-"
        if emailLoggedIn.count>5 {
            theWord = getOnlineRandomWord(lengthOfWord: lengthOfWord)
        }
        if theWord.count < 4 {
            // failsafe: if internet down or not loggedin, get word from arrays, as before
            theWord = (words[lengthOfWord - 4].randomElement()!)
        }
        return theWord.uppercased()
    }
    
    
    
    private func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if winOrLose == 0 {
                if timeRemaining > 0 {
                    timeRemaining -= 1
                    // changed the white out to the last 20 seconds for better exploding effect
                    let whiteoutStartsAt = 20.0 //seconds
                    if timeRemaining < Int(whiteoutStartsAt) {
                        imageOpac = Double(timeRemaining) * 1.0/whiteoutStartsAt
                    }
                    //imageOpac = imageOpac - (1.00/Double(timeOption))
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
        nPlays += 1
        if winOrLose == 1 {
            nWins += 1
        }
        wordToGuess = getRandomWord(lengthOfWord:lengthOfWord) //(words[lengthOfWord - 4].randomElement()!).uppercased()
        numRows = numberOfTries
        winOrLose = 0
        timeRemaining = self.timeOption
        imageOpac = 1
        startTimer()
    }
}

#Preview {
    GameView(lengthOfWord: 7, numberOfTries: 9, timeRemaining: 45, emailLoggedIn: "")
}
