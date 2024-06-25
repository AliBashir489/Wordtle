

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                Text("WORDTLE")
                    .padding()
                    .bold()
                    .font(.system(size: 50, weight: .heavy, design: .default))
                    .foregroundColor(.blue)
                
                Spacer()
                NavigationLink(destination: GameView()) {
                    Text("Start Game")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                }
                
                Spacer()
            }
            
        }
    }
}

#Preview {
    ContentView()
}
