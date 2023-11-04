//
//  ContentView.swift
//  HUB
//
//  Created by Ethan Spencer on 11/4/23.
//

import SwiftUI


struct ContentView: View {
    @State public var isOpen:Bool = true
    @State var doorStatus:String = bDoorStatus(status:true)
    @State var buttonMessage:String = bMessage(status:true)
    @State var buttonColor:Color = bColor(status:true)
    
    var body: some View {
        VStack {
            Spacer()
            
            Text(doorStatus)
                .font(.largeTitle)
                .padding(.bottom)
            
            Button {
                if isOpen == true {
                    close()
                    buttonColor = .green
                    buttonMessage = "Open"
                    doorStatus = "Door is closed"
                    isOpen = false
                } else if isOpen == false {
                    open()
                    buttonColor = .red
                    buttonMessage = "Close"
                    doorStatus = "Door is open"
                    isOpen = true
                }
            } label: {
                ZStack{
                    Circle().padding(.all, 50.0).frame(width: 300.0, height: 300.0).foregroundColor(buttonColor)
                    Text(buttonMessage)
                        .font(.title)
                        .foregroundColor(Color.black)
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

func open() {
    guard let ethansURL =  URL(string:"http://108.28.58.243:42069")
           else{
               return
           }
           
           //let body = ""
           //let finalBody = body.data(using: .utf8)
           var request = URLRequest(url: ethansURL)
           request.httpMethod = "POST /Open"
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

func close() {
    guard let ethansURL =  URL(string:"http://108.28.58.243:42069")
           else{
               return
           }
           
           //let body = ""
           //let finalBody = body.data(using: .utf8)
           var request = URLRequest(url: ethansURL)
           request.httpMethod = "POST /Close"
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
