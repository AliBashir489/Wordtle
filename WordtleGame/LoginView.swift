import SwiftUI
import Firebase


struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showErrorAlert: Bool = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var loggedIn: Bool  // Binding to update loggedIn state
    @Binding var emailLoggedIn: String  // Binding to update emailLoggedIn state
    
    var body: some View {
        ZStack {
            // Background image
            Image("4")
                .resizable()
                .scaledToFill()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .alignmentGuide(.leading) { _ in 0 }
                .edgesIgnoringSafeArea(.all)
                .opacity(0.925)
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Welcome Back")
                    .font(.custom("Futura", size: 30))
                    .fontWeight(.heavy)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.blue)
                            .shadow(radius: 5)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.blue)
                    )
                
                HStack {
                    Image(systemName: "envelope")
                        .foregroundColor(.gray)
                    
                    TextField("Email", text: $email)
                        .font(.custom("Futura", size: 15))
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                    
                    if email.count != 0 {
                        Image(systemName: email.isValidEmail() ? "checkmark" : "xmark")
                            .frame(width: 30)
                            .foregroundColor(email.isValidEmail() ? .green : .red)
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    
                    SecureField("Password", text: $password)
                        .font(.custom("Futura", size: 15))
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .foregroundColor(.black)
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("Cancel")
                            .font(.custom("Futura", size: 13))
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 150, height: 50)
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    
                    Button(action: {
                        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                            if let error = error {
                                print(error)
                                email = ""
                                password = ""
                                showErrorAlert.toggle()
                            } else if let authResult = authResult {
                                // Authentication successful
                                print("\(authResult.user.uid)")
                                loggedIn = true  // Update loggedIn state
                                emailLoggedIn = email  // Update emailLoggedIn state
                                presentationMode.wrappedValue.dismiss()  // Dismiss LoginView
                            }
                        }
                    }) {
                        Text("Log In")
                            .font(.custom("Futura", size: 13))
                            .fontWeight(.bold)
                            .padding()
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                    }
                    .alert(isPresented: $showErrorAlert) {
                        Alert(title: Text("Incorrect Email or Password. Please Try Again."))
                    }
                    .padding(.top)
                    .offset(CGSize(width: 0, height: -7))
                }
                
                Spacer()
            }
            .padding()
            .cornerRadius(10)
            .padding()
        }
    }
}




#Preview {
    LoginView(loggedIn: .constant(false), emailLoggedIn: .constant(""))
}
