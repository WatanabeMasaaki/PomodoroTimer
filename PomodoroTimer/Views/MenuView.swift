//
//  MenuView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack {
                    HStack {
                        Spacer()
                        Text("3月21日")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .foregroundColor(.black)
                        Text("19:00")
                            .font(.system(size: 25, weight: .semibold, design: .rounded))
                            .padding(.trailing, 25)
                            .foregroundColor(.black)
                    }
                    
                    Spacer()
                    
                    Text("総集中時間")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                    Text("100")
                        .font(.system(size: 70, weight: .semibold, design: .rounded))
                        .foregroundColor(.blue)
                    Text("min")
                        .font(.system(size: 40, weight: .semibold, design: .rounded))
                        .foregroundColor(.black)
                    
                    Spacer()
                    
                    NavigationLink {
                        SettingView()
                    } label: {
                        Label("勉強を始める！", systemImage: "figure.walk")
                            .font(.title)
                            .frame(width: 300, height: 70)
                            .overlay(RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.blue, lineWidth: 4))
                    }
                    
                }
            }
        }
        
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
