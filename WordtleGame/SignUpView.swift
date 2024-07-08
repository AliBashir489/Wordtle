import SwiftUI
import Firebase

struct SignUpView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var rePassword: String = ""
    @Environment(\.presentationMode) var presentationMode
    @State private var showErrorAlert: Bool = false
    @State private var showPassNotMatchAlert: Bool = false

    
    var body: some View {
        ZStack {
            Image("4")
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .clipped()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.925)
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Sign Up")
                    .font(.custom("Futura", size: 30))
                    .frame(width: 150, height: 50)
                    .fontWeight(.heavy)
                    .foregroundColor(.blue)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
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
                    
                    if password.count != 0 {
                        Image(systemName: password.isValidPass() ? "checkmark" : "xmark")
                            .frame(width: 30)
                            .foregroundColor(password.isValidPass() ? .green : .red)
                    }
                }
                .padding(10)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(radius: 5)
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                    
                    SecureField("Re-type Password", text: $rePassword)
                        .font(.custom("Futura", size: 15))
                        .padding(10)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    
                    if rePassword.count != 0 {
                        Image(systemName: rePassword == password ? "checkmark" : "xmark")
                            .frame(width: 30)
                            .foregroundColor(rePassword == password ? .green : .red)
                    }
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
                        if password != rePassword{
                            showErrorAlert.toggle()
                            password = ""
                            rePassword = ""
                            return
                        }
                        
                        if email == "" || password == "" || rePassword == "" {
                            showErrorAlert.toggle()
                            return
                        }
                        
                        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                            
                            if let error = error {
                                print(error)
                                showErrorAlert.toggle()
                                email = ""
                                password = ""
                                rePassword = ""
                                return
                            }
                            
                         
                            
                            if let authResult = authResult {
                                print("\(authResult.user.uid)")
                                
                                presentationMode.wrappedValue.dismiss()

                            }
                        }

                        
                        
                    }) {
                        Text("Create Account")
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
                        Alert(title: Text("Missing/Invalid Email or Password, Passwords Do Not Match, or Email is Currently in Use. Password Must be 6 Characters Long or More. Please Follow All Conditions To Create an Account"))
                            
                    }
                    
                }
                
                Spacer()
            }
            .padding()
            .cornerRadius(10)
            .padding()
            .navigationTitle("Sign Up")
        }
    }
}


#Preview {
    SignUpView()
}
