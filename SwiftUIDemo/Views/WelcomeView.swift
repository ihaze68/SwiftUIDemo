//
//  WelcomeView.swift
//  SwiftUIDemo
//
//  Created by HaZe on 16/10/2022.
//

import SwiftUI

/// Main view
/// -------------------------------------------------

/// Show Welcome screen
/// as modified state by Start button the main distributor
/// can show the next screen to presentate
/// SwiftUI solutions for daily problems to presetn how easy to use it
/// - Parameters:
///     - state: main screen state
struct WelcomeView: View {
    @Binding var state: ContentState
    @State var degree = Angle(degrees: 0)
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: 30) {
                
                ZStack {
                    Image(systemName: "swift")
                        .font(.system(size: 72))
                        .bold()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(.black.gradient)
                        .offset(x:-2,y:2)
                        .rotationEffect(degree)
                        .animation(.easeInOut(duration: 1).repeatForever(), value: degree)
                        .onAppear() {
                            withAnimation() {
                                degree = Angle(degrees: 5)
                            }
                        }
                    
                    Image(systemName: "swift")
                        .font(.system(size: 72))
                        .bold()
                        .symbolRenderingMode(.palette)
                        .foregroundStyle(
                            .linearGradient(colors: [.red, .yellow], startPoint: .top, endPoint: .bottomTrailing),
                            .linearGradient(colors: [.green, .mint, .black], startPoint: .top, endPoint: .bottomTrailing),
                            .linearGradient(colors: [.purple, .cyan, .black], startPoint: .top, endPoint: .bottomTrailing)
                        )
                }
                
                Text("SwiftUI")
                    .bold()
                    .modifier(TitleHighlight())
                
                Text("Welcome")
                    .font(.largeTitle)
                    .shimmering(active: true, duration: 2, bounce: false)
                
                Text("This is a short presentation about SwiftUI with some examples how we can do things")
                    .foregroundColor(.secondary)
                
                Button {
                    withAnimation {
                        state = .Demo
                    }
                } label: {
                    Label("Start", systemImage: "arrow.forward.circle.fill")
                        .labelStyle(ButtonRightIconStyle())
                }
            }
            .padding()
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 26))
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(state: .constant(.Welcome))
            .padding()
    }
}
