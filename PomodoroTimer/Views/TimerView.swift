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
            
            VStack {
                Text("\(timerController.cycleStr)サイクル目")
                    .font(.title)
                Text(timerController.isFocus ? "勉強時間" : "休憩")
                    .font(.title)
                
                Text("\(timerController.minStr):\(timerController.secStr)")
                    .font(.largeTitle)
                    .padding()
                
                Button(action: {
                    if(timerController.timer == nil){
                        timerController.start(focusTime: focusTime, restTime: restTime, cycles: cycles)
                        isTimerStop == false
                    } else {
                        if isTimerStop {
                            timerController.stop()
                            isTimerStop == true
                        } else {
                            timerController.resume(focusTime: focusTime, restTime: restTime, cycles: cycles)
                            isTimerStop == false
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
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(focusTime: 25, restTime: 5, cycles: 4)
    }
}
