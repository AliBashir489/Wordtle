import SwiftUI

struct ContentView: View {
    @State private var lengthOfWord: Int = 6
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
                    
                    VStack(spacing: 10) {
                        
                        Text("Level")
                            .font(.custom("Futura",size: 30))
                            .shadow(color: .black, radius: 7)
                            .bold()
                            .foregroundColor(.white)
                        
                        
                        Picker("Length of Word:", selection: $lengthOfWord){
                            ForEach(4..<9) { number in
                                Text("\(number)").tag(number)
                                    .font(.custom("Futura", size: 23))
                                    .foregroundColor(.blue)
                                    .bold()
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(width: 55, height:120)
                        .clipped()
                        .background(Color.white.opacity(0.8))
                        .shadow(radius: 30)
                        .cornerRadius(10)
                    }
                    
                    
                    NavigationLink(destination: GameView(lengthOfWord: lengthOfWord)) {
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
