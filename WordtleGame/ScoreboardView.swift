

import Foundation
import SwiftUI

struct FullScoreboardView: View {
    
    
    var body: some View {
        ZStack{
            Image("underwater")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.925)
            
            VStack(){
                Text("Scoreboard")
                    .font(.custom("Futura", size: 35))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color.white, radius: 10)
                    .padding(.bottom, 100)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ScoreboardView(4)
                        ScoreboardView(5)
                        ScoreboardView(6)
                        ScoreboardView(7)
                        ScoreboardView(8)
                    }
                }
                .frame(height: 100)
                .transition(.move(edge: .bottom))
            }
        }
        
    }
}

#Preview {
    FullScoreboardView()
}

struct ScoreboardView: View {
    private var numLetters: Int
    
    init(_ numLetters: Int) {
        self.numLetters = numLetters
    }

    var body: some View {
        
            VStack() {
                Text("\(numLetters) Letters")
                    .font(.custom("Futura", size: 20))
                    .fontWeight(.light)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .shadow(color: Color.white, radius: 10)
                
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
                            .font(.custom("Futura", size: 15))
                        RoundedRectangle(cornerSize:CGSize.init(width: 15, height: 15))
                            .fill(Color.white)
                            .frame(width: CGFloat(item.value) * 10, height: 20)
                    }
                }.padding(.trailing, 230)
            }
            
        }
    }
}



