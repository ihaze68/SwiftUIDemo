//
//  DemoView.swift
//  SwiftUIDemo
//
//  Created by HaZe on 16/10/2022.
//

import SwiftUI
import Splash
import WebKit

/// Modifiers
/// -------------------------------------------------

struct CarouselItem: ViewModifier {
    @Binding var isSelected: Bool
    
    func body(content: Content) -> some View {
        content
            .padding(9)
            .background(isSelected ? .ultraThickMaterial : .thinMaterial, in: RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: isSelected ? 3 : 0)
                    .foregroundColor(isSelected ? .accentColor : .clear)
                    .shimmering(active: isSelected, duration: 2, bounce: false)
                
            )
            .padding(1)
            .padding(.trailing,3)
    }
}

/// Helpers
/// -------------------------------------------------

struct HSizer: View {
    var body: some View {
        HStack {
            Spacer()
        }
        .frame(height:1)
    }
}

/// Presenter
/// -------------------------------------------------

// we can use UIKit things
struct TextView: UIViewRepresentable {
    @Binding var attributedText: NSMutableAttributedString
    @State var allowsEditingTextAttributes: Bool = false
    @State var font: UIFont?

    func makeUIView(context: Context) -> UITextView {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.sizeToFit()
        view.isScrollEnabled = false
        view.isEditable = false

        return view
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.attributedText = attributedText
        uiView.allowsEditingTextAttributes = allowsEditingTextAttributes
        uiView.font = font
    }
}

/// Simple way to use WKWebView
/*
struct WebView: UIViewRepresentable {
    var url: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
*/

/// Modifier example
struct SwithcCodes: View {
    @Binding var selectedDemo: Demo?
    @Binding var switchCode: Bool
    var body: some View {
        if !(selectedDemo?.codeFull.isEmpty ?? false) {
            Button {
                switchCode.toggle()
            }
        label: {
            Text(switchCode ? "Full":"Pure")
            Image(systemName: "arrow.triangle.2.circlepath.circle.fill")
            }
        .padding(4)
        .background(Material.bar)
        .cornerRadius(6)
        .padding(4)
        }
    }
}

struct DemoPresentationView: View {
    @Binding var selectedDemo: Demo?
    @Environment(\.colorScheme) var colorScheme

    // save states of open/close of DisclosureGroups
    @State var isHeaderOpen = true
    @State var isExampleOpen = false
    @State var isCodeOpen = false
    
    // set show/hide those sections depends on the content
    @State var hasCode = true
    @State var hasExample = true
    
    // controll URL links
    @Environment(\.openURL) var openURL
    @State var showBrowser = false
    @State var link: URL?
    
    // controll full or short code
    @State var switchCode = false
    @State var code: String = ""
    
