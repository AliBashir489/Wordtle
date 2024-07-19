import SwiftUI

struct EndGamePopup: View {
    var winOrLose: Int
    var wordToGuess: String
    var resetState: () -> Void
    var lengthOfWord: Int
    @State var nPlays: Int
    @State var nWins: Int
    @State var isAnimating: Bool = false
    
    var body: some View {
        VStack() {
            Image(systemName: winOrLose == 1 ? "medal" :"laser.burst")
                .font(.system(size: 100))
                .foregroundColor(isAnimating ? .yellow : .gray)
                .scaleEffect(isAnimating ? 1.2 : 0.3)
                .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                .onAppear {
                    withAnimation(.easeInOut(duration: 1.0).repeatForever(autoreverses: true)) {
                        isAnimating = true
                    }
                }
            
            Text(winOrLose == 1 ? "Congratulations! You saved the world!\nThe correct word was:\n \(wordToGuess)" : "Oh No!\nThe world was destroyed!\nThe correct word was: \(wordToGuess)")
                .font(.custom("Helvetica Neue", size: 20))
                .fontWeight(.bold)
                .foregroundColor(.black)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: resetState) {
                Text("Restart Game")
                    .font(.title2)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(20)
            }
            Text("Word Length: \(lengthOfWord)")
            Text("Plays: \(nPlays)")
            Text("Wins: \(nWins)")
            //stats could go here
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: 300)  // Adjust the width of the popup box
        .padding()
        .background(Color.clear)  // Ensure the background is clear
        .offset(x: 0, y: -100)
        
    }
}

#Preview {
    EndGamePopup(winOrLose: 2, wordToGuess: "APPLE", resetState: {}
                 ,lengthOfWord: 5, nPlays:3, nWins:2)
}
