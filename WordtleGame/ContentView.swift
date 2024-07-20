import SwiftUI

struct ContentView: View {
    @State private var lengthOfWord: Int = 5
    @State private var numberOfTries: Int = 6
    @State private var timeRemaining: Int = 120
    
    @State private var showingSignUp = false
    @State private var showingScoreboard = false
    @State private var loggedIn: Bool = false
    @State private var emailLoggedIn: String = ""
    
    @AppStorage("winStat") private var storedWinStat: Data?
    
    var winStat: winStatModel {
        get {
            if let data = storedWinStat {
                return try! JSONDecoder().decode(winStatModel.self, from: data)
            } else {
                return winStatModel(winCount: 0, letterCount: [], rowCount: [], completionTime: 0)
            }
        }
        set {
            storedWinStat = try? JSONEncoder().encode(newValue)
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background image
                Image("ocean_cloud")
                    .resizable()
                    .scaledToFill()
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .clipped()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(0.925)
                
                VStack(spacing: 45) {
                    Spacer()
                    Text("Wordtle 🐢")
                        .font(.custom("Futura", size: 50))
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .shadow(color: .black, radius: 10, x: 0, y: 5)
                    
                    HStack(spacing: 10) {
                        Spacer()
                        
                        VStack {
                            Text("Length")
                                .font(.custom("Futura", size: 20))
                                .shadow(color: .black, radius: 7)
                                .bold()
                                .foregroundColor(.white)
                            
                            Picker("Length of Word:", selection: $lengthOfWord) {
                                ForEach(4..<9) { number in
                                    Text("\(number)").tag(number)
                                        .font(.custom("Futura", size: 23))
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 70, height: 120)
                            .clipped()
                            .background(Color.white.opacity(0.8))
                            .shadow(radius: 30)
                            .cornerRadius(10)
                        }
                        .offset(CGSize(width: 5, height: 10))
                        Spacer()
                        
                        VStack {
                            Text("Time")
                                .font(.custom("Futura", size: 20))
                                .shadow(color: .black, radius: 7)
                                .bold()
                                .foregroundColor(.white)
                            
                            Picker("Time:", selection: $timeRemaining) {
                                ForEach([30, 45, 60, 90, 120, 180, 300], id: \.self) { number in
                                    Text("\(number)").tag(number)
                                        .font(.custom("Futura", size: 23))
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 70, height: 120)
                            .clipped()
                            .background(Color.white.opacity(0.8))
                            .shadow(radius: 30)
                            .cornerRadius(10)
                        }
                        .offset(CGSize(width: 6, height: -13))
                        Spacer()
                        
                        VStack {
                            Text("Guesses")
                                .font(.custom("Futura", size: 20))
                                .shadow(color: .black, radius: 7)
                                .bold()
                                .foregroundColor(.white)
                            
                            Picker("Tries:", selection: $numberOfTries) {
                                ForEach(3..<10) { number in
                                    Text("\(number)").tag(number)
                                        .font(.custom("Futura", size: 23))
                                        .foregroundColor(.black)
                                        .bold()
                                }
                            }
                            .pickerStyle(WheelPickerStyle())
                            .frame(width: 70, height: 120)
                            .clipped()
                            .background(Color.white.opacity(0.8))
                            .shadow(radius: 30)
                            .cornerRadius(10)
                        }
                        .offset(CGSize(width: 0, height: 10.0))
                        Spacer()
                    }
                    
                    NavigationLink(destination: GameView(lengthOfWord: lengthOfWord, numberOfTries: numberOfTries, timeRemaining: timeRemaining, winStat: winStat)) {
                        Text("Start Game")
                            .font(.custom("Futura", size: 20))
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 200, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    
                    VStack {
                        NavigationLink(destination: LoginView(loggedIn: $loggedIn, emailLoggedIn: $emailLoggedIn)) {
                            Text("Log In")
                                .font(.custom("Futura", size: 20))
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 135.0, height: 50)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        .offset(CGSize(width: 0, height: -10))
                        
                        Button(action: {
                            showingSignUp.toggle()
                        }) {
                            Text("Sign Up")
                                .font(.custom("Futura", size: 20))
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 135.0, height: 50)
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        .sheet(isPresented: $showingSignUp) {
                            SignUpView()
                        }
                        
                        Text(loggedIn ? "Logged in as: \(emailLoggedIn)" : "Not Signed In")
                            .font(.custom("Futura", size: 15))
                            .bold()
                            .padding()
                            .offset(CGSize(width: 0, height: 50))
                    }
                    .padding()
                    
                    Button(action: {
                        showingScoreboard.toggle()
                    }) {
                        
                        VStack(){
                            HStack{
                                Spacer()
                                Image(systemName: "chevron.up")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 20)
                                    .foregroundColor(.white)
                                
                                Spacer()
                            }
                            Text("Scoreboard")
                                .font(.custom("Futura", size: 20))
                                .fontWeight(.bold)
                                .padding()
                                .frame(width: 200, height: 50)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                                .shadow(radius: 10)
                        }
                        
                    }
                    .padding(.bottom, 40)
                    .sheet(isPresented: $showingScoreboard) {
                        FullScoreboardView()
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
