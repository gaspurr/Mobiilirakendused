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
    @State var selectedIndex = 1
    
    let tabBarImageNames = ["trash","gear","camera.fill","person"]
    
    init(){
        UITabBar.appearance().barTintColor = .systemBackground
    }
    var body: some View {
        
        VStack{
            
            ZStack {
                switch selectedIndex {
                case 0:
                    VStack{
                        Spacer()
                        /*NavigationLink(destination: SecondView(),Image(systemName: tabBarImageNames[0]))
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.orange)*/
                        Text("wefwef")
                        Spacer()
                    }
                    
                case 1:

                case 2:
                    VStack{
                        Spacer()
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
                        Spacer()
                    }
 
                default:
                    Text("Remaining tabs")
                }
            }
            
            Spacer()
            
            HStack {
                ForEach(0..<4) { num in
                    Button(action: {
                        
                        selectedIndex = num
                    }, label: {
                        Spacer()
                        if(tabBarImageNames[num] == "camera.fill"){
                            
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.orange) : .init(white: 0.8))
                        }else{
                            Image(systemName: tabBarImageNames[num])
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                        }

                        Spacer()
                    })
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
