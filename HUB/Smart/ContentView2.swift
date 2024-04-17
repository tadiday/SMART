//
//  ContentView2.swift
//  HUB
//
//  Created by Ethan Spencer on 11/4/23.
//

import SwiftUI
import Darwin
import Network

struct ContentView2: View {
    @State public var isOpen:Bool = true
    @State var doorStatus:String = bDoorStatus2(status:true)
    @State var buttonMessage:String = bMessage2(status:true)
    @State var buttonColor:Color = bColor2(status:true)
    
    var body: some View {
        VStack {
            Spacer()
            Text("Box 2")
            Spacer()
            
            Button {
                toggle2()
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

struct ContentView2_Previews: PreviewProvider {
    static var previews: some View {
        ContentView2()
    }
}

func toggle2() {
    guard let ethansURL2 =  URL(string:"http://192.168.4.2")
           else{
               return
           }
           
           //let body = ""
           //let finalBody = body.data(using: .utf8)
           var request2 = URLRequest(url: ethansURL2)
           request2.httpMethod = "POST /Toggle"
           //request.httpBody = finalBody
           
           URLSession.shared.dataTask(with: request2){
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

func bColor2(status:Bool) -> Color{
    if status {
        return .red
    } else {
        return .green
    }
}

func bMessage2(status:Bool) -> String{
    if status {
        return "Close"
    } else {
        return "Open"
    }
}

func bDoorStatus2(status:Bool) -> String{
    if status {
        return "Door is open"
    } else {
        return "Door is closed"
    }
}
