//
//  DemoClass.swift
//  SwiftUIDemo
//
//  Created by HaZe on 20/10/2022.
//

import Foundation
import SwiftUI

/// Data layer
/// -------------------------------------------------

enum DemoType {
    case viewDemo
}

struct Demo: Equatable {
    let id = UUID()
    
    let title: String
    let subTitle: String
    let icon: String
    let description: String
    let kind: DemoType
    let code: String
    let codeFull: String
    let demoView: AnyView?
    
    static func == (lhs: Demo, rhs: Demo) -> Bool {
        lhs.id == rhs.id
    }
}

/*
 create a view
 define a body
 show text
 add buttons
 add list
 use data ource
 add parameters
 */

class DemoClass : ObservableObject {
    
    static let shared = DemoClass()
    
    @Published var demos: [Demo] = []
    
    private let demoData: [Demo] = [
        Demo(title: "Definition",
             subTitle: "What is SwiftUI",
             icon: "swift",
             description:
"""
**SwiftUI** is a new way to build user interfaces for apps on Apple platforms. It allows developers to define the UI using Swift code.
             
**Difference between Sift and SwiftUI**
Swift is an imperative programming language. SwiftUI, however, is proudly claimed as a declarative UI framework that lets developers create UI in a declarative way.

[⌘ Apple documentation](https://developer.apple.com/xcode/swiftui/)
[⌘ SwiftUI or UIKit?](https://bignerdranch.com/blog/learning-apples-swiftui-or-uikit-which-one-is-right-for-you-right-now/)
[⌘ How to use UIKit in SwiftUI](https://sarunw.com/posts/uikit-in-swiftui/)
""",
             kind: .viewDemo,
             code: "",
             codeFull: "",
             demoView: nil
            ),
        
        Demo(title: "View",
             subTitle: "Create a view",
             icon: "rectangle",
             description:
"""
A **View** is the fundamental building block of your application's user interface. You already know that a view is a type that conforms to the *View protocol*.

[⌘ Apple documentation](https://developer.apple.com/tutorials/swiftui/creating-and-combining-views)
[⌘ What Is a View](https://cocoacasts.com/swiftui-fundamentals-what-is-a-view)
[⌘ Explaning 'some view'](https://www.hackingwithswift.com/books/ios-swiftui/why-does-swiftui-use-some-view-for-its-view-type)
""",
             kind: .viewDemo,
             code:
"""
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
    }
}
""",
             codeFull:
"""
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()
        .background( .thinMaterial,
            in: RoundedRectangle(cornerRadius: 14))
        .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foregroundColor(.accentColor)
                )
    }
}
""",

             demoView: AnyView(Demo1SubView())
            ),
        
        Demo(title: "Navigation",
             subTitle: "Navigating around",
             icon: "arrow.left.arrow.right.square.fill",
             description:
"""
Use a **NavigationStack** to present a stack of views over a root view. People can add views to the top of the stack by clicking or tapping a **NavigationLink**, and remove views using built-in, platform-appropriate controls, like a Back button or a swipe gesture. The stack always displays the most recently added view that hasn’t been removed, and doesn’t allow the root view to be removed.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/navigation)
[⌘ Mastering NavigationStack](https://swiftwithmajid.com/2022/06/15/mastering-navigationstack-in-swiftui-navigator-pattern/)
[⌘ NavigationStack and NavigationLink](https://www.answertopia.com/swiftui/swiftui-navigationstack-and-navigationlink-overview/)
""",
             kind:.viewDemo,
             code:
"""
struct Product: Identifiable {
    let id = UUID()
    let title: String
}
struct ProductDetailView: View {
    let product: Product
    var body: some View {
        Text(product.title)
            .font(.title)
            .navigationTitle(product.title)
    }
}

struct Demo10View: View {
    let products: [Product] = [
        Product(title: "Apple"),
        Product(title: "Melon"),
        Product(title: "Cherry")
    ]
    
    var body: some View {
        NavigationStack {
            List(products) { product in
                NavigationLink(product.title) {
                    ProductDetailView(product: product)
                }
            }
            .navigationTitle("Products")
        }
    }
}
""",
             codeFull: "",
             demoView: AnyView(Demo10View())
            ),
        
        
        Demo(title: "Styles",
             subTitle: "Reusing modifications",
             icon: "rectangle.on.rectangle.angled",
             description:
"""
In SwiftUI, you *can style* your views using **modifiers**. You can use the built-in modifiers, but also create your own SwiftUI view modifiers.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/viewmodifier)
[⌘ Viewmodifier tutorial](https://www.raywenderlich.com/34699757-swiftui-view-modifiers-tutorial-for-ios)
""",
             kind: .viewDemo,
             code:
"""
struct Border: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background( .thinMaterial,
                in: RoundedRectangle(cornerRadius: 14))
            .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.accentColor)
                    )
    }
}
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .modifier(Border())
            
            Text("Hello, world!")
                .modifier(Border())
        }
        .modifier(Border())
    }
}

""",
             codeFull: "",
             demoView: AnyView(Demo2SubView())
            ),
        
        Demo(title: "Stacks",
             subTitle: "Boxing things",
             icon: "rectangle.split.3x1",
             description:
"""
Our SwiftUI content views **must** contain one or more views, which is the layout we want them to show. When we want more than one view on screen at a time you’ll usually want to tell SwiftUI how to arrange them, and that’s where stacks come in.

**VStack**, a vertical stack, which shows views in a top-to-bottom list. **HStack**, a horizontal stack, which shows views in a left-to-right list.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/vstack)
[⌘ How to create stacks](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-stacks-using-vstack-and-hstack)
[⌘ Switching between H and VStack](https://www.swiftbysundell.com/articles/switching-between-swiftui-hstack-vstack/)
""",
             kind:.viewDemo,
             code:
"""
struct Demo4View: View {
    var body: some View {
        VStack {
            VStack {
                HStack {
                    Image(systemName: "1.circle")
                    Image(systemName: "2.circle")
                    Image(systemName: "3.circle")
                }
                HStack {
                    Image(systemName: "4.circle")
                    Image(systemName: "5.circle")
                    Image(systemName: "6.circle")
                }
            }
            VStack {
                HStack {
                    HStack {
                        Image(systemName: "7.circle")
                        Image(systemName: "8.circle")
                    }
                    HStack {
                        Image(systemName: "9.circle")
                        Image(systemName: "0.circle")
                    }
                }
            }
        }
    }
}
""",
             codeFull:
"""
struct Border: ViewModifier {
    var color = Color.accentColor
    func body(content: Content) -> some View {
        content
            .padding()
            .background( .ultraThickMaterial,
                         in: RoundedRectangle(cornerRadius: 14))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(lineWidth: 2)
                    .foregroundColor(color)
            )
    }
}

struct ShowLabel: ViewModifier {
    var text = "text"
    func body(content: Content) -> some View {
        content
            .overlay(starOverlay,alignment: .top)
    }
    private var starOverlay: some View {
        Text(text)
            .font(.caption)
            .padding(2)
            .background(.green.gradient)
            .cornerRadius(5)
            .offset(y:-10)
    }
}

struct Demo4View: View {
    var body: some View {
        VStack(spacing: 20) {
            VStack(spacing: 20) {
                HStack(spacing: 10) {
                    Image(systemName: "1.circle")
                    Image(systemName: "2.circle")
                        .foregroundStyle( .red, .pink, .black )
                        .symbolRenderingMode(.palette)
                    Image(systemName: "3.circle")
                }
                .modifier(Border(color:.purple))
                HStack(spacing: 10) {
                    Image(systemName: "4.circle")
                    Image(systemName: "5.circle")
                    Image(systemName: "6.circle")
                }
                .modifier(Border(color:.mint))
                .modifier(ShowLabel(text: "HStack"))
            }
            .modifier(Border(color:.red))
            .modifier(ShowLabel(text: "VStack"))
            VStack(spacing: 10) {
                HStack {
                    HStack {
                        Image(systemName: "7.circle")
                        Image(systemName: "8.circle")
                    }
                    .modifier(Border(color:.green))
                    .modifier(ShowLabel(text: "HStack"))
                    HStack {
                        Image(systemName: "9.circle")
                        Image(systemName: "0.circle")
                    }
                    .modifier(Border(color:.green))
                    .modifier(ShowLabel(text: "HStack"))
                }
                .modifier(Border(color:.green))
            }
            .modifier(Border())
            .modifier(ShowLabel(text: "VStack"))
        }
        .modifier(Border())
        .modifier(ShowLabel(text: "VStack"))
    }
}
""",
             demoView: AnyView(Demo4View())
            ),

        Demo(title: "Z Stack",
             subTitle: "3 dimensional boxing",
             icon: "rectangle.portrait.on.rectangle.portrait",
             description:
"""
A ZStack is a pull-in container view. It is a view that **overlays** its child views on *top of each other*. (“Z” represents the Z-axis which is depth-based in a 3D space.)

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/zstack)
[⌘ Working With Stacks ](https://betterprogramming.pub/swiftui-tutorial-working-with-stacks-vstack-hstack-and-zstack-2b0070be18d7)
""",
             kind:.viewDemo,
             code: """
struct ContentView: View {
    @State private var zIdx: [String] = ["id1","id2","id3"]
    var body: some View {
        VStack {
            ZStack {
                Button("1 Up") {
                }
                .frame(width:80, height: 40)
                .background(.green.opacity(0.7))
                .zIndex(1)
                .offset(x: -90, y: -30)

                Button("2 Up") {
                }
                .frame(width:80, height: 40)
                .background(.pink.opacity(0.7))
                .zIndex(2)
                .offset(x: -45, y: 0)

                Button("3 Up") {
                }
                .frame(width:80, height: 40)
                .background(.mint.opacity(0.7))
                .zIndex(3)
                .offset(x: 0, y: 30)

                Button("4 Up") {
                }
                .frame(width:80, height: 40)
                .background(.yellow.opacity(0.7))
                .offset(x: 45, y: 0)
                .zIndex(2)

                Button("5 Up") {
                }
                .frame(width:80, height: 40)
                .background(.purple.opacity(0.7))
                .offset(x: 90, y: -30)
                .zIndex(2)
            }
            .foregroundColor(.white)
            .bold()
            .frame(height: 200)
            
            ZStack {
                Button("1 Up") {
                    upIndex("id1")
                }
                .frame(width:80, height: 80)
                .background(.green)
                .zIndex(getOrder("id1"))
                .offset(x: -30, y: -40)

                Button("2 Up") {
                    upIndex("id2")
                }
                .frame(width:80, height: 80)
                .background(.pink)
                .zIndex(getOrder("id2"))
                
                Button("3 Up") {
                    upIndex("id3")
                }
                .frame(width:80, height: 80)
                .background(.mint)
                .offset(x: 30, y: 40)
                .zIndex(getOrder("id3"))

                
            }
            .foregroundColor(.white)
            .bold()
            .frame(height: 200)
            
            List {
                ForEach( zIdx, id:\\.self ) { id in
                    Text( id )
                }
            }

        }
    }
    func upIndex( _ idx: String ) {
        if let removeIdx = zIdx.firstIndex(where: {$0 == idx}) {
            zIdx.remove(at: removeIdx)
            zIdx.insert(idx, at: 0)
        }
    }
    
    func getOrder( _ idx: String ) -> Double {
        if let removeIdx = zIdx.firstIndex(where: {$0 == idx}) {
            return Double(zIdx.count - removeIdx)
        }
        return 0
    }
}
""",
             codeFull: "",
             demoView: AnyView(Demo5View())
            ),

        Demo(title: "Grid",
             subTitle: "Make a table",
             icon: "rectangle.split.3x3",
             description:
"""
A **Grid view** arranges child views in *rows* and *columns*. This table-like structure makes a layout that is hard to do in vertical and horizontal stacks become easier.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/grid)
[⌘ SwiftUI Grid](https://sarunw.com/posts/swiftui-grid/#:~:text=A%20Grid%20view%20arranges%20child,in%20a%20spreadsheet%2Dlike%20manner.)
[⌘ LazyVGrid and LazyHGrid](https://www.appcoda.com/learnswiftui/swiftui-gridlayout.html)
""",
             kind:.viewDemo,
             code:
"""
struct Demo6View: View {
    var body: some View {
        Grid() {
            GridRow {
                Text("Row 1, Column 1")
                Text("R 1, C 2")
            }
            GridRow {
                Text("R 2, C 1")
                Text("Row 2, Column 2")
            }
        }
    }
}
""",
             codeFull:
"""
struct Demo6View: View {
    var body: some View {
        Grid() {
            GridRow {
                Text("Row 1, Column 1")
                Text("R 1, C 2")
            }
            .modifier(Border())
            GridRow {
                Text("R 2, C 1")
                Text("Row 2, Column 2")
            }
            .modifier(Border())
        }
        .modifier(Border())
    }
}
""",
             demoView: AnyView(Demo6View())
            ),
        
        Demo(title: "Lists",
             subTitle: "Create a list",
             icon: "list.bullet.rectangle",
             description:
"""
When you use SwiftUI's List type, you can display a platform-specific **list of views**. The elements of the list can be *static*, like the child views of the stacks you've created so far, or *dynamically* generated. You can even mix static and dynamically generated views.

[⌘ Apple documentation](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)
[⌘ SwiftUI List: Basic usage](https://sarunw.com/posts/swiftui-list-basic/)
[⌘ Mastering List in SwiftUI](https://swiftwithmajid.com/2021/06/16/mastering-list-in-swiftui/)
""",
             kind:.viewDemo,
             code:
"""
enum BeerType: String {
    case Ale
    case Lager
    case Porter
    case Stout
    case BlondAle
    case BrownAle
    case PaleAle
    case IndiaPaleAle
    case Wheat
    case Pilsner
    case SourAle
    
    enum CodingKeys: String, CodingKey {
        case Ale
        case Lager
        case Porter
        case Stout
        case BlondAle = "Blond Ale"
        case BrownAle = "Brown Ale"
        case PaleAle = "Pale Ale"
        case IndiaPaleAle = "India Pale Ale"
        case Wheat
        case Pilsner
    }
}
struct Beer: Identifiable {
    let id = UUID()
    let name: String
    let kind: BeerType
}
struct Demo7View: View {
    @State private var selection = ""
    @State private var bgColor = Color.red
    @State private var listVersion = true
    @State var arrayOfBeer: [Beer] = [
        Beer(name: "Pilsner Urquell", kind: .Pilsner),
        Beer(name: "Becks", kind: .Pilsner),
        Beer(name: "Budweiser", kind: .Lager),
        Beer(name: "BrewDog", kind: .Ale),
        Beer(name: "Coopers", kind: .PaleAle),
    ]
    
    var body: some View {
        List {
            Section("List type") {
                Toggle("Static or dynamic", isOn: $listVersion)
            }
            if listVersion {
                Section("Static section") {
                    Picker("Selection picker",selection: $selection) {
                        Text("Soft")
                        Text("Hard")
                    }
                    ColorPicker("Color picker", selection: $bgColor)
                }
                
                Text("Demo Colorized text")
                    .bold()
                    .padding(3)
                    .foregroundColor(bgColor)
                    .badge("Badge")

            } else {
                Section("Dynamic Section") {
                    ForEach( arrayOfBeer ) { beer in
                        Text( beer.name )
                    }
                }
            }

        }
    }
}
""",
             codeFull: "",
             demoView: AnyView(Demo7View())
            ),
        
        Demo(title: "Button",
             subTitle: "Working with buttons",
             icon: "button.programmable.square",
             description:
"""
SwiftUI's button is similar to UIButton, except it's **more flexible** in terms of what content it shows and it uses a closure for its action rather than the old target/action system.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/button)
[⌘ How to create a tappable button](https://www.hackingwithswift.com/quick-start/swiftui/how-to-create-a-tappable-button)
[⌘ SwiftUI Button Tutorial](https://www.raywenderlich.com/34851726-swiftui-button-tutorial-customization)
[⌘ The many faces of button in SwiftUI](https://swiftwithmajid.com/2021/06/30/the-many-faces-of-button-in-swiftui/)
""",
             kind:.viewDemo,
             code:
"""
struct Demo3SubView: View {
    @State var hearBeat1 = false
    @State var hearBeat2 = false
    @State var hearBeat3 = false
    var body: some View {
        VStack {
            Button {
                hearBeat1.toggle()
            } label: {
                Label("Button 1", systemImage: hearBeat1 ? "heart" : "heart.fill" )
            }
            .buttonStyle(.borderless)
            
            Button {
                hearBeat2.toggle()
            } label: {
                Label("Button 2", systemImage: hearBeat2 ? "heart" : "heart.fill")
                    .foregroundColor(.white)
            }
            .buttonStyle(.borderedProminent)
            .foregroundColor(.primary)
            .accentColor(.secondary)

            Button {
                hearBeat3.toggle()
            } label: {
                Label("Button 3", systemImage: hearBeat3 ? "heart" : "heart.fill")
                    .labelStyle(ReversIcon())
            }
            .buttonStyle(.borderedProminent)
            
        }
        .modifier(Demo2Border())
    }
}
""",
             codeFull: "",
             demoView: AnyView(Demo3SubView())
            ),
        
        Demo(title: "Input",
             subTitle: "Enter values",
             icon: "character.cursor.ibeam",
             description:
"""
A **TextEditor** view allows you to display and edit multiline, scrollable text in your app's user interface.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/texteditor)
[⌘ SwiftUI TextEditor complete tutorial](https://www.simpleswiftguide.com/swiftui-texteditor-complete-tutorial/)

A **TextField** is a type of control that shows an editable text interface. In SwiftUI, a TextField typically requires a placeholder text which acts similar to a hint, and a State variable that will accept the input from the user (which is usually a Text value).

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/textfield)
[⌘ TextField in SwiftUI](https://sarunw.com/posts/textfield-in-swiftui/)

SwiftUI has two ways of letting users enter numbers, and the one we'll be using here is **Stepper** : a simple - and + button that can be tapped to select a precise number. The other option is Slider , which we'll be using later on – it also lets us select from a range of values, but less precisely

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/stepper)
[⌘ Stepper in SwiftUI](https://medium.com/devtechie/stepper-in-swiftui-67ed8d7a8466)
""",
             kind:.viewDemo,
             code:
"""
struct Demo8View: View {
    @State var text = "Demo text"
    @State var name = ""
    @State var age = 0
    var body: some View {
        Form {
            Section("Long Text edit") {
                TextEditor(text: $text)
                    .textFieldStyle(.roundedBorder)
            }
            Section("Text edit") {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Enter your name", text: $name)
                }
                HStack {
                    Text("Age")
                    Spacer()
                    TextField("Enter your age", value: $age, format: .number)
                }
                Text("You typed this ") +
                Text("\\(name.isEmpty ? "?" : name)").bold()
            }
            Section("Stepper") {
                Stepper("Age", value: $age)
                Stepper("\\(age) yrs", value: $age)
            }
        }
    }
}
""",
             codeFull:
"""
struct Demo8View: View {
    @State var text = "Demo text"
    @State var name = ""
    @State var age = 0
    var body: some View {
        Form {
            Section("Long Text edit") {
                
                TextEditor(text: $text)
                    .textFieldStyle(.roundedBorder)
                    .frame(height: 100)
                    .background(Material.ultraThickMaterial)
                    .cornerRadius(6)
            }
            Section("Text edit") {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Enter your name", text: $name)
                        .background(Material.ultraThickMaterial)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                }
                HStack {
                    Text("Age")
                    Spacer()
                    TextField("Enter your age", value: $age, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 200)
                }
                
                Text("You typed this ") +
                Text("\\(name.isEmpty ? "?" : name)").bold()
            }
            Section("Stepper") {
                Stepper("Age", value: $age)
                Stepper("\\(age) yrs", value: $age)
            }
        }
        .padding()
        .modifier(Border())
    }
}
""",
             demoView: AnyView(Demo8View())
            ),
        
        Demo(title: "Pickers",
             subTitle: "Select values",
             icon: "calendar",
             description:
"""
SwiftUI's **Picker** view manages to combine *UIPickerView*, *UISegmentedControl* , and *UITableView* in one, while also adapting to other styles on other operating systems. The great thing is that we really don't have to care how it works – SwiftUI does a good job of adapting itself automatically to its environment.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/picker)
[⌘ Picker In SwiftUI](https://www.swiftanytime.com/picker-in-swiftui/)
""",
             kind:.viewDemo,
             code:
"""
struct Demo9View: View {
    @State var options = ["Swift", "Kotlin", "Java"]
    @State var selectedItem = "Swift"
    @State var selectedColor = SwiftUI.Color.cyan
    @State var selectedDate: Date = Date.now
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Date selection")
                    .bold()
                DatePicker("Date", selection: $selectedDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            .modifier(Border())
            
            VStack(alignment: .leading) {
                Text("Color selection")
                    .bold()
                ColorPicker("Color selection", selection: $selectedColor)
            }
            .modifier(Border())
            
            VStack(alignment: .leading) {
                Text("Menu")
                    .bold()
                Picker("Pick a language", selection: $selectedItem) {
                    ForEach(options, id: \\.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.menu)
                .frame(idealWidth: 190)
                .frame(maxWidth: 190)
            }
            .modifier(Border())
            
            VStack(alignment: .leading) {
                Text("Segmented")
                    .bold()
                Picker("Pick a language", selection: $selectedItem) {
                    ForEach(options, id: \\.self) { item in
                        Text(item)
                    }
                }
                .frame(idealWidth: 190)
                .frame(maxWidth: 190)
                .pickerStyle(.segmented)
            }
            .modifier(Border())
        }
        .modifier(Border())
    }
}
""",
             codeFull:
"""
struct Demo9View: View {
    @State var options = ["Swift", "Kotlin", "Java"]
    @State var selectedItem = "Swift"
    @State var selectedColor = SwiftUI.Color.cyan
    @State var selectedDate: Date = Date.now
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text("Date selection")
                DatePicker("Date", selection: $selectedDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
            }
            VStack(alignment: .leading) {
                Text("Color selection")
                ColorPicker("Color selection", selection: $selectedColor)
            }
            VStack(alignment: .leading) {
                Text("Menu")
                Picker("Pick a language", selection: $selectedItem) {
                    ForEach(options, id: \\.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.menu)
            }
            VStack(alignment: .leading) {
                Text("Segmented")
                Picker("Pick a language", selection: $selectedItem) {
                    ForEach(options, id: \\.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
            }
        }
    }
}
""",
             demoView: AnyView(Demo9View())
            ),
        
        Demo(title: "Data flow",
             subTitle: "How data flows",
             icon: "arrow.clockwise.circle",
             description:
"""
Changing data in a SwiftUI view can make your UI update automatically. It almost seems like magic. But there’s no magic here, only a sleight of hand known as data flow.
Data flow is one of the key pillars of SwiftUI. Define your UI, give it some data to work with, and for the most part, it just works. Everything stays in sync, and there’s no risk of the UI ending up in a bad state due to changing data.

**Principles of Data Flow**
* Every time we read a piece of data in our view, we're creating a dependency for that view.
* Every time the data changes, the view has to change (read: re-render) to reflect the new value.
* Every piece of data that we're reading in the view hierarchy has a source of truth.
* The source of truth can live in the view hierarchy (if view-related, like a collapsed status), or externally (our models).
* We should always have a single source of truth (no duplicate values).

**@State**
* When a property has an associated property wrapper @State, SwiftUI knows that it needs to persist the storage across multiple updates of the same view.
* Mark @State property as private, to really enforce the idea that state is owned and managed by that view specifically.
* @State properties are a special case of state variables, as SwiftUI knows when they change.
* And because SwiftUI knows that the @State variables change the view body look, SwiftUI knows that the view rendering depend on their state.
* When a @State property changes, in the runtime SwiftUI will recompute the body of that view and all of its children.
* All the changes always flow down through your view hierarchy.
* We're able to do these re-rendering very efficiently because SwiftUI compares the views and renders again only what is changed.
* Views are a function of state, not of a sequence of events.

**@Binding**
* By using the Binding property wrapper, we define an explicit dependency to a source of truth without owning it.
* We don't need to provide an initial value because the binding can be derived from a state.
* Primitives views such as Toggle, TextField, and Slider all expect a binding. We can read and write a @binding property (without owning it!)

**Publishers (External changes)**
* In case the event comes from an external source (a.k.a. not within the views), we use Combine’s Publishers
* It's very important for Views to receive events on the main thread.

**ObservableObject (External Data)**
* When the data is outside our View, swiftUI needs to know how to react on changes of that data
* By making our external data conform to ObservableObject protocol, we are required to have a publisher, accessible via the synthesized objectWillChange property, that fires every time the data is about to change.
* All we need to do later is to associate an @ObservedObject property wrapper in the model and pass the ObservedObject to the view in its initialization.
* While SwiftUI Views are value types (Structs), any time we're using a reference type, we should be using the @ObservedObject property wrapper: this way SwiftUI will know when that data changes and can keep our view hierarchy up to date.

**Environment**
* Thanks to the .environment modifier, we can add our ObservableObjects into the environment.
* By using this @EnvironemntObject property wrapper, we can create a dependency to these environment objects.
* Object Binding vs Environment
* We can build your whole app with @Binding, but it can get kind of cumbersome to pass around the model from view to view.
* EnvironmentObject is a convenience for passing data around your hierarchy indirectly (without the need to pass the object to each view first).

[⌘ Apple documentation](https://developer.apple.com/videos/play/wwdc2019/226/)
[⌘ WWDC notes](https://www.wwdcnotes.com/notes/wwdc19/226/)
[⌘ Understanding Data Flow in SwiftUI](https://www.raywenderlich.com/11781349-understanding-data-flow-in-swiftui)
[⌘ The Strategic SwiftUI Data Flow](https://matteomanferdini.com/swiftui-data-flow/)
[⌘ Complete Guide to a Data Flow](https://medium.nextlevelswift.com/complete-guide-to-data-flow-in-swiftui-bb5fca1cb4c5)
[⌘ Managing Data Flow in SwiftUI](https://swiftwithmajid.com/2019/07/03/managing-data-flow-in-swiftui/)
""",
             kind:.viewDemo,
             code:
"""
struct DataFlowA: View {
    @State var dataA: Int
    
    var body: some View {
        VStack {
            Text("View2")
            Text("@State")
            Button("Add 1 to A", action: {dataA = dataA + 1})
            Text("Show A: \\(dataA)")
        }
    }
}
struct DataFlowB: View {
    @Binding var dataA: Int
    
    var body: some View {
        VStack {
            Text("View3")
            Text("@Binding")
            Button("Add 1 to A", action: {dataA = dataA + 1})
            Text("Show A: \\(dataA)")
        }
    }
}
struct DataFlow: View {
    @State var dataA: Int = 0

    var body: some View {
        VStack {
            Text("View1")
            Text("Main view")
            Button("Add 1 to A", action: {dataA = dataA + 1})
            Text("Show A: \\(dataA)")

            HStack {
                VStack(alignment: .leading) {
                    DataFlowA(dataA: dataA)
                }
                VStack(alignment: .leading) {
                    DataFlowA(dataA: dataA)
                    .id(dataA)
                }
            }
            HStack {
                VStack(alignment: .leading) {
                    DataFlowB(dataA: $dataA)
                }
                VStack(alignment: .leading) {
                    DataFlowB(dataA: $dataA)
                        .id(dataA)
                }
            }
        }
    }
}
""",
             codeFull:
"""
struct DataFlowA: View {
    @State var dataA: Int
    
    var body: some View {
        VStack {
            Text("View2").bold()
            Text("@State")
                .font(.callout)

            Button("Add 1 to A", action: {dataA = dataA + 1})
                .buttonStyle(.borderedProminent)
            Text("Show A: \\(dataA)")
        }
        .padding()
        .background(Color.yellow.gradient)
        .cornerRadius(12)

    }
}
struct DataFlowB: View {
    @Binding var dataA: Int
    
    var body: some View {
        VStack {
            Text("View3").bold()
            Text("@Binding")
                .font(.callout)
            
            Button("Add 1 to A", action: {dataA = dataA + 1})
                .buttonStyle(.borderedProminent)
            Text("Show A: \\(dataA)")
        }
        .padding()
        .background(Color.red.gradient)
        .cornerRadius(12)
    }
}
struct DataFlow: View {
    @State var dataA: Int = 0

    var body: some View {
        VStack {
            Text("View1").bold()
            Text("Main view")
                .font(.callout)
            
            Button("Add 1 to A", action: {dataA = dataA + 1})
                .buttonStyle(.borderedProminent)
            Text("Show A: \\(dataA)")

            // State
            HStack {
                // -- no id, no refresh
                VStack(alignment: .leading) {
                    DataFlowA(dataA: dataA)
                    Text("no id ⤴︎")
                }
                VStack(alignment: .leading) {
                    DataFlowA(dataA: dataA)
                    .id(dataA)
                    Text("with id ⤴︎")
                }
            }
            // Binding
            HStack {
                VStack(alignment: .leading) {
                    DataFlowB(dataA: $dataA)
                    Text("no id ⤴︎")
                }
                VStack(alignment: .leading) {
                    DataFlowB(dataA: $dataA)
                        .id(dataA)
                    Text("with id ⤴︎")
                }
            }
        }
        .padding()
        .background(Color.green.gradient)
        .cornerRadius(12)
    }
}
""",

             demoView: AnyView(DataFlow())
            ),
        
        Demo(title: "MVVM",
             subTitle: "Pattern: MVVM",
             icon: "rectangle.3.group.bubble.left",
             description:
"""
In the ancient era of the imperative UIKit, Apple built all the apps around the **Model View Controller** or **MVC** pattern. Over time, the apps became bigger and bigger and the developers started to use the Controller as a huge container for all kinds of code. The UI logic went inside the controller, the business logic went inside the controller, the presentation of other controllers went inside the controller… controllers became quickly huge monsters. The MVC acronym became soon famous as Massive View Controller. To avoid this problem, the Developers started to apply different patterns. One of them was the **Model-View-ViewModel** or **MVVM**.
When Apple decided to create from scratch a new declarative framework for the user interface, SwiftUI, chose the **MVVM** as the main pattern for its technology and adopted some pretty clean solutions to let people use it easily.

**Model**: model refers either to a domain model, which represents real state content (an object-oriented approach), or to the data access layer, which represents content (a data-centric approach).

**View**: as in the model–view–controller (MVC) and model–view–presenter (MVP) patterns, the view is the structure, layout, and appearance of what a user sees on the screen.It displays a representation of the model and receives the user’s interaction with the view (mouse clicks, keyboard input, screen tap gestures, etc.), and it forwards the handling of these to the view model via the data binding (properties, event callbacks, etc.) that is defined to link the view and view model.

**View model**: the view model is an abstraction of the view exposing public properties and commands. Instead of the controller of the MVC pattern, or the presenter of the MVP pattern, MVVM has a binder, which automates communication between the view and its bound properties in the view model. The view model has been described as a state of the data in the model. The main difference between the view model and the Presenter in the MVP pattern is that the presenter has a reference to a view, whereas the view model does not. Instead, a view directly binds to properties on the view model to send and receive updates. To function efficiently, this requires a binding technology or generating boilerplate code to do the binding.

**Binder**: declarative data and command-binding are implicit in the MVVM pattern. In the Microsoft solution stack, the binder is a markup language called XAML. The binder frees the developer from being obliged to write boiler-plate logic to synchronize the view model and view. When implemented outside of the Microsoft stack, the presence of a declarative data binding technology is what makes this pattern possible, and without a binder, one would typically use MVP or MVC instead and have to write more boilerplate (or generate it with some other tool).

[⌘ Apple documentation](https://developer.apple.com/tutorials/swiftui)
[⌘ Clean Architecture for SwiftUI](https://nalexn.github.io/clean-architecture-swiftui/)
[⌘ Introducing MVVM into your SwiftUI project](https://www.hackingwithswift.com/books/ios-swiftui/introducing-mvvm-into-your-swiftui-project)
[⌘ MVVM Pattern in SwiftUI](https://blog.devgenius.io/mvvm-pattern-in-swiftui-a-practical-example-c79c5cc44f74)
[⌘ iOS MVVM Tutorial: Refactoring from MVC](https://www.raywenderlich.com/6733535-ios-mvvm-tutorial-refactoring-from-mvc)
""",
             kind:.viewDemo,
             code:
"""
""",
             codeFull: "",
             demoView: nil
            ),

        Demo(title: "Concurrency",
             subTitle: "Do things asynch/parallel",
             icon: "repeat.1.circle.fill",
             description:
"""
Swift has built-in support for writing **asynchronous and parallel** code in a structured way. **Asynchronous** code can be suspended and resumed later, although only one piece of the program executes at a time. Suspending and resuming code in your program lets it continue to make progress on short-term operations like updating its UI while continuing to work on long-running operations like fetching data over the network or parsing files. **Parallel** code means multiple pieces of code run simultaneously.
A program that uses parallel and asynchronous code carries out multiple operations at a time; it suspends operations that are waiting for an external system, and makes it easier to write this code in a memory-safe way.

[⌘ Swift.org documentation](https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html)
[⌘ Apple documentation](https://developer.apple.com/news/?id=o140tv24)
[⌘ Apple video](https://developer.apple.com/videos/play/wwdc2021/10019/)
[⌘ SwiftUI and Structured Concurrency](https://www.raywenderlich.com/31056103-swiftui-and-structured-concurrency)
[⌘ Swift Concurrency by Exampl](https://www.hackingwithswift.com/quick-start/concurrency)
[⌘ Getting Started with async/await](https://peterfriese.dev/posts/swiftui-concurrency-essentials-part1/)
[⌘ Concurrency in SwiftUI](https://www.swiftbysundell.com/tags/concurrency/)
[⌘ Effortless Concurrency](https://matteomanferdini.com/swift-async-await/)
""",
             kind:.viewDemo,
             code:
"""
// Source: https://www.ralfebert.com/ios-app-development/swiftui-async-await-tutorial/
struct Country: Identifiable, Codable {
    var id: String
    var name: String
}

@MainActor
class CountriesModel: ObservableObject {
    @Published var countries : [Country] = []

    func reload() async {
        let url = URL(string: "https://www.ralfebert.de/examples/v2/countries.json")!
        let urlSession = URLSession.shared

        do {
            let (data, _) = try await urlSession.data(from: url)
            self.countries = try JSONDecoder().decode([Country].self, from: data)
        }
        catch {
            // Error handling in case the data couldn't be loaded
            // For now, only display the error on the console
            debugPrint("Error loading \\(url): \\(String(describing: error))")
        }
    }
}

struct Demo15View: View {
    @StateObject var countriesModel = CountriesModel()

    var body: some View {
        List(countriesModel.countries) { country in
            Text(country.name)
        }
        .task {
            await self.countriesModel.reload()
        }
        .refreshable {
            await self.countriesModel.reload()
        }
    }
}
""",
             codeFull: "",
             demoView: AnyView(Demo15View())
            ),
        
        Demo(title: "Accessibility",
             subTitle: "Helping in many ways",
             icon: "figure.roll.runningpace",
             description:
"""
Like all Apple UI frameworks, SwiftUI comes with built-in **accessibility support**. The framework introspects common elements like navigation views, lists, text fields, sliders, buttons, and so on, and provides basic accessibility labels and values by default. You don’t have to do any extra work to enable these standard accessibility features.

Making your app accessible means taking steps to ensure that everyone can use it fully regardless of their individual needs. For example, if they are blind then your app should work well with the system’s VoiceOver system to ensure your UI can be read smoothly.

SwiftUI gives us a huge amount of functionality for free, because its layout system of VStack and HStack naturally forms a flow of views. However, it isn’t perfect, and any time you can add some extra information to help out the iOS accessibility system it’s likely to help.

Usually the best way to test out your app is to enable VoiceOver support and run the app on a real device – if your app works great with VoiceOver, there’s a good chance you’re already far ahead of the average for iOS apps.

Anyway, in this technique project we’re going to look at a handful of accessibility techniques, then look at some of the previous projects we made to see how they might get upgraded.

For now, please create a new iOS app using the App template. You should run this project on a real device, so you can enable VoiceOver for real.

[⌘ Apple documentation](https://developer.apple.com/documentation/swiftui/view-accessibility)
[⌘ Apple video](https://developer.apple.com/videos/play/wwdc2019/238/)
[⌘ Accessibility in SwiftUI](https://www.avanderlee.com/swiftui/accessibility-uikit-developers/)
[⌘ Accessibility in SwiftUI](https://swiftwithmajid.com/2019/09/10/accessibility-in-swiftui/)
[⌘ SwiftUI Accessibility](https://medium.com/@r.whitaker/swiftui-accessibility-e58d8850149f)
""",
             kind:.viewDemo,
             code:
"""
struct Demo14View: View {
    @State var sliderValue: Double = 1
    let minimumValue:Double = 1
    let maximumvalue:Double = 8
    var body: some View {
        VStack {
            Button(action: {}, label: { Label( "Send message", systemImage: "envelope") })
                .buttonStyle(.borderedProminent)
                .accessibility(label: Text("Send"))
                .accessibility(hint: Text("Sends your message."))
                .accessibility(identifier: "sendMessageButton")
            
            Slider(value: $sliderValue, in: minimumValue ... maximumvalue )
                .accessibility(value: Text("\\(Int(sliderValue)) out of \\(maximumvalue)"))
            
            Text("Your value \\(sliderValue)")
        }
    }
}
""",
             codeFull: "",
             demoView: AnyView(Demo14View())
            ),
    ]
    
    init() {
        demos = demoData
    }
}
