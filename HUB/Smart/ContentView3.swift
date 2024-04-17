//
//  ContentView2.swift
//  HUB
//
//  Created by Ethan Spencer on 11/4/23.
//

import SwiftUI
import Darwin
import Network

struct ContentView3: View {
    @State public var isOpen:Bool = true
    @State var doorStatus:String = bDoorStatus3(status:true)
    @State var buttonMessage:String = bMessage3(status:true)
    @State var buttonColor:Color = bColor3(status:true)
    
    var body: some View {
        VStack {
            Spacer()
            Text("Box 3")
            Spacer()
            
            Button {
                toggle3()
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

struct ContentView3_Previews: PreviewProvider {
    static var previews: some View {
        ContentView3()
    }
}

func toggle3() {
    guard let ethansURL3 =  URL(string:"http://192.168.4.20")
           else{
               return
           }
           
           //let body = ""
           //let finalBody = body.data(using: .utf8)
           var request3 = URLRequest(url: ethansURL3)
           request3.httpMethod = "POST /Toggle"
           //request.httpBody = finalBody
           
           URLSession.shared.dataTask(with: request3){
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

func bColor3(status:Bool) -> Color{
    if status {
        return .red
    } else {
        return .green
    }
}

func bMessage3(status:Bool) -> String{
    if status {
        return "Close"
    } else {
        return "Open"
    }
}

func bDoorStatus3(status:Bool) -> String{
    if status {
        return "Door is open"
    } else {
        return "Door is closed"
    }
}
