//
//  ContentView.swift
//  Mobiilirakendus
//
//  Created by Gaspar Luik on 25.02.2022.
//

import SwiftUI

struct ContentView: View {
    @State var nr = 0
    let url = "https://loveincorporated.blob.core.windows.net/contentimages/gallery/03211459-0607-4d07-8a6c-9966e3820a7d-Mount-Kirkjufell-Iceland.jpg"
    var body: some View {
        //Navigation view tähendab, et selle ala sees saab niiöedal lehte vahetada. Kui Navigation view oleks näiteks selline ->
        /*NavigationView{
        
            VStack{
                NavigationLink(destination: SecondView()){
                    Text("Second view")
                }
         }*/
        // siis katab vahetuv leht ainult pool ekraanist ära, sest ta ei hõlma tervet ekraani.
        NavigationView{
        
            VStack{
                //navigationlink on siis niiöelda <a> tag html-is, see redirectib uuele vaatele
                NavigationLink(destination: SecondView()){
                    //Siia sisse võib panna pildi, nupu, mida iganes
                    Text("Second view")
                }
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
                        Image("summer")
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
