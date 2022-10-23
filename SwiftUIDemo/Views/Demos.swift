//
//  Demos.swift
//  SwiftUIDemo
//
//  Created by HaZe on 22/10/2022.
//

import SwiftUI

struct Demo1SubView: View {
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

struct Demo2Border: ViewModifier {
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

struct Demo2SubView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .modifier(Demo2Border())
            
            Text("Hello, world!")
                .modifier(Demo2Border())
        }
        .modifier(Demo2Border())
    }
}

struct ReversIcon: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
                .frame(width: 50)
                .background(.quaternary, in: Circle())
        }
    }
}

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

struct Demo5View: View {
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
            .id(UUID())
            
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
            .id(UUID())
            
            List {
                ForEach( zIdx, id:\.self ) { id in
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
    @State var selection = ""
    @State var bgColor = SwiftUI.Color.red
    @State var listVersion = true
    @State var showingAlert = false
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
                            .swipeActions {
                                Button("Cheers") {
                                    showingAlert.toggle()
                                }
                                .tint(.green)
                            }
                            .alert("Cheers 🍻", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                    }
                }
            }
        }
        .frame(height: 390)
        .modifier(Border())
    }
}

struct Demo8View: View {
    @State var text = "Sed ut perspiciatis unde omnis iste natus error sit ..."
    @State var name = ""
    @State var age = 0
    var body: some View {
        Form {
            Section("Long Text edit") {
                TextEditor(text: $text)
                    .textFieldStyle(.roundedBorder)
                    .frame(minHeight: 100)
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
                        .frame(width: 100)
                }
                HStack {
                    Text("Age")
                    Spacer()
                    TextField("Enter your age", value: $age, format: .number)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 100)
                }
                
                Text("You typed this ") +
                Text("\(name.isEmpty ? "?" : name)").bold()
            }
            
            Section("Stepper") {
                Stepper("Age", value: $age)
                Stepper("\(age) yrs", value: $age)
            }
        }
        .modifier(Border())
        .frame(height: 550)
    }
}

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
                    ForEach(options, id: \.self) { item in
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
                    ForEach(options, id: \.self) { item in
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
                .accessibility(value: Text("\(Int(sliderValue)) out of \(maximumvalue)"))
            
            Text("Your value \(sliderValue)")
        }
    }
}

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
            debugPrint("Error loading \(url): \(String(describing: error))")
        }
    }
}

struct Demo15View: View {
    @StateObject var countriesModel = CountriesModel()

    var body: some View {
        VStack {
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
        .frame(width: 190, height: 210)
        .modifier(Border())
    }
}

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
        .frame(width: 190, height: 230)
        .modifier(Border())
    }
}

struct DataFlowA: View {
    @State var dataA: Int
    
    var body: some View {
        VStack {
            Text("View2").bold()
            Text("@State")
                .font(.callout)

            Button("Add 1 to A", action: {dataA = dataA + 1})
                .buttonStyle(.borderedProminent)
            Text("Show A: \(dataA)")
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
            Text("Show A: \(dataA)")
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
            Text("Show A: \(dataA)")

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
