//
//  ContentView.swift
//  Mobiilirakendus
//
//  Created by Gaspar Luik on 25.02.2022.
//

import SwiftUI
import Combine
import AVFoundation
import CoreData

struct ContentView: View {
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \UserInfo.firstName, ascending: true)],
        animation: .default)
    private var settings: FetchedResults<UserInfo>
    
    @State private var firstName = ""
    @State private var gender = ""
    @State private var age = 20
    private let genders = ["Mees", "Naine"]
    
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var openCameraActionSheet = false
    @State private var selectedImage: UIImage?
    @State var nr = 0
    let url = "https://loveincorporated.blob.core.windows.net/contentimages/gallery/03211459-0607-4d07-8a6c-9966e3820a7d-Mount-Kirkjufell-Iceland.jpg"
    @State var selectedIndex = 1
    
    @State private var showSheet: Bool = false
    
    let tabBarImageNames = ["trash", "gear", "camera.fill", "person"]
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    func activateSheet() {
        showSheet = true
    }
    var body: some View {
        //Navigation view tähendab, et selle ala sees saab niiöedal lehte vahetada. Kui Navigation view oleks näiteks selline ->
        /*NavigationView{
         VStack{
         NavigationLink(destination: SecondView()){
         Text("Second view")
         }
         }*/
        // siis katab vahetuv leht ainult pool ekraanist ära, sest ta ei hõlma tervet ekraani.
        NavigationView {
            VStack {
                ZStack {
                    switch selectedIndex {
                    case 0:
                        VStack{
                            Spacer()
                            Text("Delete smh")
                            Spacer()
                        }
                    case 1:
                        Spacer()
                        ScrollView {
                            Text("Settings")
                            Text("Efeef")
                            Text("About me")
                            Text("About you")
                        }
                    case 2:
                        ImagePickerView(selectedImage: self.$selectedImage, sourceType: sourceType)
                    case 3:
                        Form {
                            Section {
                                TextField("Eesnimi", text: $firstName)
                                    .disableAutocorrection(true)
                                Picker("Sugu", selection: $gender) {
                                    ForEach(genders, id: \.self) {
                                        gender in Text(gender)
                                    }
                                }
                                Stepper(value: $age,
                                        in: 14...100,
                                        label: {
                                    Text("Vanus: \(self.age)")
                                })
                            }
                            Section {
                                Button("Salvesta") {
                                    let userInfo = UserInfo(context: viewContext)
                                    userInfo.firstName = self.firstName
                                    userInfo.gender = self.gender
                                    userInfo.age = String(self.age)
                                    settings.forEach(viewContext.delete)
                                    do {
                                        try viewContext.save()
                                    } catch {
                                        print("error \(error.localizedDescription)")
                                    }
                                }
                            }
                            ForEach(settings) { setting in
                                Section(header: Text("Salvestatud andmed")) {
                                    HStack {
                                        Text("Eesnimi").font(.headline)
                                        Spacer()
                                        Text(setting.firstName!)
                                    }
                                    HStack {
                                        Text("Sugu").font(.headline)
                                        Spacer()
                                        Text(setting.gender!)
                                    }
                                    HStack {
                                        Text("Vanus").font(.headline)
                                        Spacer()
                                        Text(setting.age!)
                                    }
                                }
                            }
                        }.navigationTitle(Text("Sisesta andmed"))
                    default:
                        VStack {
                            Spacer()
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
                
                Spacer()
                
                HStack(spacing: 40) {
                    Button(action: {
                        selectedIndex = 0
                    }) {
                        Image(systemName: "scribble")
                            .frame(width: 40, height: 40)
                    }
                    Button(action: {
                        selectedIndex = 1
                    }) {
                        Image(systemName: "allergens")
                            .frame(width: 40, height: 40)
                    }
                    Button(action: {
                        openCameraActionSheet.toggle()
                    }) {
                        Image(systemName: "camera.fill")
                            .frame(width: 40, height: 40)
                    }.actionSheet(isPresented: $openCameraActionSheet){
                        ActionSheet(title: Text("Kas soovid avada kaamera või galerii?"), buttons: [
                            .default(Text("Kaamera"), action: {
                                sourceType = .camera
                                selectedIndex = 2
                            }),
                            .default(Text("Galerii"), action: {
                                sourceType = .photoLibrary
                                selectedIndex = 2
                            }),
                        ])
                    }
                    Button(action: {
                        selectedIndex = 3
                    }) {
                        Image(systemName: "wrench.and.screwdriver")
                            .frame(width: 40, height: 40)
                    }
                    Button(action: {
                        selectedIndex = 4
                    }) {
                        Image(systemName: "person.fill")
                            .frame(width: 40, height: 40)
                    }
                }
                
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