    var body: some View {
        ScrollView(.vertical) {
            // title
            DisclosureGroup(isExpanded: $isHeaderOpen) {
                VStack(alignment: .leading) {
                    // Native support for markdown
                    let markdownText = LocalizedStringKey( selectedDemo?.description ?? "No description" )
                    Text( markdownText )
                        .padding()
                        .environment(\.openURL, OpenURLAction { url in
                            // ... set state that will cause your web view to be loaded...
                            link = url
                            showBrowser.toggle()
                            return .handled
                        })
                    HSizer()
                }
                .background(Color(uiColor: UIColor.systemBackground), in: RoundedRectangle(cornerRadius: 12))
                .bold(false)
                .padding(.top)
            } label: {
                Label( selectedDemo?.subTitle ?? "N/A", systemImage: selectedDemo?.icon ?? "")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle( .red, .green, .yellow )
                    .bold()
            }
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
            .sheet(isPresented: $showBrowser) {
                if let link {
                    WebViewWithProgressBar(url: link)
                        .presentationDetents([.large, .medium])
                }
            }
            
            // demo view
            if hasExample {
                DisclosureGroup("Example", isExpanded: $isExampleOpen) {
                    VStack {
                        VStack {
                            if let demoView = selectedDemo?.demoView {
                                AnyView( demoView )
                                    .padding()
                                    .animation(.default, value: selectedDemo)
                                HSizer()
                            } else {
                                Text("No example here")
                                    .padding()
                            }
                        }
                        .background(Color(uiColor: UIColor.systemBackground), in: RoundedRectangle(cornerRadius: 12))
                        .padding(.top)
                    }
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
            
            // code
            if hasCode {
                DisclosureGroup("Code", isExpanded: $isCodeOpen) {
                    VStack(alignment: .leading) {
                        
                        // if we want to show it as a Text
                        // attText = AttributedString(highlighter.highlight(code))
                        // Text( attText )
                        
                        VStack {
                            if !code.isEmpty {
                                //if let code = selectedDemo?.code,
                                //   !code.isEmpty {
                                // Splash code highlighter
                                let highlighter = SyntaxHighlighter(format: AttributedStringOutputFormat(theme: colorScheme == .light ? .presentation(withFont: Font(size: 14)) : .midnight(withFont: Font(size: 14))))
                                let attText = NSMutableAttributedString(attributedString: highlighter.highlight(code))
                                
                                ScrollView(.horizontal) {
                                    TextView(attributedText: .constant(attText),
                                             font: .systemFont(ofSize: 14))
                                }
                                .padding([.leading,.trailing])
                            } else {
                                Text("No demo code presented")
                                    .padding()
                            }
                        }
                        .background(Color(uiColor: UIColor.systemBackground), in: RoundedRectangle(cornerRadius: 12))
                        .overlay(SwithcCodes(selectedDemo: $selectedDemo,
                                             switchCode: $switchCode), alignment: .topTrailing)
                        .padding(.top)
                    }
                }
                .padding()
                .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 12))
            }
        }
        .onChange(of: switchCode) {value in
            code = value ? (selectedDemo?.codeFull ?? "") : (selectedDemo?.code ?? "")
            
        }
        .onChange(of: selectedDemo) { value in
            hasCode = !(selectedDemo?.code.isEmpty ?? false)
            hasExample = selectedDemo?.demoView != nil
            switchCode = false
            code = switchCode ? (selectedDemo?.codeFull ?? "") : (selectedDemo?.code ?? "")
        }
    }
}

/// Main view
/// -------------------------------------------------

struct DemoView: View {
    @StateObject var demoClass = DemoClass.shared
    @State var selectedDemo: Demo?

    var body: some View {
        VStack {
            // Carousel
            ScrollView(.horizontal) {
                ScrollViewReader { value in
                    HStack {
                        ForEach( demoClass.demos, id:\.id) { demo in
                            Button {
                                withAnimation(.easeIn(duration: 0.5)) {
                                    selectedDemo = demo
                                    value.scrollTo(demo.id, anchor: .center)
                                }
                                
                            } label: {
                                Label(demo.title, systemImage: demo.icon)
                                    .labelStyle(ButtonTopIconStyle())
                            }
                            .id(demo.id)
                            .modifier(CarouselItem(isSelected: .constant(demo == selectedDemo)))
                            
                        }
                    }
                    .padding([.leading,.trailing,.top])
                }
            }

            DemoPresentationView(selectedDemo: $selectedDemo)
                .padding([.leading,.trailing])
                .padding(.top,5)
            
            /*
            switch selectedDemo?.kind {
            case .viewDemo:
                DemoPresentationView(selectedDemo: $selectedDemo)
                    .transition(.slide)
                    .padding([.leading,.trailing])
                    .padding(.top,5)
            case .none:
                Text("No selection")
            }
            */
            
            Spacer()
        }
        .onAppear() {
            initFirstStage()
        }
    }
    
    private func initFirstStage() {
        selectedDemo = demoClass.demos.first
    }
}

struct DemoView_Previews: PreviewProvider {
    static var previews: some View {
        DemoView()
            .preferredColorScheme(.light)
            .previewDisplayName("Demo Prezenter Light")
        
        DemoView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Demo Prezenter Dark")
    }
}
