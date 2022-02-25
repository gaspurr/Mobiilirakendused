//
//  ContentView.swift
//  Mobiilirakendus
//
//  Created by Gaspar Luik on 25.02.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack{
            Image("cold")
                .resizable()
                .scaledToFit()
            Text("What a nice weather")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("Currently: 2 °C. Light rain. Mostly cloudy.")
                .font(.title)
                .foregroundColor(.secondary)
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
