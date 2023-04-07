//
//  LoginView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/04/07.
//

import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State var currentShowingView: String = "login"
    @AppStorage("uid") var userID: String = ""
    
    @State var email = ""
    @State var password = ""
    
    @State private var defineUserName: Bool = false
    
    var body: some View {
        ZStack{
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack {
                Text(currentShowingView == "login" ? "ログイン" : "会員登録")
                    .font(.largeTitle)
                    .bold()
                
                Spacer()
                
                TextField("メールアドレス", text: $email)
                    .padding()
                
                TextField("パスワード", text: $password)
                    .padding()
                
                Button(action: {
                    withAnimation {
                        if(self.currentShowingView == "login") {
                            self.currentShowingView = "signup"
                        } else {
                            self.currentShowingView = "login"
                        }
                    }
                    
                }, label: {
                    Text("アカウントを持ってい\(currentShowingView == "login" ? "ない" : "る")方はこちら")
                })
                
                
                Spacer()
                
                Button(action: {
                    self.currentShowingView == "login" ? login() : signup()
                }, label: {
                    Text(currentShowingView == "login" ? "ログイン" : "登録")
                        .font(.title)
                        .frame(width: 300, height: 70)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4))
                })
            }
        }
//        .sheet(isPresented: $defineUserName, content: {
//            DefineNameView()
//        })
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                print(error)
                return
            }
            
            if let authResult = authResult {
                print(authResult.user.uid)
                withAnimation {
                    userID = authResult.user.uid
                }
            }
        }
    }
    
    func signup() {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print(error)
                return
            }
            
            if let authResult = authResult {
                print(authResult.user.uid)
                userID = authResult.user.uid
//                defineUserName = true
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
