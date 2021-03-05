//
//  SettingsView.swift
//  ToDoListSwiftUI
//
//  Created by Admin on 22/02/21.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var iconSettings: IconNames
    
    var body: some View {
        NavigationView{
            VStack(alignment: .center){
                Form{
                    
                    Section(header: Text("Choose the app icon")){
                                      Picker(selection: $iconSettings.currentIndex, label: Text("App Icons")){
                                         ForEach(0..<iconSettings.iconNames.count){index in
                                            HStack{
                                               Image(uiImage: UIImage(named: self.iconSettings.iconNames[index] ?? "Blue") ?? UIImage())
                                                  .renderingMode(.original)
                                                  .resizable()
                                                  .scaledToFit()
                                                  .frame(width: 44,height: 44)
                                                  .cornerRadius(8)
                                               
                                               Spacer().frame(width: 8)
                                               
                                               Text(self.iconSettings.iconNames[index] ?? "Blue")
                                                  .frame(alignment: .leading)
                                            }
                                            .padding(3)
                                         }
                                      }
                                      .onReceive([self.iconSettings.currentIndex].publisher.first()){
                                         (value) in
                                         let index = self.iconSettings.iconNames.firstIndex(of:
                                                                                               UIApplication.shared.alternateIconName) ?? 0
                                         if index != value {
                                            UIApplication.shared.setAlternateIconName(self.iconSettings.iconNames[value]){
                                               error in
                                               if let error = error {
                                                  print(error.localizedDescription)
                                               }else{
                                                  print("Success")
                                               }
                                            }
                                         }
                                      }
                                   }
                                   .padding(.vertical,3)
                    
                    Section(header: Text("Follow me on my soccial media")){
                        FormRowStaticView(icon: "globe", color: .pink, text: "My Website", link: "")
                        FormRowStaticView(icon: "link", color: .blue, text: "Twitter", link: "")
                        FormRowStaticView(icon: "desktop", color: .purple, text: "Instagram", link: "")
                    }
                    .padding(.vertical,3)
                    
                    Section(header: Text("About the Application")){
                        FormRowLinkView(icon: "gear", firstText: "Application", secondText: "ToDo")
                        FormRowLinkView(icon: "checkmark.seal", firstText: "Compability", secondText: "iPhone,iPad")
                        FormRowLinkView(icon: "keyboard", firstText: "Developed", secondText: "Lutfi")
                        FormRowLinkView(icon: "Flag", firstText: "Version", secondText: "1.1.0")
                    }
                    .padding(.vertical,3)
                }
                .listStyle(GroupedListStyle())
                .environment(\.horizontalSizeClass, .regular) //style horizontal yang tepi kanan dan kirinya tidak rapat ke kanan dan kiri. style yang lain namanaya .compact = fungsinya kebalikan reguler
                
                
                Text("Copyright All rights reserved. Less code")
                    .multilineTextAlignment(.center)
                    .font(.footnote)
                    .padding(.top,6)
                    .padding(.bottom,8)
                    .foregroundColor(.secondary)
            }
            
            
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.presentationMode.wrappedValue.dismiss()
                                    }){
                                        Image(systemName: "xmark")
                                    }
            )
            .navigationBarTitle("Settings",displayMode: .inline)
            .background(Color("ColorBase")).edgesIgnoringSafeArea(.all)
            
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
