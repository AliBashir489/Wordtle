import SwiftUI

struct EndGamePopup: View {
    var winOrLose: Int
    var wordToGuess: String
    var resetState: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(winOrLose == 1 ? "Congratulations! You've guessed the word: \(wordToGuess)" : "Better luck next time! The word was: \(wordToGuess)")
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
        }
        .padding()
        .background(Color.white)
        .cornerRadius(20)
        .shadow(radius: 10)
        .frame(maxWidth: 300)  // Adjust the width of the popup box
        .padding()
        .background(Color.clear)  // Ensure the background is clear
    }
}

#Preview {
    EndGamePopup(winOrLose: 1, wordToGuess: "APPLE", resetState: {})
}
