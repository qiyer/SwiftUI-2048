//
//  GameView.swift
//  SwiftUI2048
//
//  Created by Hongyu on 6/5/19.
//  Copyright © 2019 Cyandev. All rights reserved.
//

import SwiftUI

struct GameView : View {
    
    @State var gestureStartLocation: CGPoint = .zero
    @EnvironmentObject var gameLogic: GameLogic
    
    var gesture: some Gesture {
        let threshold: CGFloat = 44
        let drag = DragGesture()
            .onChanged { v in
                guard self.gestureStartLocation != v.startLocation else { return }
                
                self.gestureStartLocation = v.startLocation
                
                if v.translation.width > threshold {
                    // Move right
                    self.gameLogic.move(.right)
                } else if v.translation.width < -threshold {
                    // Move left
                    self.gameLogic.move(.left)
                } else if v.translation.height > threshold {
                    // Move down
                    self.gameLogic.move(.down)
                } else if v.translation.height < -threshold {
                    // Move up
                    self.gameLogic.move(.up)
                } else {
                    // Direction cannot be deduced, reset gesture state.
                    self.gestureStartLocation = .zero
                }
            }
        return drag
    }
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .top) {
                Text("2048")
                    .font(Font.system(size: 48).weight(.black))
                    .color(Color(red:0.47, green:0.43, blue:0.40, opacity:1.00))
                    .offset(x: 0, y: proxy.safeAreaInsets.top + 32)
                
                ZStack(alignment: .center) {
                    BlockGridView(matrix: self.gameLogic.blockMatrix)
                        .gesture(self.gesture)
                }
                .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            }
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .center)
            .background(
                Rectangle().fill(Color(red:0.96, green:0.94, blue:0.90, opacity:1.00))
            )
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

#if DEBUG
struct GameView_Previews : PreviewProvider {
    
    static var previews: some View {
        GameView()
            .environmentObject(GameLogic())
    }
    
}
#endif
