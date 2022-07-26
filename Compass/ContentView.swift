//
//  ContentView.swift
//  Compass
//
//  Created by Ryo on 2022/07/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var manager = LocationManager()
    @State var region = MKCoordinateRegion()
    @State var trackingMode = MapUserTrackingMode.follow
    
    var body: some View {
        let heading   = $manager.heading.wrappedValue
        //緯度
        let latitude  = $region.center.latitude.wrappedValue
        let longitude = $region.center.longitude.wrappedValue
        
        ZStack {
            
            VStack{
                
                
                Spacer(minLength: 800)
                Map(coordinateRegion: $region,
                    showsUserLocation: true,
                    userTrackingMode: $trackingMode)
                
                
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                
    
                
                .clipShape(Circle())
                
                .rotationEffect(Angle(degrees: -heading))
                
                
                //            .clipped()
                //            .mask(
                //                Image("halfCircle")
                //                 .resizable()
                //    //             .frame(width: 100, height: 100, alignment: .trailing)
                //                 .scaledToFit()
                //            )
                
                //                .overlay(Circle().stroke(Color.white, lineWidth: 4))
                //                .shadow(radius: 10)
                //                .padding(40)
                //                .edgesIgnoringSafeArea(.bottom)
            }
            
            VStack{
                            Text("緯度：\(latitude) 経度： \(longitude)")
                    .onChange(of: latitude) { newValue in
                  
                        manager.kakudo = manager.angle(currentLatitude: latitude, currentLongitude: longitude, targetLatitude: 35.766402, targetLongitude: 139.650894)
                    }
                //            Text("北方向: \(heading)")
                Text("\(heading)")
                Text("方位角\(manager.kakudo)")
//                Text("\(-heading + Double(manager.kakudo))")
                
                
                
//                if(Int(heading)<manager.kakudo){
                    ZStack{
                        Image(systemName: "location.north")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(/*@START_MENU_TOKEN@*/.all, 100.0/*@END_MENU_TOKEN@*/)
                        Text("aaaa")
                    }
                    
                    .rotationEffect(Angle(degrees:  Double(manager.kakudo)-heading))
//                }else if(Int(heading)>manager.kakudo){
//                    Image(systemName: "location.north")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .padding(/*@START_MENU_TOKEN@*/.all, 100.0/*@END_MENU_TOKEN@*/)
//                    .rotationEffect(Angle(degrees:  Double(manager.kakudo)+heading))
//                }
                    
//                    .rotationEffect(Angle(degrees:Double(manager.kakudo)))
                
                
                
                
            }
        }
    }
}





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
