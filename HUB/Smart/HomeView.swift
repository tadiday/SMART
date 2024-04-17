import SwiftUI

struct Device: Identifiable {
    let id: Int
    let name: String
}

struct HomeView: View {
    @State private var devices: [Device] = [] /*[
        Device(id: 1, name: "Device 1"),
        Device(id: 2, name: "Device 2"),
        Device(id: 3, name: "Device 3"),
        Device(id: 4, name: "Device 4")
    ]*/

    var body: some View {
          NavigationView {
              VStack(spacing: 20) {
                  
                  Text("Hub")
                      .font(.custom("Avenir Heavy", size: 28))
                      .foregroundColor(.blue)
                  
                  List {
                      ForEach(devices) { device in
                          NavigationLink(destination: DeviceView(device: device)) {
                              HStack {
                                  Text(device.name)
                                      .font(.custom("Avenir", size: 18))
                                      .padding(.vertical, 8)
                                      .padding(.horizontal)
                                      .frame(maxWidth: .infinity, alignment: .leading)
                                      .overlay(
                                          RoundedRectangle(cornerRadius: 10)
                                              .stroke(Color.gray, lineWidth: 0.5)
                                      )
                                      .shadow(radius: 3)
                                  
                                  Spacer()
                                  
                                  Image(systemName: "chevron.right")
                                      .foregroundColor(.gray)
                              }
                          }
                      }
                      .onDelete(perform: deleteDevice)
                      
                      NavigationLink(destination: ContentView1()) {
                          Text("Device 1")
                      }
                      NavigationLink(destination: ContentView2()) {
                          Text("Device 2")
                      }
                      NavigationLink(destination: ContentView3()) {
                          Text("Device 3")
                      }
                  }
                  .listStyle(.insetGrouped)
              }
              .navigationBarItems(trailing: EditButton())
          }
      }

    func deleteDevice(at offsets: IndexSet) {
        devices.remove(atOffsets: offsets)
    }
    
    func addDevice(_ newDevice : Device) {
        devices.append(newDevice)
    }
}

struct DeviceView: View {
    let device: Device

    var body: some View {
        if (device.id == 1){
            Text("Im not a garage")
        }
        else {
            ContentView1()
        }
    
    }
}

struct ProfileView: View {
    var body: some View {
        Text("Profile Page")
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewLayout(.sizeThatFits)
    }
}
