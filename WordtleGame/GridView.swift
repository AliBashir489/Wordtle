import SwiftUI

struct GridView: View {
    @Binding var grid: [[String]]
    @Binding var gridColors: [[Color]]
    @Binding var numCols: Int
    @Binding var numRows: Int
    
    var body: some View {
        VStack(spacing: CGFloat(15 - numCols)) {
            ForEach(0..<numRows, id: \.self) { row in
                HStack(spacing: CGFloat(15 - numCols) ) {
                    ForEach(0..<numCols, id: \.self) { column in
                        Text(grid[row][column])
                            .frame(width: CGFloat(45 - numCols), height: CGFloat(45 - numRows))
                            .background(gridColors[row][column])
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.blue, lineWidth: 1.5)
                            )
                            .font(.title)
                            .bold()
                            .multilineTextAlignment(.center)
                        
                    }
                }
            }
        }
    }
}

#Preview {
    GridView( grid: .constant(Array(repeating: Array(repeating: "", count: 8), count: 9))
              ,gridColors: .constant(Array(repeating: Array(repeating: Color.white, count: 8), count: 9))
              ,numCols: .constant(8)
              ,numRows: .constant(9)
    )
}
