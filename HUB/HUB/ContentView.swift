//
//  ContentView.swift
//  HUB
//
//  Created by Ethan Spencer on 11/4/23.
//

import SwiftUI
import Darwin


struct ContentView: View {
    @State public var isOpen:Bool = true
    @State var doorStatus:String = bDoorStatus(status:true)
    @State var buttonMessage:String = bMessage(status:true)
    @State var buttonColor:Color = bColor(status:true)
    
    var body: some View {
        VStack {
            Spacer()
            
            Button {
                toggle()
                buttonColor = .green
                let time = DispatchTime.now() + 1.0
                DispatchQueue.main.asyncAfter(deadline:time){
                    buttonColor = .red
                }
            } label: {
                ZStack{
                    Circle().padding(.all, 50.0).frame(width: 300.0, height: 300.0).foregroundColor(buttonColor)
                }
            }
            
            Spacer()

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func toggle() {
    guard let ethansURL =  URL(string:"http://10.42.0.104")
           else{
               return
           }
           
           //let body = ""
           //let finalBody = body.data(using: .utf8)
           var request = URLRequest(url: ethansURL)
           request.httpMethod = "POST /Toggle"
           //request.httpBody = finalBody
           
           URLSession.shared.dataTask(with: request){
               (data, response, error) in
               print(response as Any)
               if let error = error {
                   print(error)
                   return
               }
               guard let data = data else{
                   return
               }
               print(data, String(data: data, encoding: .utf8) ?? "*unknown encoding*")
               
           }.resume()
}

func bColor(status:Bool) -> Color{
    if status {
        return .red
    } else {
        return .green
    }
}

func bMessage(status:Bool) -> String{
    if status {
        return "Close"
    } else {
        return "Open"
    }
}

func bDoorStatus(status:Bool) -> String{
    if status {
        return "Door is open"
    } else {
        return "Door is closed"
    }
}
