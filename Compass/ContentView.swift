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
                //            Text("緯度：\(latitude) 経度： \(longitude)")
                //            Text("北方向: \(heading)")
                //            Tex()
                
                Image(systemName: "location.north")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(/*@START_MENU_TOKEN@*/.all, 100.0/*@END_MENU_TOKEN@*/)
                    .rotationEffect(Angle(degrees: -heading))
                
                
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
