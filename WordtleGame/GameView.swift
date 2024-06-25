import SwiftUI

struct GameView: View {
    // Defines the grid for the letters it is 6 rows and 5 columns
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
    
    
    // Tracks the current row and column
    @State private var currentRow = 0
    @State private var currentColumn = 0
    
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
                    .textCase(/*@START_MENU_TOKEN@*/.uppercase/*@END_MENU_TOKEN@*/)
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
                                            .background(Color.gray.opacity(0.35))
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
                    ForEach(["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"], id: \.self) { row in
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
    
    private func handleKeyPress(key: String) {
        if currentRow < 6 && currentColumn < 5 {
            grid[currentRow][currentColumn] = key
            currentColumn += 1
            
            // Move to next row if the current row is filled
            if currentColumn == 5 {
                currentColumn = 0
                currentRow += 1
            }
        }
    }
}

#Preview {
    GameView()
}
