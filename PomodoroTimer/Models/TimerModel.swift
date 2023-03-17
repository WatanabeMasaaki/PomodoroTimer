//
//  TimerModel.swift
//  PomodoroTimer
//
//  Created by 渡邉雅晃 on 2023/03/16.
//

import Foundation
import Combine
import AVFoundation
import UIKit

class TimerModel: ObservableObject {
    //count...開始から何秒　timeLimit...全体の時間（秒）
    @Published var count: Int = 0
    @Published var timeLimit: Int = 0
    @Published var remaining: Int = 0
    @Published var timer: AnyCancellable!
    let interval: Double = 1
    
    //実際に画面に映し出す情報
    @Published var cycleStr: String = "1"
    @Published var minStr: String = "00"
    @Published var secStr: String = "00"
    @Published var isFocus: Bool = true
    
    //オーディオ関係
    private let chime = try! AVAudioPlayer(data: NSDataAsset(name: "jihou-sine-3f")!.data)
    
    private func playChime() {
        chime.stop()
        chime.currentTime = 0.0
        chime.play()
    }
    
    private func stopChime() {
        chime.stop()
        chime.currentTime = 0.0
    }
    
    //タイマー関係
    func timerStart(focusTime: Int, restTime: Int, cycles: Int){
        timer = Timer
            .publish(every: interval, on: .main, in: .common)
            .autoconnect()
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { _ in
                self.count += Int(self.interval)
                
                var cycle: Int = self.count / ((focusTime + restTime) * 60) + 1
                self.cycleStr = String(format: "%d", cycle)
                self.isFocus = ((self.count % ((focusTime + restTime) * 60)) < focusTime * 60) ? true : false
                            
                var remainCount = self.isFocus ?
                focusTime * 60  - (self.count % ((focusTime + restTime) * 60)) :
                restTime * 60 - (self.count % ((focusTime + restTime) * 60) - focusTime * 60)
                
                if remainCount == 4 {
                    self.playChime()
                }
                
                var secRemain = remainCount % 60
                var minRemain = remainCount / 60
                
                self.secStr = String(format: (secRemain < 10 ? "0%d" : "%d"), secRemain)
                self.minStr = String(format: (minRemain < 10 ? "0%d" : "%d"), minRemain)
                
                if (self.timeLimit - self.count <= 0){
                    self.isFocus = true
                    self.secStr = "00"
                    self.minStr = "00"
                    self.timer?.cancel()
                }
            })
    }
    
    func start(focusTime: Int, restTime: Int, cycles: Int){
        //countに0を入れて１秒ごとに加算する
        count = 0
        timeLimit = ((focusTime + restTime) * cycles - restTime) * 60
        remaining = timeLimit
        if let _timer = timer {
            _timer.cancel()
        }
        
        timerStart(focusTime: focusTime, restTime: restTime, cycles: cycles)
    }
    
    func resume(focusTime: Int, restTime: Int, cycles: Int) {
        timerStart(focusTime: focusTime, restTime: restTime, cycles: cycles)
    }
    
    func stop(){
        timer?.cancel()
        timer = nil
        self.stopChime()
    }
    
    
}
