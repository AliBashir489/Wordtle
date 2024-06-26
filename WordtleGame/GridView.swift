import SwiftUI

struct GridView: View {
    @Binding var grid: [[String]]
    @Binding var gridColors: [[Color]]
    
    var body: some View {
        VStack(spacing: 15) {
            ForEach(0..<6, id: \.self) { row in
                HStack(spacing: 10) {
                    ForEach(0..<5, id: \.self) { column in
                        Text(grid[row][column])
                            .frame(width: 45, height: 45)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.black, lineWidth: 3)
                                    .background(gridColors[row][column])
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
    GridView(grid: .constant(Array(repeating: Array(repeating: "", count: 5), count: 6)), gridColors: .constant(Array(repeating: Array(repeating: Color.gray, count: 5), count: 6)))
}
