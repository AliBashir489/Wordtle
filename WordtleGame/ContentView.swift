import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
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
                
                VStack(spacing: 40) {
                    Text("Wordtle 🐢")
                        .font(.custom("Futura", size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10, x: 0, y: 5)
                    
                    NavigationLink(destination: GameView()) {
                        Text("Start Game")
                            .font(.custom("Helvetica Neue", size: 20))
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
