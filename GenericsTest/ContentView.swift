//
//  ContentView.swift
//  GenericsTest
//
//  Created by sako0602 on 2023/09/30.
//

import SwiftUI

enum Mode {
    case str
    case int
}

struct Item<Elemet> {
    var items:[Elemet] = []
    
    mutating func push(_ item: Elemet){
        self.items.append(item)
    }
    mutating func pop(){
        self.items.removeLast()
    }
}

struct ContentView: View {
    
    @State private var modo: Mode = .str
    @State private var textArray = Item<String>()
    @State private var numArray = Item<Int>()
    @State private var text = ""
    @State private var numText = ""
    
    var body: some View {
        NavigationStack{
            TabView(selection: $modo){
                    VStack {
                        TextField("文字", text:$text)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        List(textArray.items, id: \.self ){ item in
                            Text(item)
                        }
                    }.tabItem {
                        Image(systemName: "circle.fill")
                    }
                    .tag(Mode.str)
                    
                    
                    VStack {
                        TextField("数", text: $numText)
                            .textFieldStyle(.roundedBorder)
                            .padding()
                        List(numArray.items, id: \.self ){ item in
                            Text("\(item)")
                        }
                    }
                    .tabItem {
                        Image(systemName: "square.fill")
                    }
                    .tag(Mode.int)
            }
            
            .navigationTitle("items")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                        if modo == Mode.int {
                            let num = Int(numText) ?? 0
                            numArray.push(num)
                        } else {
                            textArray.push(text)
                        }
                    } label: {
                        Image(systemName: "tray.and.arrow.down.fill")
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                        if modo == Mode.int {
                            numArray.pop()
                        } else {
                            textArray.pop()
                        }
                    } label: {
                        Image(systemName: "party.popper.fill")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
