//
//  ContentView.swift
//  torch
//
//  Created by Ameer Hamza on 20/05/2021.
//

import SwiftUI
import UIKit
import AVFoundation

struct ContentView: View {
    @State private var isFlashOn = false
    
    var body: some View {
        
        VStack{
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    self.toggleFlash(isFlashOn)
                }, label: {
                    ZStack{
                        Capsule()
                            .frame(width: 180, height: 280)
                            .foregroundColor(self.isFlashOn ? Color.red.opacity(0.2) : Color.red.opacity(0.2))
                            .shadow(radius: 25)
                        
                        Image("power")
                            .renderingMode(self.isFlashOn ? .original : .template)
                            .resizable()
                            .frame(width: 160, height: 160)
                            .foregroundColor(self.isFlashOn ? .red : Color.gray)
                            .offset(x: 0, y: self.isFlashOn ? -45 : 45)
                            .padding()
                            .animation(.default)
                            .shadow(color: .black, radius: 5)
                    }.padding()
                })
            }
        }.background(Image("torch2"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


extension ContentView {
    
    // MARK: - Turn on/off flash
    func toggleFlash(_ isOn: Bool) {
        
        let device = AVCaptureDevice.default(for: AVMediaType.video)
        if (device?.hasTorch)! {
            do {
                try device?.lockForConfiguration()
                if (device?.torchMode == AVCaptureDevice.TorchMode.on) {
                    device?.torchMode = AVCaptureDevice.TorchMode.off
                    isFlashOn = false
                    
                } else {
                    do {
                        try device?.setTorchModeOn(level: 1)
                        
                        isFlashOn = true
                        
                    } catch {
                        
                    }
                }
                device?.unlockForConfiguration()
            } catch {
                
            }
        }
        
    }
    
}
