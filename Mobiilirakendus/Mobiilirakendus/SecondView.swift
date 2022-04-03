//
//  SecondView.swift
//  Mobiilirakendus
//
//  Created by Gaspar Luik on 14.03.2022.
//

import SwiftUI

struct SecondView: View {
    @State var nr = 0
    let url = "https://i.imgur.com/ePSgEZt.jpeg"
    var body: some View {
        
        VStack{
            Text("This is the second view")
//            Image("
            AsyncImage(url: URL(string: url)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                .background(Color.gray)
                .clipShape(Circle())
            Text("What a nice weather")
                .font(.largeTitle)
                .bold()
                .multilineTextAlignment(.center)
            Text("Currently: 2 °C. Light rain. Mostly cloudy.")
                .font(.title)
                .foregroundColor(.secondary)
            Text("Random number is: \(nr)")
            Button(action: {
                nr=Int.random(in: 1..<10)
            }){
                HStack{
                    Image("cold")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Text("Generate number")
                }
                .background(Color.blue)
                .cornerRadius(10)
                .foregroundColor(Color.white)
            }
        }
        
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
