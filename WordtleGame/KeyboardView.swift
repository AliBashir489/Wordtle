import SwiftUI

struct KeyboardView: View {
    @Binding var keyboardKeys: [String]
    @Binding var keyColors: [Character: Color]
    var handleKeyPress: (String) -> Void
    
    var body: some View {
        VStack(spacing: 10) {
            ForEach(keyboardKeys, id: \.self) { row in
                HStack(spacing: 5) {
                    ForEach(row.map { String($0) }, id: \.self) { key in
                        Button(action: {
                            handleKeyPress(key)
                        }) {
                            Text(key)
                                .frame(width: 32, height: 44)
                                .background(keyColors[Character(key)] ?? Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(5)
                        }
                    }
                }
            }
            HStack(spacing: 5) {
                Button(action: {
                    handleKeyPress("Enter")
                }) {
                    Text("Enter")
                        .frame(width: 64, height: 44)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
                Button(action: {
                    handleKeyPress("Backspace")
                }) {
                    Image(systemName: "delete.left")
                        .frame(width: 44, height: 44)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(5)
                }
            }
        }
    }
}

#Preview {
    KeyboardView(keyboardKeys: .constant(["QWERTYUIOP", "ASDFGHJKL", "ZXCVBNM"]), keyColors: .constant([:]), handleKeyPress: { _ in })
}
