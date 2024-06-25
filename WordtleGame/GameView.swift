import SwiftUI

struct GameView: View {
    // Defines the grid for the letters it is 6 rows and 5 columns
    @State private var grid: [[String]] = Array(repeating: Array(repeating: "", count: 5), count: 6)
   
    
    // Tracks the current row and column
    @State private var currentRow = 0
    @State private var currentColumn = 0
    
    var body: some View {
        VStack {
            Spacer()
            // Display the grid of letter boxes
            VStack(spacing: 10) {
                ForEach(0..<6, id: \.self) { row in
                    HStack(spacing: 10) {
                        ForEach(0..<5, id: \.self) { column in
                            Text(grid[row][column])
                                .frame(width: 40, height: 40)
                                .background(Color.gray.opacity(0.2))
                                .border(Color.black, width: 2)
                                .font(.title)
                                .multilineTextAlignment(.center)
                        }
                    }
                }
            }
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
                                    .frame(width: 30, height: 40)
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(5)
                            }
                        }
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Wordtle")
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
