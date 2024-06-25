import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack{
                // Background image
                Image("1")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .rotationEffect(.degrees(90))
                    .opacity(0.925)
                
                VStack {
                    Spacer()
                    Text("Wordtle")
                        .padding()
                        .bold()
                        .font(.custom("Courier", size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                        .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
                        .overlay(
                            Rectangle()
                                .stroke(Color.black, lineWidth: 5))
                    
                    
                    Spacer()
                    NavigationLink(destination: GameView()) {
                        Text("Start Game")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                    }
                    
                    Spacer()
                }
                
            }
        }
    }
}

#Preview {
    ContentView()
}
