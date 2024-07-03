
import Foundation
import SwiftUI

struct FullScoreboardView: View {
    @AppStorage("winStat") var storedWinStat: Data?
    
    var winStat: winStats {
        get {
            if let data = storedWinStat {
                return try! JSONDecoder().decode(winStats.self, from: data)
            } else {
                return winStats(winCount: 0, letterCount: 5, rowCount: 5)
            }
        }
        set {
            storedWinStat = try? JSONEncoder().encode(newValue)
        }
    }
    
    var body: some View {
        ZStack{
            VStack(){
                Text("Scoreboard")
                    .font(.custom("Roboto", size: 20))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                ScoreboardView()
                
            }
        }
        
        
    }
}

#Preview {
    FullScoreboardView()
}

struct ScoreboardView: View {
    var body: some View {
        
            VStack() {
                Text("4 Letters")
                    .font(.custom("Roboto", size: 20))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    
                
                HStack{
                    HorizontalBarChart(data: [("1",0),
                                              ("2",3),
                                              ("3",5),
                                              ("4",5),
                                              ("5",5),
                                              ("6",4)])
                    
                }
        }
    }
}

struct HorizontalBarChart: View {
    let data: [(label: String, value: Int)]

    var body: some View {
        ZStack{
            Rectangle()
                .frame(width:
                        300, height: 190, alignment: .center)
                .padding(.top,5)
                .foregroundColor(Color.blue)
                .opacity(0.4)
            VStack(alignment: .leading, spacing: 8) {
                ForEach(data, id: \.label) { item in
                    HStack {
                        Text(item.label)
                            .frame(width: 50, alignment: .trailing)
                            .foregroundColor(.white)
                            .fontWeight(.bold)
                        RoundedRectangle(cornerSize:CGSize.init(width: 15, height: 15))
                            .fill(Color.white)
                            .frame(width: CGFloat(item.value) * 10, height: 20)
                    }
                }.padding(.trailing, 230)
            }
            
        }
    }
}

struct winStats : Codable {
    var winCount: Int
    var letterCount: Int
    var rowCount: Int
}
