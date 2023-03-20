//
//  TimerView.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/15.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerController = TimerModel()
    var focusTime : Int
    var restTime : Int
    var cycles : Int
    @State var isTimerStop = true
    //このisTimerStartedは初めてスタートボタンが押されて以降trueになる
    @State var isTimerStarted = false
    @State var count: Int
    
    
    
    init(focusTime: Int, restTime: Int, cycles: Int) {
        self.focusTime = focusTime
        self.restTime = restTime
        self.cycles = cycles
        count = ((self.focusTime + self.restTime) * self.cycles - self.restTime) * 60
    }
    
    var body: some View {
        ZStack {
            Color("BackgroundColor")
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                
                Spacer()
                
                Text("\(timerController.cycleStr)サイクル目")
                    .font(.system(size: 40, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.black)
                    .padding(.bottom, -5)
                Text(timerController.isFocus ? "勉強" : "休憩")
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.black)
                
                Text(isTimerStarted ?
                     "\(timerController.minStr):\(timerController.secStr)" :
                        "\(String(format: focusTime < 10 ? "0%d" : "%d", focusTime)):00")
                .font(.system(size: 100, weight: .semibold, design: .rounded))
                    .foregroundColor(Color.black)
                    .padding()
                
                Spacer()
                
                Button(action: {
                    if(timerController.timer == nil){
                        timerController.start(focusTime: focusTime, restTime: restTime, cycles: cycles)
                        isTimerStop = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            isTimerStarted = true
                        }
                    } else {
                        if isTimerStop {
                            timerController.resume(focusTime: focusTime, restTime: restTime, cycles: cycles)
                            isTimerStop = false
                        } else {
                            timerController.stop()
                            isTimerStop = true
                        }
                    }
                }, label: {
                    Label(isTimerStop ? "START" : "STOP",systemImage: isTimerStop ? "play.fill" : "pause.fill")
                        .font(.title)
                        .frame(width: 300, height: 70)
                        .overlay(RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.blue, lineWidth: 4))
                })
                .padding()
            }
        }
        .alert("よくがんばりました！！", isPresented: $timerController.showAlert, actions: {
            Button("OK", role: .cancel) {
                timerController.stopSuccess()
                
            }
        })
        
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(focusTime: 1, restTime: 1, cycles: 2)
    }
}
