//
//  ContentView.swift
//  SwiftUIDemo
//
//  Created by HaZe on 09/10/2022.
//

import SwiftUI

///Data layer
/// -------------------------------------------------

enum ContentState {
    case Welcome
    case Demo
}

/// Modifiers
/// -------------------------------------------------

/// View modification
/// purpose: general use
struct TitleHighlight: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.white)
            .padding(3)
            .padding([.leading,.trailing], 4)
            .background(.teal, in: RoundedRectangle(cornerRadius: 12))
    }
}

/// Label style
/// purpose: general use
struct ButtonRightIconStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}

/// Label style
/// purpose: general use
struct ButtonTopIconStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {
            configuration.icon
                .padding(.bottom,2)
                .symbolRenderingMode(.palette)
                .foregroundStyle( .red, .green, .yellow )

            configuration.title
                .font(.subheadline)
        }
    }
}

/// Main view
/// -------------------------------------------------

struct ContentView: View {
    
    @State var state: ContentState = .Welcome
    @State var selectedDemo: Demo?
    
    var body: some View {
        ZStack {
            BackgroundView()

            VStack {
                switch state {
                case .Welcome:
                    WelcomeView(state: $state)
                        .transition(.opacity)
                case .Demo:
                    DemoView()
                        .transition(.slide)
                }
            }
            .padding()
        }
        .ignoresSafeArea(.container, edges: [.bottom])
    }
}

/// There are many ways to refine our previews:
/// - .preferredColorScheme(.light)
/// - .previewDisplayName("Title")
/// - .previewLayout(PreviewLayout.sizeThatFits)
/// - .background(Color(.systemBackground))
/// - .environment(\.colorScheme, .dark)
/// - ....
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.light)
            .previewDisplayName("NN4M SwitUI Demo Light")

        ContentView()
            .preferredColorScheme(.dark)
            .previewDisplayName("NN4M SwitUI Demo Dark")

        ContentView()
            .preferredColorScheme(.light)
            .previewInterfaceOrientation(.landscapeRight)
            .previewDisplayName("NN4M SwitUI Demo Light-Landscape")
    }
}


